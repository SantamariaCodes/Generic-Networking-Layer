import SwiftUI

struct ContentView: View {
    @StateObject var tmdbService = TMDbService()

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Latest Show")) {
                    if let latestShow = tmdbService.latestShow {
                        Text(latestShow.name)
                    } else {
                        Text("Loading latest show...")
                            .onAppear {
                                tmdbService.fetchShows(endpoint: .latest)
                            }
                    }
                }

                Section(header: Text("Top Rated Shows")) {
                    ForEach(tmdbService.topShows, id: \.id) { show in
                        VStack(alignment: .leading) {
                            Text(show.name)
                                .font(.headline)
                            Text(show.overview)
                                .font(.subheadline)
                                .lineLimit(3)
                        }
                    }
                }
            }
            .navigationTitle("Shows")
            .onAppear {
                tmdbService.fetchShows(endpoint: .topRated)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
