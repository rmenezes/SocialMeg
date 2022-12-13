import XCTest
import SnapshotTesting

@testable import SocialMeg

final class AvatarViewTests: XCTestCase {
    func test_AvatarView() {
        let sut = AvatarView(userId: 1)
        
        assertSnapshot(matching: sut, as: .image)
    }
}
