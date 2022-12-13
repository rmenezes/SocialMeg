import XCTest
@testable import SocialMeg

final class PostDetailsViewModelTests: XCTestCase {
    private var sut: PostDetailViewModel!
    private var service: StubCommentsService!
    private var repository: StubUserRepository!
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
        service = nil
        repository = nil
    }
    
    func test_whenLoad_thenDisplayComments() async {
        // Given
        makeSUT()
        
        // When
        await sut.load()
        
        // Then
        XCTAssertEqual(sut.comments.count, 5)
        XCTAssertEqual(service.fetchCommentsCallsCount, 1)
        XCTAssertEqual(repository.fetchUsersCallsCount, 1)
    }
    
    func test_whenFailToLoadPosts_thenDisplayNoComments() async {
        // Given
        makeSUT(scope: .exception)
        
        // When
        await sut.load()
        
        // Then
        XCTAssertEqual(sut.comments.count, 0)
        XCTAssertEqual(service.fetchCommentsCallsCount, 1)
        XCTAssertEqual(repository.fetchUsersCallsCount, 1)
    }
}

// MARK: - Private

private extension PostDetailsViewModelTests {
    func makeSUT(
        scope: StubCommentsService.Scope = .comments
    ) {
        service = StubCommentsService(scope: scope)
        repository = StubUserRepository()
        
        sut = PostDetailViewModel(
            post: Post(
                id: 1,
                userId: 1,
                title: "Post Title",
                body: "some test",
                author: "Raul Menezes",
                isLiked: false,
                numberOfLikes: 0
            ),
            userRepository: repository,
            commentsService: service
        )
    }
}

// MARK: - Helpers

extension Comment: Equatable {
    public static func == (
        lhs: Comment,
        rhs: Comment
    ) -> Bool {
        lhs.id == rhs.id
    }
}
