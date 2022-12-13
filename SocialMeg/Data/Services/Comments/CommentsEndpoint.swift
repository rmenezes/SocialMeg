import Foundation

struct CommentsEndpoint: Endpoint {
    let parameters: [String : Any] = [:]
    let path: String
    
    init(
        postId: Int
    ) {
        path = "posts/\(postId)/comments"
    }
}
