import XCTest
@testable import SocialMeg

final class UserServiceTests: XCTestCase {
    private var sut: UserService!
    private var dataProvider: StubDataProvider!
    
    override func tearDown() {
        super.tearDown()
        dataProvider = nil
        sut = nil
    }
    
    func test_whenValidResponse_thenReturnUsers() async {
        // Given
        makeSUT(endpoint: .users)
        
        // When
        let users = await sut.fetchUsers()
        
        // Then
        XCTAssertEqual(users.count, 1)
    }
    
    func test_whenInvalidResponse_thenReturnNoUsers() async {
        // Given
        makeSUT(endpoint: .empty)
        
        // When
        let users = await sut.fetchUsers()
        
        // Then
        XCTAssertEqual(users.count, 0)
    }
}

// MARK: - Helpers

private extension UserServiceTests {
    func makeSUT(
        endpoint: StubDataProvider.StubEndpoint
    ) {
        dataProvider = StubDataProvider(endpoint: endpoint)
        sut = UserService(
            dataProvider: dataProvider
        )
    }
}
