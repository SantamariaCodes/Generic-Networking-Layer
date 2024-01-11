import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TvShowViewModel()

    var body: some View {
        VStack {
            if let show = viewModel.latestShow {
                Text("Show name: \(show.name)")
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else {
                Text("Fetching show...")
            }
        }
        .onAppear {
            viewModel.fetchTvShow(ranking: .latest) // or .popular, etc.
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
