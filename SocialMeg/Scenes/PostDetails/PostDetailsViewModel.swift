import Foundation

protocol PostDetailsViewModeling {
    var post: Post { get }
    var comments: [Comment] { get }
    
    func load() async
    func likePost(postId: Int)
}

final class PostDetailViewModel: ObservableObject {
    // MARK: - Private
    private let userRepository: UserRepositoring
    private let commentsService: CommentsServicing
    private let builder: PostDetailsBuilder
    
    @Published var post: Post
    @Published var comments: [Comment] = []
    
    init(
        post: Post,
        userRepository: UserRepositoring,
        commentsService: CommentsServicing,
        builder: PostDetailsBuilder = PostDetailsBuilder()
    ) {
        self.post = post
        self.userRepository = userRepository
        self.commentsService = commentsService
        self.builder = builder
    }
}

// MARK: - PostDetailsViewModeling

extension PostDetailViewModel: PostDetailsViewModeling {
    @MainActor func load() async {
        let (comments, users) = await (
            commentsService.fetchComments(postId: post.id),
            userRepository.fetchUsers()
        )
        
        self.comments = builder.build(
            comments: comments,
            users: users
        )
    }
    
    func likePost(postId: Int) {
        post.numberOfLikes += 1
        post.isLiked = true
        
        NotificationCenter.default.post(name: .postUpdated, object: [
            "postId": postId
        ])
    }
}

extension Notification.Name {
    static let postUpdated = Notification.Name("post-updated")
}
