import UIKit

// MARK: - CatVoteCellConfiguration

/// Card-style content configuration for a vote list cell.
/// Renders a rounded card with breed thumbnail, name, date, and vote icon.
///
/// Usage with UICollectionViewListCell:
///   cell.contentConfiguration = CatVoteCellConfiguration(
///       breedName: "Bengal", imageURL: url, voteType: .like, date: Date()
///   )
public struct CatVoteCellConfiguration: UIContentConfiguration, Hashable {

    // MARK: - VoteType

    public enum VoteType {
        case like
        case dislike

        var icon: String {
            switch self {
            case .like: "hand.thumbsup.fill"
            case .dislike: "hand.thumbsdown.fill"
            }
        }

        var color: UIColor {
            switch self {
            case .like: .catAccent
            case .dislike: .catTextSecondary
            }
        }
    }

    // MARK: - Properties

    let breedName: String
    let imageURL: URL?
    let voteType: VoteType
    let date: Date

    // MARK: - UIContentConfiguration

    public func makeContentView() -> UIView & UIContentView {
        CatVoteCellContentView(configuration: self)
    }

    public func updated(for state: UIConfigurationState) -> Self {
        self
    }

    // MARK: - Initializers

    public init(breedName: String, imageURL: URL? = nil, voteType: VoteType, date: Date) {
        self.breedName = breedName
        self.imageURL = imageURL
        self.voteType = voteType
        self.date = date
    }
}

// MARK: - CatVoteCellContentView

private final class CatVoteCellContentView: UIView, UIContentView {

    // MARK: - Properties

    private var currentConfiguration: CatVoteCellConfiguration

    var configuration: UIContentConfiguration {
        get { currentConfiguration }
        set {
            guard let config = newValue as? CatVoteCellConfiguration else { return }
            apply(config)
        }
    }

    // MARK: - Private Views (closure-based init)

    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .catSurfaceSecondary
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.06
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let breedImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.backgroundColor = .catSeparator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let breedLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "Coolvetica-Regular", size: 17)
            ?? UIFont.preferredFont(forTextStyle: .headline)
        label.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .catTextPrimary
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "Coolvetica-Regular", size: 12)
            ?? UIFont.preferredFont(forTextStyle: .caption1)
        label.font = UIFontMetrics(forTextStyle: .caption1).scaledFont(for: font)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .catTextSecondary
        return label
    }()

    private let voteIconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        return view
    }()

    private let textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        return stack
    }()

    private let rowStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: - Initializers

    init(configuration: CatVoteCellConfiguration) {
        self.currentConfiguration = configuration
        super.init(frame: .zero)
        setupViews()
        apply(configuration)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

    // MARK: - Setup

    private func setupViews() {
        textStack.addArrangedSubview(breedLabel)
        textStack.addArrangedSubview(dateLabel)

        rowStack.addArrangedSubview(breedImageView)
        rowStack.addArrangedSubview(textStack)
        rowStack.addArrangedSubview(voteIconView)

        cardView.addSubview(rowStack)
        addSubview(cardView)

        NSLayoutConstraint.activate([
            // Card fills content with horizontal margins (gap between cells)
            cardView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            cardView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 4),
            cardView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -4),

            // Row inside card with padding
            rowStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            rowStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            rowStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            rowStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12),

            // Fixed thumbnail size
            breedImageView.widthAnchor.constraint(equalToConstant: 56),
            breedImageView.heightAnchor.constraint(equalToConstant: 56),

            // Fixed icon size
            voteIconView.widthAnchor.constraint(equalToConstant: 32)
        ])
    }

    // MARK: - Apply

    private func apply(_ config: CatVoteCellConfiguration) {
        currentConfiguration = config
        breedLabel.text = config.breedName
        dateLabel.text = config.date.formatted(date: .numeric, time: .omitted)
        voteIconView.image = UIImage(systemName: config.voteType.icon)
        voteIconView.tintColor = config.voteType.color

        // Load image asynchronously
        if let url = config.imageURL {
            loadImage(from: url)
        } else {
            breedImageView.image = nil
        }
    }

    // MARK: - Image Loading

    private func loadImage(from url: URL) {
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 15)

        URLSession.shared.dataTask(with: request) { [weak self] data, _, _ in
            guard let self, let data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                // Verify this view still has the same URL before applying
                guard self.currentConfiguration.imageURL == url else { return }
                self.breedImageView.image = image
            }
        }.resume()
    }
}

// MARK: - Preview

#if canImport(SwiftUI)
import SwiftUI

private struct VoteCellPreview: UIViewRepresentable {
    let breedName: String
    let voteType: CatVoteCellConfiguration.VoteType

    func makeUIView(context: Context) -> UIView {
        CatFontRegistration.registerAll() // ← registers fonts for UIKit previews

        let container = UIView()
        container.backgroundColor = .catSurfacePrimary
        container.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)

        let config = CatVoteCellConfiguration(
            breedName: breedName,
            imageURL: URL(string: "https://cdn2.thecatapi.com/images/beng.jpg"),
            voteType: voteType,
            date: Date()
        )
        let contentView = config.makeContentView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: container.layoutMarginsGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: container.layoutMarginsGuide.trailingAnchor),
            contentView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            container.heightAnchor.constraint(equalToConstant: 100)
        ])

        return container
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

#Preview("Vote Cell — Like", traits: .catUIFonts, .sizeThatFitsLayout) {
    VoteCellPreview(breedName: "Bengal", voteType: .like)
}

#Preview("Vote Cell — Dislike", traits: .sizeThatFitsLayout) {
    VoteCellPreview(breedName: "Siamese", voteType: .dislike)
}
#endif
