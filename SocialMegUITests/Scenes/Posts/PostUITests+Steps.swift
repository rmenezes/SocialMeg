import XCTest

extension PostUITests {
    func thenIShouldSeeAListOfPosts() {
        XCTContext.runActivity(named: "Then I should see a list of posts") { _ in
            let element = app.otherElements[.AccessibilityIdentifier.PostsScene.post(1)].firstMatch
            
            XCTAssertTrue(element.waitForExistence(timeout: 2))
            
            let titleElement = element.staticTexts[.AccessibilityIdentifier.Post.title]
            let authorElement = element.staticTexts[.AccessibilityIdentifier.Post.author]
            let textElement = element.staticTexts[.AccessibilityIdentifier.Post.text]
            let avatarElement = element.images[.AccessibilityIdentifier.Post.avatar]
            
            XCTAssertTrue(titleElement.waitForExistence(timeout: 2))
            XCTAssertTrue(authorElement.waitForExistence(timeout: 2))
            XCTAssertTrue(textElement.waitForExistence(timeout: 2))
            XCTAssertTrue(avatarElement.waitForExistence(timeout: 2))
        }
    }
}
