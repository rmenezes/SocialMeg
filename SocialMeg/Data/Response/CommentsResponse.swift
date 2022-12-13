import Foundation

struct CommentsResponse: Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
