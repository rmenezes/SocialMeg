import SwiftUI

struct PostView: View {
    let userId: Int
    let author: String
    let title: String
    let text: String
    let isPostLiked: Bool
    let numberOfLikes: Int
    
    let onPostLiked: () -> Void
    
    var body: some View {
        HStack(
            alignment: .bottom,
            spacing: .Spacing.xs
        ) {
            VStack(
                alignment: .leading,
                spacing: .Spacing.xxs
            ) {
                Text(title)
                    .font(.title)
                    .foregroundColor(.Text.primary)
                    .accessibilityIdentifier(.AccessibilityIdentifier.Post.title)
                    .accessibilityElement(children: .contain)
                Text(author)
                    .font(.caption2)
                    .foregroundColor(.Text.primary)
                    .accessibilityIdentifier(.AccessibilityIdentifier.Post.author)
                    .accessibilityElement(children: .contain)
                Text(text)
                    .font(.body)
                    .foregroundColor(.Text.secondary)
                    .accessibilityIdentifier(.AccessibilityIdentifier.Post.text)
                    .accessibilityElement(children: .contain)
            }
            .padding(.trailing, .Spacing.md)
            
            Spacer()
            
            AvatarView(userId: userId)
                .padding(.top, .Spacing.xs)
                .accessibilityIdentifier(.AccessibilityIdentifier.Post.avatar)
                .accessibilityElement(children: .combine)
            
            LikeButton(onLike: {
                onPostLiked()
            }, isLiked: isPostLiked, numberOfLikes: numberOfLikes)
        }
        .padding(.vertical, .Spacing.xs)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(
            userId: 1,
            author: "Raul Menezes",
            title: "My title",
            text: "Some cool text here",
            isPostLiked: false,
            numberOfLikes: 0, onPostLiked: {}
        )
    }
}
