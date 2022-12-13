import UIKit

protocol PostDetailsFactoring {
    func makePostDetails(
        post: Post
    ) -> UIViewController
}

struct PostDetailsFactory: PostDetailsFactoring {
    let appContainer: AppContainer
    
    func makePostDetails(
        post: Post
    ) -> UIViewController {
        let viewModel = PostDetailViewModel(
            post: post,
            userRepository: appContainer.userRepository(),
            commentsService: CommentService(
                dataProvider: appContainer.dataProvider()
            )
        )
        
        return PostDetailsViewController(
            viewModel: viewModel
        )
    }
}
