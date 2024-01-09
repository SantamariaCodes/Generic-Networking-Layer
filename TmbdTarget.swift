import Foundation

enum TvShowTarget {
    case getShow(ranking: TVShowType)
}

extension TvShowTarget: TargetType {
    
    var path: String {
        switch self {
        case .getShow(let type):
            "tv/\(type)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getShow:
            return .get
        }
    }
    
    var task: HTTPTask {
        // se pasa vacio porque no necesita parameters
        switch self {
        case .getShow:
            return .requestParameters(parameters: [:], encoding: JSONEncoding.default)
        }
    }
    

}

enum TVShowType: String {
    
   
    case latest
    
}


