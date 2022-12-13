import Foundation

protocol CommentsServicing {
    func fetchComments(
        postId: Int
    ) async -> [CommentsResponse]
}

struct CommentService: CommentsServicing {
    private let dataProvider: DataProviding
    
    init(
        dataProvider: DataProviding
    ) {
        self.dataProvider = dataProvider
    }
    
    func fetchComments(
        postId: Int
    ) async -> [CommentsResponse] {
        do {
            let data: [CommentsResponse] = try await dataProvider.fetchAll(
                endpoint: CommentsEndpoint(postId: postId)
            )
            
            return data
        } catch {
            print(error)
            return []
        }
    }
}
