import SwiftUI
import UIKit

protocol AppSceneFactoring {
    func makePosts(
        actions: PostActions
    ) -> UIViewController
    func makeError() -> UIViewController
}

struct PostActions {
    let postDetails: (Post) -> Void
}

struct AppSceneFactory: AppSceneFactoring {
    let appContainer: AppContainer
    
    func makePosts(
        actions: PostActions
    ) -> UIViewController {
        let viewModel = PostsViewModel(
            postService: PostService(
                dataProvider: appContainer.dataProvider()
            ),
            userRepository: appContainer.userRepository(),
            actions: actions
        )
        
        return UINavigationController(
            rootViewController: PostsViewController(
                viewModel: viewModel
            )
        )
    }
    
    func makeError() -> UIViewController {
        let controller = UIHostingController(rootView: ErrorView())
        return controller
    }
}
