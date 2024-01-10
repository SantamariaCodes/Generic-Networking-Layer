import SwiftUI

struct ContentView: View {
    @State private var latestShow: LatestTvShow?
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            if let show = latestShow {
                Text("Latest show: \(show.name)")
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
            } else {
                Text("Fetching latest show...")
            }
        }
        .onAppear {
            let tvShowService = TvShowService()
            tvShowService.getLatestTvShow { result in
                switch result {
                case .success(let show):
                    self.latestShow = show
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
