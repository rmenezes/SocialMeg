import Foundation
@testable import SocialMeg

final class StubAppInfoResourceLoader: AppInfoResourceLoading {
    enum Scope {
        case noHostKeyFound
        case hostFound
    }
    
    private var plist: [String: Any] = [:]
    
    init(_ scope: Scope) {
        switch scope {
        case .hostFound:
            plist["AppRemoteHost"] = "https://rmenezes.me"
        case .noHostKeyFound:
            break
        }
    }
    
    var loadInfoCallsCount: Int = 0
    func loadInfo() -> [String : Any] {
        loadInfoCallsCount += 1
        return plist
    }
}
