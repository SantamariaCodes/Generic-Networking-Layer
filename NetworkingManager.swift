import Foundation

final class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init() {}

    func request<T: Decodable>(endpoint: TargetType, completion: @escaping (Result<T, Error>) -> Void) {
        var url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        
        switch endpoint.task {
        case .requestParameters(let parameters, _):
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
            urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            url = urlComponents?.url ?? url
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in            if let error = error {
                print("Network error: \(error)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(.failure(NetworkingError.noData))
                return
            }
            print("Response data size: \(data.count) bytes")
            print(String(data: data, encoding: .utf8) ?? "Invalid data")
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
    
    enum NetworkingError: Error {
        case noData
        // Add other cases as needed
    }
}
