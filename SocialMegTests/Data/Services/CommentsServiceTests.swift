import XCTest
@testable import SocialMeg

final class CommentsServiceTests: XCTestCase {
    private var sut: CommentService!
    private var dataProvider: StubDataProvider!
    
    override func tearDown() {
        super.tearDown()
        dataProvider = nil
        sut = nil
    }
    
    func test_whenValidResponse_thenReturnComments() async {
        // Given
        makeSUT(endpoint: .comments)
        
        // When
        let comments = await sut.fetchComments(postId: 1)
        
        // Then
        XCTAssertEqual(comments.count, 5)
    }
    
    func test_whenInvalidResponse_thenReturnNoComments() async {
        // Given
        makeSUT(endpoint: .empty)
        
        // When
        let comments = await sut.fetchComments(postId: 1)
        
        // Then
        XCTAssertEqual(comments.count, 0)
    }
}

// MARK: - Helpers

private extension CommentsServiceTests {
    func makeSUT(
        endpoint: StubDataProvider.StubEndpoint
    ) {
        dataProvider = StubDataProvider(endpoint: endpoint)
        sut = CommentService(
            dataProvider: dataProvider
        )
    }
}
