import Foundation

struct AppInfo {
    let host: String?
    
    init(resourceLoader: AppInfoResourceLoading) {
        let info = resourceLoader.loadInfo()
        host = info["AppRemoteHost"] as? String
    }
}
