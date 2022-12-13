import UIKit
import SwiftUI

extension UIViewController {
    func setRootView<content: View>(
        content: content
    ) {
        let controller = UIHostingController(
            rootView: content
        )
        
        view.addSubview(controller.view)
        addChild(controller)
        willMove(toParent: controller)
        
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            controller.view.topAnchor.constraint(equalTo: view.topAnchor),
            controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
