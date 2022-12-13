extension String {
    struct AccessibilityIdentifier {}
}

// MARK: - Posts

extension String.AccessibilityIdentifier {
    struct Post {
        static let title = "post_name"
        static let author = "post_email"
        static let text = "post_body"
        static let avatar = "post_avatar"
    }
}

// MARK: - Comments

extension String.AccessibilityIdentifier {
    struct Comment {
        static let name = "comment_name"
        static let email = "comment_email"
        static let comment = "comment_body"
        static let avatar = "comment_avatar"
    }
}
