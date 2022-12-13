import XCTest

extension PostDetailsUITests {
    func whenITapOnAPost() {
        XCTContext.runActivity(named: "When I tap on a post") { _ in
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
            
            element.tap()
        }
    }
    
    func thenIShouldSeeTheOriginalPost() {
        XCTContext.runActivity(named: "Then I should see the comments") { _ in
            let element = app.otherElements[.AccessibilityIdentifier.PostDetailsScene.post(1)].firstMatch
            
            XCTAssertTrue(element.waitForExistence(timeout: 2))
        }
    }
    
    func thenIShouldSeeTheComments() {
        XCTContext.runActivity(named: "Then I should see the comments") { _ in
            let element = app.otherElements[.AccessibilityIdentifier.PostDetailsScene.comment(1)].firstMatch
            
            XCTAssertTrue(element.waitForExistence(timeout: 2))
            
            let nameElement = element.staticTexts[.AccessibilityIdentifier.Comment.name]
            let emailElement = element.staticTexts[.AccessibilityIdentifier.Comment.email]
            let commentElement = element.staticTexts[.AccessibilityIdentifier.Comment.comment]
            let avatarElement = element.images[.AccessibilityIdentifier.Comment.avatar]
            
            XCTAssertTrue(nameElement.waitForExistence(timeout: 2))
            XCTAssertTrue(emailElement.waitForExistence(timeout: 2))
            XCTAssertTrue(commentElement.waitForExistence(timeout: 2))
            XCTAssertTrue(avatarElement.waitForExistence(timeout: 2))
        }
    }
}
