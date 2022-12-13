import XCTest

final class PostUITests: BaseUITests {
    func test_whenApplicationLaunch_thenSeePosts() {
        thenIShouldSeeAListOfPosts()
    }
}
