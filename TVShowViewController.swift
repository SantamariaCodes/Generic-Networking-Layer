import UIKit

class TvShowViewModel: ObservableObject {
    @Published var latestShow: LatestTvShow?
    @Published var errorMessage: String?

    let tvShowService = TvShowService()

    func fetchTvShow(ranking: TVShowType) {
        tvShowService.getTvShow(ranking: ranking) { [weak self] result in
            switch result {
            case .success(let show):
                self?.latestShow = show
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }
}


