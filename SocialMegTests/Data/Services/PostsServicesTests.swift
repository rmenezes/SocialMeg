import XCTest
@testable import SocialMeg

final class PostsServicesTests: XCTestCase {
    private var sut: PostService!
    private var dataProvider: StubDataProvider!
    
    override func tearDown() {
        super.tearDown()
        dataProvider = nil
        sut = nil
    }
    
    func test_whenValidResponse_thenReturnPosts() async {
        // Given
        makeSUT(endpoint: .posts)
        
        // When
        let posts = await sut.fetchPosts()
        
        // Then
        XCTAssertEqual(posts.count, 2)
    }
    
    func test_whenInvalidResponse_thenReturnNoPosts() async {
        // Given
        makeSUT(endpoint: .empty)
        
        // When
        let posts = await sut.fetchPosts()
        
        // Then
        XCTAssertEqual(posts.count, 0)
    }
}

// MARK: - Helpers

private extension PostsServicesTests {
    func makeSUT(
        endpoint: StubDataProvider.StubEndpoint
    ) {
        dataProvider = StubDataProvider(endpoint: endpoint)
        sut = PostService(
            dataProvider: dataProvider
        )
    }
}
