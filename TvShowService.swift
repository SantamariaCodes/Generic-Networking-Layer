import Foundation

class TvShowService {
    let networkingManager: NetworkingManager

    init(networkingManager: NetworkingManager = .shared) {
        self.networkingManager = networkingManager
    }

    func getTvShow(ranking: TVShowType, completion: @escaping (Result<LatestTvShow, Error>) -> Void) {
        networkingManager.request(endpoint: TvShowTarget.getShow(ranking: ranking)) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
