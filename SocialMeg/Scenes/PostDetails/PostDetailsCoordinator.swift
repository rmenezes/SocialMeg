import UIKit
import SwiftUI

struct PostDetailsCoordinator: Coordinating {
    private let viewController: UIViewController
    private let entryData: EntryData
    private let factory: PostDetailsFactoring
    
    struct EntryData {
        let post: Post
    }
    
    init(
        viewController: UIViewController,
        entryData: EntryData,
        factory: PostDetailsFactoring = PostDetailsFactory(
            appContainer: appContainer
        )
    ) {
        self.viewController = viewController
        self.entryData = entryData
        self.factory = factory
    }
}

// MARK: - Coordinating

extension PostDetailsCoordinator {
    func start() {
        guard
            let navigation = viewController as? UINavigationController
        else { return }
        
        navigation.pushViewController(
            factory.makePostDetails(
                post: entryData.post
            ),
            animated: true
        )
    }
}
