import Foundation

enum AppStartupError: Error {
    case noInternetConnection
}

protocol AppStartupServicing {
    func start() async throws
}

struct AppStartupService: AppStartupServicing {
    func start() async throws {
        // TODO: Perform any app startup
    }
}
