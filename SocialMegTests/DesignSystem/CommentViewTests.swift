import XCTest
import SwiftUI
import SnapshotTesting

@testable import SocialMeg

final class CommentViewTests: XCTestCase {
    func test_CommentView() {
        let sut = CommentView(
            userId: 1,
            name: "Raul Menezes",
            email: "raul@rmenezes.me",
            comment:
"""
Felis catus is your taxonomic nomenclature,
An endothermic quadruped, carnivorous by nature;
Your visual, olfactory, and auditory senses
Contribute to your hunting skills and natural defenses.
"""
        )
        
        let controller = UIHostingController(rootView: sut)
        
        assertSnapshot(matching: controller, as: .image)
    }
}
