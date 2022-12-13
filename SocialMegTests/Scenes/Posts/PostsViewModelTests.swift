import XCTest
@testable import SocialMeg

final class PostsViewModelTests: XCTestCase {
    private var sut: PostsViewModel!
    private var service: StubPostService!
    private var repository: StubUserRepository!
    
    override func setUp() {
        super.setUp()
    }
    
    func test_whenLoad_thenDisplayPosts() async {
        // Given
        makeSUT(
            actions: PostActions(
                postDetails: { _ in }
            )
        )
        
        // When
        await sut.load()
        
        // Then
        XCTAssertEqual(sut.posts.count, 2)
        XCTAssertEqual(service.fetchPostCallCount, 1)
        XCTAssertEqual(repository.fetchUsersCallsCount, 1)
    }
    
    func test_whenFailToLoadPosts_thenDisplayNoPosts() async {
        // Given
        makeSUT(
            actions: PostActions(
                postDetails: { _ in }
            ),
            scope: .exception
        )
        
        // When
        await sut.load()
        
        // Then
        XCTAssertEqual(sut.posts.count, 0)
        XCTAssertEqual(service.fetchPostCallCount, 1)
        XCTAssertEqual(repository.fetchUsersCallsCount, 1)
    }
    
    func test_whenPostSelected_thenTriggerAction() async throws {
        // Given
        var post: Post?
        var detailsCallCount = 0
        makeSUT(
            actions: PostActions(
                postDetails: {
                    post = $0
                    detailsCallCount += 1
                }
            )
        )
        
        await sut.load()
        
        // When
        sut.showDetails(post: sut.posts[0])
        
        // Then
        let selected = try XCTUnwrap(post)
        
        XCTAssertEqual(selected, sut.posts[0])
        XCTAssertEqual(detailsCallCount, 1)
    }
    
    func test_whenLikePost_thenUpdatePostStatus() async throws {
        // Given
        makeSUT(
            actions: PostActions(
                postDetails: { _ in }
            )
        )
        
        // When
        await sut.load()
        
        let post = try XCTUnwrap(sut.posts.first)
        
        XCTAssertEqual(post.numberOfLikes, 0)
        XCTAssertEqual(post.isLiked, false)
        
        sut.likePost(post: post)
        
        let post2 = try XCTUnwrap(sut.posts.first)
        
        // Then
        XCTAssertEqual(post2.id, post.id)
        XCTAssertEqual(post2.numberOfLikes, 1)
        XCTAssertEqual(post2.isLiked, true)
    }
}

// MARK: - Private

private extension PostsViewModelTests {
    func makeSUT(
        actions: PostActions,
        scope: StubPostService.Scope = .users
    ) {
        service = StubPostService(scope: scope)
        repository = StubUserRepository()
        
        sut = PostsViewModel(
            postService: service,
            userRepository: repository,
            actions: actions
        )
    }
}

// MARK: - Helpers

extension Post: Equatable {
    public static func == (
        lhs: Post,
        rhs: Post
    ) -> Bool {
        lhs.id == rhs.id
    }
}
