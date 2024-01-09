import Foundation

final class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init () {}

    func request<T: Codable>(endpoint: TargetType, completion: @escaping (Result<T, Error>) -> Void) {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        // Set headers
        endpoint.headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        // Handle task
        switch endpoint.task {
        case .requestParameters(let parameters, let encoding):
            do {
                request = try encoding.encode(request, with: parameters)
            } catch {
                completion(.failure(error))
                return
            }
        }

        // URLSession data task
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response
            // ...
        }
        dataTask.resume()
    }

    // NetworkingError and other extensions
    // ...
}
