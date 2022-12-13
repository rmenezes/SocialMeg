extension String.AccessibilityIdentifier {
    struct PostDetailsScene {
        public static func post(_ id: Int) -> String {
            "postsdetails-post-\(id)"
        }
        
        public static func comment(_ id: Int) -> String {
            "postsdetails-comment-\(id)"
        }
    }
}
