import SwiftUI

extension PostsView_Previews {
    final class ViewModel: PostsViewModeling & ObservableObject {
        func likePost(post: Post) {
            
        }
        
        let posts: [Post] = (0...10).map {
            Post(
                id: $0,
                userId: $0,
                title: "Some Title",
                body: "Some cool text here",
                author: "Raul Menezes",
                isLiked: true,
                numberOfLikes: 0
            )
        }
        func load() async { }
        func showDetails(post: Post) { }
    }
}
