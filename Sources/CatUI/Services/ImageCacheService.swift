//
//  ImageCacheService.swift
//  CatUI
//
//  Created by Eduardo Andrade on 21/01/26.
//

import Foundation
import CryptoKit
import UIKit

/// Actor-based image caching service with memory and disk persistence
public actor ImageCacheService: ImageCacheServiceProtocol {

    // MARK: - Properties

    /// Shared singleton instance
    public static let shared = ImageCacheService()

    private enum ImageStatus {
        case downloading(task: Task<UIImage, any Error>)
        case downloaded(image: UIImage)
    }

    private var cache: [URL: ImageStatus] = [:]
    private var failedURLs: Set<URL> = []

    /// Default maximum image width for resizing (150pt)
    private let defaultMaxImageWidth: CGFloat = 150

    /// Maximum number of images kept in memory cache
    private let memoryCacheLimit = 100

    /// Subdirectory inside Caches for organized storage
    private static let cacheDirectoryName = "CatUIImageCache"

    // MARK: - Initializers

    private init() {}

    // MARK: - Public Functions

    /// Fetches an image from cache or downloads it if not cached
    /// - Parameters:
    ///   - url: The URL of the image to fetch
    ///   - maxWidth: Maximum width in logical points. Automatically multiplied by screen scale
    ///     for sharp rendering on Retina displays. Uses default (150pt) if nil
    /// - Returns: The cached or downloaded UIImage
    /// - Throws: Error if download fails or image data is invalid
    public func image(for url: URL, maxWidth: CGFloat? = nil) async throws -> UIImage {
        if failedURLs.contains(url) {
            throw URLError(.badServerResponse)
        }

        if let status = cache[url] {
            switch status {
            case .downloading(let task):
                return try await task.value
            case .downloaded(let image):
                return image
            }
        }

        let task = Task {
            try await downloadImage(url: url)
        }

        cache[url] = .downloading(task: task)

        do {
            let image = try await task.value

            let baseWidth = maxWidth ?? defaultMaxImageWidth
            let scale = await Self.screenScale
            let targetWidth = baseWidth * scale
            let imageToCache: UIImage
            if let resized = await image.resize(width: targetWidth) {
                imageToCache = resized
            } else {
                imageToCache = image
            }

            evictMemoryCacheIfNeeded()
            cache[url] = .downloaded(image: imageToCache)

            try await saveImageToDisk(url: url, image: imageToCache)

            return imageToCache
        } catch {
            cache.removeValue(forKey: url)
            failedURLs.insert(url)
            throw error
        }
    }

    /// Gets the file URL for a cached image using SHA-256 hash of the URL
    /// - Parameter url: The source URL of the image
    /// - Returns: The local file URL where the image is cached
    nonisolated public func getFileURL(for url: URL) -> URL {
        let hash = SHA256.hash(data: Data(url.absoluteString.utf8))
        let filename = hash.compactMap { String(format: "%02x", $0) }.joined()
        return cacheDirectoryURL.appending(path: "\(filename).png")
    }

    /// Returns the cached image from disk if it exists and is valid
    /// - Parameter url: The source URL of the image
    /// - Returns: The cached UIImage, or nil if not cached or invalid
    nonisolated public func cachedImage(for url: URL) -> UIImage? {
        let fileURL = getFileURL(for: url)
        guard FileManager.default.fileExists(atPath: fileURL.path()),
              let data = try? Data(contentsOf: fileURL),
              let image = UIImage(data: data) else {
            return nil
        }
        guard image.size.width > 0, image.size.height > 0 else {
            try? FileManager.default.removeItem(at: fileURL)
            return nil
        }
        return image
    }

    /// Clears all cached images from memory and disk
    public func clearCache() async {
        cache.removeAll()
        failedURLs.removeAll()

        let fileManager = FileManager.default
        let directory = cacheDirectoryURL

        guard fileManager.fileExists(atPath: directory.path()) else { return }

        do {
            let fileURLs = try fileManager.contentsOfDirectory(
                at: directory,
                includingPropertiesForKeys: nil
            )

            for fileURL in fileURLs {
                try fileManager.removeItem(at: fileURL)
            }
        } catch {
            // Silently fail - cache clearing is not critical
        }
    }

    // MARK: - Private Properties

    /// Dedicated cache subdirectory URL
    nonisolated private var cacheDirectoryURL: URL {
        let directory = URL.cachesDirectory.appending(path: Self.cacheDirectoryName)
        if !FileManager.default.fileExists(atPath: directory.path()) {
            try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        }
        return directory
    }

    /// Screen scale factor from the current trait collection
    @MainActor
    private static var screenScale: CGFloat {
        UITraitCollection.current.displayScale
    }

    // MARK: - Private Functions

    /// Evicts oldest downloaded images from memory when limit is exceeded
    private func evictMemoryCacheIfNeeded() {
        let downloadedCount = cache.values.filter {
            if case .downloaded = $0 { return true }
            return false
        }.count

        guard downloadedCount >= memoryCacheLimit else { return }

        let keysToRemove = cache.compactMap { key, value -> URL? in
            if case .downloaded = value { return key }
            return nil
        }.prefix(memoryCacheLimit / 4)

        for key in keysToRemove {
            cache.removeValue(forKey: key)
        }
    }

    private func downloadImage(url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }

        return image
    }

    private func saveImageToDisk(url: URL, image: UIImage) async throws {
        guard image.size.width > 0, image.size.height > 0 else {
            return
        }

        guard let data = image.pngData() else {
            return
        }

        let fileURL = getFileURL(for: url)
        try data.write(to: fileURL, options: .atomic)
    }
}

// MARK: - UIImage Extension

extension UIImage {

    /// Resizes the image to the specified width while maintaining aspect ratio
    /// - Parameter width: The target width in pixels
    /// - Returns: The resized UIImage, or nil if resizing fails
    func resize(width: CGFloat) async -> UIImage? {
        guard size.width > 0, size.height > 0, width > 0 else {
            return nil
        }

        let scale = min(1, width / size.width)
        let targetSize = CGSize(
            width: size.width * scale,
            height: size.height * scale
        )

        guard targetSize.width > 0, targetSize.height > 0 else {
            return nil
        }

        return await byPreparingThumbnail(ofSize: targetSize)
    }
}
