import UIKit
import SwiftUI

final class PostDetailsViewController<
    ViewModel: PostDetailsViewModeling & ObservableObject
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
        
        title = viewModel.post.author
        
        setRootView(
            content: PostDetailView(viewModel: viewModel)
        )
    }
}

