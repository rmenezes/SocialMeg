import Foundation

struct PostResponse: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
