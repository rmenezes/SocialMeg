import Foundation

struct PostsBuilder {
    func build(
        posts: [PostResponse],
        users: [UserResponse]
    ) -> [Post] {
        posts
            .map { post in
                let user = users.first(where: { $0.id == post.userId })
                return Post(
                    id: post.id,
                    userId: user?.id ?? 0,
                    title: post.title,
                    body: post.body,
                    author: user?.name ?? "",
                    isLiked: false,
                    numberOfLikes: 0
                )
            }
    }
}
