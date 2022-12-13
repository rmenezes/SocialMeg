import Foundation

struct Comment: Decodable, Identifiable {
    let id: Int
    let userId: Int
    let name: String
    let username: String
    let email: String
    let body: String
}
