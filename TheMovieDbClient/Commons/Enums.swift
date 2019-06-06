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
    
    func encodeToParam() -> String {
        switch self {
        case .popular:
            return "popular"
        case .topRated:
            return "top_rated"
        case .upcoming:
            return "upcoming"
        }
    }
}
