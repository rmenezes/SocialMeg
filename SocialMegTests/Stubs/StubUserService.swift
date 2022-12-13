import Foundation
@testable import SocialMeg

final class StubUserService: UserServicing {
    private let dataProvider: StubDataProvider
    
    init(
        dataProvider: StubDataProvider
    ) {
        self.dataProvider = dataProvider
    }
    
    var fetchUsersCallsCount: Int = 0
    func fetchUsers() async -> [UserResponse] {
        do {
            fetchUsersCallsCount += 1
            return try await dataProvider.fetch(endpoint: UserEndpoint())
        } catch {
            return []
        }
    }
}
