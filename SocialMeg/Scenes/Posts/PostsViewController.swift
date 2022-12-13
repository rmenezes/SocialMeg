import UIKit
import SwiftUI

final class PostsViewController<
    ViewModel: PostsViewModeling & ObservableObject
>: UIViewController {
    let viewModel: ViewModel
    
    init(
        viewModel: ViewModel
    ) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Posts"
        
        setRootView(
            content: PostsView(viewModel: viewModel)
        )
    }
}

