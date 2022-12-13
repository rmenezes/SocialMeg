import Foundation
import Combine

protocol PostsViewModeling {
    var posts: [Post] { get }
    func load() async
    func showDetails(post: Post)
    func likePost(post: Post)
}

final class PostsViewModel: ObservableObject {
    private let postService: PostServicing
    private let userRepository: UserRepositoring
    private let builder: PostsBuilder
    private let actions: PostActions
    private let notificationCenter: NotificationCenter
    
    @Published var posts: [Post] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        postService: PostServicing,
        userRepository: UserRepositoring,
        actions: PostActions,
        builder: PostsBuilder = PostsBuilder(),
        notificationCenter: NotificationCenter = .default
    ) {
        self.postService = postService
        self.userRepository = userRepository
        self.actions = actions
        self.builder = builder
        self.notificationCenter = notificationCenter
        
        observePostLiked()
        fetchInformation()
    }
}

// MARK: - PostsViewModeling

extension PostsViewModel: PostsViewModeling {
    @MainActor func load() async {
        guard posts.count == 0 else { return }
        
        let (posts, users) = await (
            postService.fetchPosts(),
            userRepository.fetchUsers()
        )
        
        self.posts = builder.build(
            posts: posts,
            users: users
        )
    }
    
    func showDetails(post: Post) {
        actions.postDetails(post)
    }
    
    func likePost(post: Post) {
        guard
            let indexOf = self.posts.firstIndex(where: { $0.id == post.id })
        else { return }
        
        var copy = posts[indexOf]
        copy.numberOfLikes = copy.numberOfLikes + 1
        copy.isLiked = true
        
        self.posts[indexOf] = copy
    }
    
    func observePostLiked() {
        NotificationCenter
            .default
            .publisher(for: .postUpdated)
            .compactMap(\.object)
            .compactMap { $0 as? [String: Any] }
            .sink { [weak self] obj in
                guard
                    let self,
                    let postId = obj["postId"] as? Int,
                    let index = self.posts.firstIndex(where: { $0.id == postId })
                else { return }
                
                self.likePost(post: self.posts[index])
            }
            .store(in: &cancellables)
    }
    
    func fetchInformation() {
        Task {
            await load()
        }
    }
}
