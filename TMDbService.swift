//
//  TMDBService.swift
//  MovieCatalog app
//
//  Created by Diego Santamaria on 8/1/24.
//

import Foundation

class TMDbService: ObservableObject {
    @Published var topShows: [TVShow] = []
    @Published var latestShow: LatestTvShow?

    func fetchShows(endpoint: TmdbTarget) {
        switch endpoint {
        case .topRated, .popular:
            NetworkingManager.shared.request(endpoint: endpoint) { [weak self] (result: Result<ShowStructure, Error>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let showsResponse):
                        self?.topShows = showsResponse.results
                    case .failure(let error):
                        print("Error fetching shows: \(error)")
                    }
                }
            }
            
        case .latest:
            NetworkingManager.shared.request(endpoint: endpoint) { [weak self] (result: Result<LatestTvShow, Error>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let latestShowResponse):
                        self?.latestShow = latestShowResponse
                    case .failure(let error):
                        print("Error fetching latest show: \(error)")
                    }
                }
            }
        }
    }
    // ...
}
