//
//  TargetType.swift
//  MovieCatalog app
//
//  Created by Diego Santamaria on 8/1/24.
//

import Foundation

// MARK: - Typealiases
typealias HTTPHeaders = [String: String]

// MARK: - TargetType
protocol TargetType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    var authorizationType: AuthorizationType { get }
}

enum HTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum HTTPTask {
    case requestParameters(parameters: [String: Any], encoding: ParameterEncodable)
}

extension TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/") else {
            fatalError("Base URL Couldn't be Configured")
        }
        
        return url
    }
    
    var headers: HTTPHeaders? {
        ["Content-Type": "application/json",
         "Accept": "application/json"
        ]
    }
    
    var authorizationType: AuthorizationType {
        AuthorizationType.none
    }
}

enum AuthorizationType {
    case none
    case basic(code: String)
    case bearer(code: String)
}
