//
//  TvShowService.swift
//  TESTING
//
//  Created by Diego Santamaria on 9/1/24.
//

import Foundation

struct TvShowService {
    
    let provider: NetworkingManager
    
    init(provider: NetworkingManager) {
        self.provider = provider
    }
    
    func getTvShows<T: Decodable> (ranking: TVShowType, completion: @escaping (Result<T, Error>) -> Void) {
        
        provider.request(endpoint: TvShowTarget.getShow(ranking: ranking )) { result in
          
            switch result {
            case .success(let response):
                do {
                    // Decode the response data into the generic type T
                    let decodedData = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
                
             //   return completion(response, nil)
            case .failure(let error):
          //      return completion(nil, error)
                completion(.failure(error))
            }
            
        }
    }
    
    
    
}
