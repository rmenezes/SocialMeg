import Foundation

struct PostDetailsBuilder {
    func build(
        comments: [CommentsResponse],
        users: [UserResponse]
    ) -> [Comment] {
        comments
            .map { comment in
                let user = users.first(where: { $0.email == comment.email })
                return Comment(
                    id: comment.id,
                    userId: user?.id ?? 0,
                    name: comment.name,
                    username: user?.name ?? "",
                    email: comment.email,
                    body: comment.body
                )
            }
    }
}
