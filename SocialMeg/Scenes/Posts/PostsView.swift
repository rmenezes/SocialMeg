import SwiftUI

struct PostsView<
    ViewModel: PostsViewModeling & ObservableObject
>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.posts, id: \.id) { post in
                    let last = viewModel.posts.last?.id
                    PostView(
                        userId: post.userId,
                        author: post.author,
                        title: post.title,
                        text: post.body,
                        isPostLiked: post.isLiked,
                        numberOfLikes: post.numberOfLikes,
                        onPostLiked: {
                            viewModel.likePost(post: post)
                        }
                    )
                    .onTapGesture {
                        viewModel.showDetails(post: post)
                    }
                    .accessibilityElement(children: .contain)
                    .accessibilityIdentifier(.AccessibilityIdentifier.PostsScene.post(post.id))
                    
                    if post.id != last {
                        Divider()
                            .foregroundColor(.System.separator)
                    }
                }
            }
            .padding(.horizontal, .Spacing.sm)
        }
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView(viewModel: ViewModel())
    }
}
