import SwiftUI

extension PostDetailView_Previews {
    final class ViewModel: PostDetailsViewModeling & ObservableObject {
        func likePost(postId: Int) {
            
        }
        
        let post: Post = Post(
            id: 1,
            userId: 1,
            title: "Some Title",
            body: "Some content",
            author: "Raul Menezes",
            isLiked: true,
            numberOfLikes: 0
        )
        let comments: [Comment] = (0...10).map {
            Comment(
                id: $0,
                userId: $0,
                name: "Raul Menezes",
                username: "raul@rmenezes.me",
                email: "raul@rmenezes.me",
                body: "Nice post"
            )
        }
        
        func load() async { }
    }
}
