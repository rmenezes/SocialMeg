import UIKit

final class AppCoordinator {
    private var window: UIWindow?
    private var rootViewController: UIViewController?
    private var factory: AppSceneFactoring
    private let appService: AppStartupServicing
    
    // MARK: - Init
    
    init(
        window: UIWindow,
        factory: AppSceneFactoring,
        appService: AppStartupServicing
    ) {
        self.window = window
        self.factory = factory
        self.appService = appService
    }
}

// MARK: - Coordinating

extension AppCoordinator: Coordinating {
    @MainActor func start() {
        Task {
            do {
                try await appService.start()
                
                rootViewController = factory.makePosts(
                    actions: PostActions(
                        postDetails: { [weak self] in
                            self?.navigateToPostDetails(post: $0)
                        }
                    )
                )
            } catch {
                rootViewController = factory.makeError()
            }
            
            window?.rootViewController = self.rootViewController
            window?.makeKeyAndVisible()
        }
    }
}

// MARK: - Private

private extension AppCoordinator {
    func navigateToPostDetails(
        post: Post
    ) {
        guard
            let rootViewController
        else { return }
        
        let coordinator = PostDetailsCoordinator(
            viewController: rootViewController,
            entryData: PostDetailsCoordinator.EntryData(post: post)
        )
        
        coordinator.start()
    }
}
