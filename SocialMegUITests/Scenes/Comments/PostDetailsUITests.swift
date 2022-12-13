import XCTest

final class PostDetailsUITests: BaseUITests {
    func test_whenPostSelected_thenShowComments() {
        whenITapOnAPost()
        thenIShouldSeeTheOriginalPost()
        thenIShouldSeeTheComments()
    }
}
