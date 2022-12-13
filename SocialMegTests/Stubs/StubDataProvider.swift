import Foundation
@testable import SocialMeg

final class StubDataProvider: DataProviding {
    enum StubEndpoint: String {
        case comments
        case users
        case posts
        case empty
    }
    
    private let loader: StubJsonLoader
    
    init(endpoint: StubEndpoint) {
        loader = StubJsonLoader(resourceName: endpoint.rawValue)
    }
    
    var fetchCallsCount: Int = 0
    func fetch<T>(
        endpoint: SocialMeg.Endpoint
    ) async throws -> T where T : Decodable {
        fetchCallsCount += 1
        return try JSONDecoder().decode(T.self, from: loader.load())
    }
    
    var fetchAllCallsCount: Int = 0
    func fetchAll<T>(
        endpoint: SocialMeg.Endpoint
    ) async throws -> [T] where T : Decodable {
        fetchAllCallsCount += 1
        return try JSONDecoder().decode([T].self, from: loader.load())
    }
}

private extension StubDataProvider {
    final class StubJsonLoader {
        private let resourceName: String
        
        init(resourceName: String) {
            self.resourceName = resourceName
        }
        
        func load() -> Data {
            guard
                let path = Bundle(for: StubJsonLoader.self)
                    .url(
                        forResource: resourceName,
                        withExtension: "json"
                    ),
                let data = try? Data(contentsOf: path)
            else { return Data() }
            
            return data
        }
    }
}
