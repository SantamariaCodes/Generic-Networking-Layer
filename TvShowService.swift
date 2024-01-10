import Foundation

class TvShowService {
    let networkingManager: NetworkingManager

    init(networkingManager: NetworkingManager = .shared) {
        self.networkingManager = networkingManager
    }

    func getLatestTvShow(completion: @escaping (Result<LatestTvShow, Error>) -> Void) {
        networkingManager.request(endpoint: TvShowTarget.getShow(ranking: .latest)) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}

