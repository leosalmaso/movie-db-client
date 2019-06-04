//
//  Movie.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 20/05/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let voteCount: Int?
    let id: Int
    let video: Bool?
    let voteAverage: Double?
    let title: String?
    let popularity: Double?
    let posterPath: String?
    let originalLanguage: String?
    let originalTitle: String?
    let genreIds: [Int]?
    let backdropPath: String?
    let adult: Bool?
    let overview: String?
    let releaseDate: String?
    let media: Trailers?
    
    func imagePath() -> String? {
        guard let path = posterPath else {
            return nil
        }
        
        return "https://image.tmdb.org/t/p/w400" + path
    }
}

extension Movie {
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id
        case video
        case voteAverage = "vote_average"
        case title
        case popularity
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case media = "videos"
    }
}
