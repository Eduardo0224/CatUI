//
//  ImageCacheServiceProtocol.swift
//  CatUI
//
//  Created by Eduardo Andrade on 21/01/26.
//

import Foundation
import UIKit

/// Protocol for image caching service with memory and disk persistence
public protocol ImageCacheServiceProtocol: Sendable {

    // MARK: - Functions

    /// Fetches an image from cache or downloads it if not cached
    /// - Parameters:
    ///   - url: The URL of the image to fetch
    ///   - maxWidth: Optional maximum width in logical points for resizing. Uses default if nil
    /// - Returns: The cached or downloaded UIImage
    /// - Throws: Error if download fails or image data is invalid
    func image(for url: URL, maxWidth: CGFloat?) async throws -> UIImage

    /// Gets the file URL for a cached image
    /// - Parameter url: The source URL of the image
    /// - Returns: The local file URL where the image is cached
    func getFileURL(for url: URL) -> URL

    /// Returns the cached image from disk if it exists and is valid
    /// - Parameter url: The source URL of the image
    /// - Returns: The cached UIImage, or nil if not cached or invalid
    func cachedImage(for url: URL) -> UIImage?

    /// Clears all cached images from memory and disk
    func clearCache() async
}
