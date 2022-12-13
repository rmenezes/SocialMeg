import Foundation

struct Post: Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
    let author: String
    var isLiked: Bool
    var numberOfLikes: Int
}
