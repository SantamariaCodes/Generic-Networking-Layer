import UIKit

class LatestTvShowViewController: UIViewController {

    let tvShowService = TvShowService()

    override func viewDidLoad() {
        super.viewDidLoad()

        tvShowService.getLatestTvShow { result in
            switch result {
            case .success(let latestShow):
                print("Latest show name: \(latestShow.name)")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
