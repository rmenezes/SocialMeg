import Foundation

protocol Endpoint {
    var parameters: [String: Any] { get }
    var path: String { get }
}

enum DataProvidingError: Error {
    case invalidUrl
}

protocol DataProviding {
    func fetch<T: Decodable>(
        endpoint: Endpoint
    ) async throws -> T
    
    func fetchAll<T: Decodable>(
        endpoint: Endpoint
    ) async throws -> [T]
}

struct NetworkDataProvider: DataProviding {
    private let host: String
    private let urlSession: URLSession
    private let decoder: JSONDecoder
    
    init(
        appInfo: AppInfo
    ) {
        self.host = appInfo.host.orEmpty
        self.urlSession = URLSession(
            configuration: .default
        )
        self.decoder = JSONDecoder()
    }
    
    func fetch<T: Decodable>(
        endpoint: Endpoint
    ) async throws -> T {
        let (data, _) = try await urlSession.data(
            from: makeUrl(endpoint: endpoint)
        )
        
        return try decoder.decode(T.self, from: data)
    }
    
    func fetchAll<T: Decodable>(
        endpoint: Endpoint
    ) async throws -> [T] {
        let (data, _) = try await urlSession.data(
            from: makeUrl(endpoint: endpoint)
        )
        
        return try decoder.decode([T].self, from: data)
    }
}

// MARK: - Helpers

private extension NetworkDataProvider {
    func makeUrl(
        endpoint: Endpoint
    ) throws -> URL {
        guard
            let url = URL(string: "\(host)/\(endpoint.path)"),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        else { throw DataProvidingError.invalidUrl }
        
        components.path = endpoint.path

        components.queryItems = endpoint.parameters.map {
            URLQueryItem(name: $0.key, value: $0.value as? String)
        }
        
        guard
            let cUrl = components.url
        else {
            // URLComponents does not parse well URL like /posts/1/comments, so we fallback to the original URL
            return url
        }
        return cUrl
    }
}
