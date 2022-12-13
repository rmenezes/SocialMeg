import Foundation

protocol PostServicing {
    func fetchPosts() async -> [PostResponse]
}

struct PostService: PostServicing {
    private let dataProvider: DataProviding
    
    init(
        dataProvider: DataProviding
    ) {
        self.dataProvider = dataProvider
    }
    
    func fetchPosts() async -> [PostResponse] {
        do {
            let data: [PostResponse] = try await dataProvider.fetchAll(
                endpoint: PostEndpoint()
            )
            
            return data
        } catch {
            return []
        }
    }
}
