import Foundation
@testable import SocialMeg

final class StubCommentsService: CommentsServicing {    
    enum Scope {
        case exception
        case comments
    }
    
    enum StubPostServiceError: Error {
        case dummyException
    }
    
    private let scope: Scope
    
    init(
        scope: Scope
    ) {
        self.scope = scope
    }
    
    var fetchCommentsCallsCount: Int  = 0
    func fetchComments(
        postId: Int
    ) async -> [CommentsResponse] {
        do {
            fetchCommentsCallsCount += 1
            
            if scope == .exception {
                throw StubPostServiceError.dummyException
            }
            
            let stub = StubDataProvider(endpoint: .comments)
            return try await stub.fetch(endpoint: CommentsEndpoint(postId: postId))
        } catch {
            return []
        }
    }
}

