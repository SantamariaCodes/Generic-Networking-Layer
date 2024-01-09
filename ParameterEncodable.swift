//
//  ParameterEncodable.swift
//  MovieCatalog app
//
//  Created by Diego Santamaria on 8/1/24.
//

import Foundation

public typealias Parameters = [String: Any]

protocol ParameterEncodable {
    func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest
}

struct JSONEncoding: ParameterEncodable {
    
    static var `default`: JSONEncoding = JSONEncoding()
    
    func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = urlRequest
        
        guard let parameters = parameters else { return urlRequest }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
         
            }
            
            urlRequest.httpBody = data
        } catch {
            throw error
        }
        return urlRequest
    }
}
