//
//  TopRatedModel.swift
//  MovieCatalog app
//
//  Created by Diego Santamaria on 4/1/24.
//

import Foundation

struct ShowStructure: Codable {
    let page: Int
    let results: [TVShow]
    let totalPages: Int
    let totalResults: Int
}

struct TVShow: Codable , Identifiable {
    let id: Int
    let name: String
    let overview: String
    let firstAirDate: String
    let posterPath: String?
}

struct LatestTvShow: Codable {
    let name: String
}


