import Foundation
@testable import SocialMeg

final class StubPostService: PostServicing {
    enum Scope {
        case exception
        case users
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
    
    var fetchPostCallCount: Int  = 0
    func fetchPosts() async -> [PostResponse] {
        do {
            fetchPostCallCount += 1
            
            if scope == .exception {
                throw StubPostServiceError.dummyException
            }
            
            let stub = StubDataProvider(endpoint: .posts)
            return try await stub.fetch(endpoint: UserEndpoint())
        } catch {
            return []
        }
    }
}
