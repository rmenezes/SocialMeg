import XCTest
@testable import SocialMeg

final class UserRepositoryTests: XCTestCase {
    private var sut: UserRepository!
    private var service: StubUserService!
    private var dataProvider: StubDataProvider!
    
    override func setUp() {
        super.setUp()
        
        dataProvider = StubDataProvider(endpoint: .users)
        service = StubUserService(dataProvider: dataProvider)
        sut = UserRepository(service: service)
    }
    
    func testWhenCached_thenDontFetchNewUsers() async {
        // Given
        let users1 = await sut.fetchUsers()
        
        // When
        let users2 = await sut.fetchUsers()
        
        // Then
        XCTAssertEqual(users1, users2)
        XCTAssertEqual(dataProvider.fetchCallsCount, 1)
        XCTAssertEqual(service.fetchUsersCallsCount, 1)
    }
    
    func testWhenNotCached_thenFetchNewUsers() async {
        // Given
        let users = await sut.fetchUsers()
        
        // Then
        XCTAssertEqual(dataProvider.fetchCallsCount, 1)
        XCTAssertEqual(service.fetchUsersCallsCount, 1)
        XCTAssertEqual(users.count, 1)
    }
}

// MARK: - Helpers

extension UserResponse: Equatable {
    public static func == (
        lhs: SocialMeg.UserResponse,
        rhs: SocialMeg.UserResponse
    ) -> Bool {
        lhs.id == rhs.id
    }
}
