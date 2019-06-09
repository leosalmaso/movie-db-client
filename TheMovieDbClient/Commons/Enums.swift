//
//  Enums.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 05/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

enum MovieSource: String, CaseIterable {
    case movie = "Movies"
    case tv = "Series"
    
    func encodeToParam() -> String {
        switch self {
        case .movie:
            return "movie"
        case .tv:
            return "tv"
        }
    }
}

enum MovieCategory: String, CaseIterable {
    case popular = "Popular"
    case topRated = "Top Rated"
    case upcoming = "Upcoming"
    case onTheAir = "On the Air"
    
    static func allCasesForSource(_ source: MovieSource) -> [MovieCategory]{
        switch source {
        case .movie:
            return [.popular, .topRated, .upcoming]
        case .tv:
            return [.popular, .topRated, .onTheAir]
        }
    }
    
    static func defaultValue() -> MovieCategory{
        return .popular
    }
    
    func encodeToParam() -> String {
        switch self {
        case .popular:
            return "popular"
        case .topRated:
            return "top_rated"
        case .upcoming:
            return "upcoming"
        case .onTheAir:
            return "on_the_air"
        }
    }
}

enum CodableParamKey: String, CodingKey, CaseIterable {
    case params
    case movieCategory
    case movieSource
    
    func convertToCodingUserInfoKey() -> CodingUserInfoKey? {
        return CodingUserInfoKey(rawValue: self.rawValue)
    }
}
