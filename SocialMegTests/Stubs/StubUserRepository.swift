import Foundation
@testable import SocialMeg

final class StubUserRepository: UserRepositoring {
    private var users: [UserResponse] = []
    var fetchUsersCallsCount: Int = 0
    func fetchUsers() async -> [UserResponse] {
        do {
            fetchUsersCallsCount += 1
            if !users.isEmpty {
                return users
            }
            
            let provider = StubDataProvider(endpoint: .users)
            return try await provider.fetch(endpoint: UserEndpoint())
        } catch {
            return users
        }
    }
}
