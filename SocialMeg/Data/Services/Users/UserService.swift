import Foundation

protocol UserServicing {
    func fetchUsers() async -> [UserResponse]
}

struct UserService: UserServicing {
    private let dataProvider: DataProviding
    
    init(
        dataProvider: DataProviding
    ) {
        self.dataProvider = dataProvider
    }
    
    func fetchUsers() async -> [UserResponse] {
        do {
            let data: [UserResponse] = try await dataProvider.fetchAll(
                endpoint: UserEndpoint()
            )
            
            return data
        } catch {
            return []
        }
    }
}
