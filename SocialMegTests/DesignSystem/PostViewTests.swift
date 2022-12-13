import XCTest
import SwiftUI
import SnapshotTesting

@testable import SocialMeg

final class PostViewTests: XCTestCase {
    func test_PostView() {
        let sut = PostView(
            userId: 1,
            author: "Raul Menezes",
            title: "Ode to Spot",
            text:
"""
Felis catus is your taxonomic nomenclature,
An endothermic quadruped, carnivorous by nature;
Your visual, olfactory, and auditory senses
Contribute to your hunting skills and natural defenses.
""",
            isPostLiked: false,
            numberOfLikes: 0, onPostLiked: { }
        )
        
        let controller = UIHostingController(rootView: sut)
        
        assertSnapshot(matching: controller, as: .image)
    }
}
