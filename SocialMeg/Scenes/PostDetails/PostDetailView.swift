import SwiftUI

struct PostDetailView<
    ViewModel: PostDetailsViewModeling & ObservableObject
>: View {
    @ObservedObject var viewModel: ViewModel
    
    init(
        viewModel: ViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            PostView(
                userId: viewModel.post.userId,
                author: viewModel.post.author,
                title: viewModel.post.title,
                text: viewModel.post.body,
                isPostLiked: viewModel.post.isLiked,
                numberOfLikes: viewModel.post.numberOfLikes,
                onPostLiked: {
                    viewModel.likePost(postId: viewModel.post.id)
                }
            )
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier(.AccessibilityIdentifier.PostDetailsScene.post(viewModel.post.id))
            
            Divider()
                .foregroundColor(.System.separator)
            
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(viewModel.comments, id: \.id) { comment in
                        let last = viewModel.comments.last?.id
                        
                        CommentView(
                            userId: comment.userId,
                            name: comment.name,
                            email: comment.email,
                            comment: comment.body
                        )
                        .accessibilityElement(children: .contain)
                        .accessibilityIdentifier(.AccessibilityIdentifier.PostDetailsScene.comment(viewModel.post.id))
                        
                        if comment.id != last {
                            Divider()
                                .foregroundColor(.System.separator)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, .Spacing.sm)
        .task {
            await viewModel.load()
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(viewModel: ViewModel())
    }
}
