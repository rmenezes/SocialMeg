import Foundation

protocol UserRepositoring {
    func fetchUsers() async -> [UserResponse]
}

final class UserRepository: UserRepositoring {
    private let service: UserServicing
    private var users: [UserResponse] = []
    
    init(
        service: UserServicing
    ) {
        self.service = service
    }
    
    func fetchUsers() async -> [UserResponse] {
        if !users.isEmpty {
            return users
        }
        
        let users = await service.fetchUsers()
        self.users = users
        return users
    }
}
