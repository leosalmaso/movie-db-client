//
//  Movie.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 20/05/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject, Codable {
    
    var trailers: Trailers?
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CoreDataHelper.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedObjectContext) else {
                fatalError("Failed to decode Movie")
        }
        
        //Init Managed Object
        self.init(entity: entity, insertInto: managedObjectContext)

        //Decode Entity
        try decodeEntity(from: decoder)
    }
    
    func imagePath() -> String? {
        guard let path = posterPath else {
            return nil
        }
        return "https://image.tmdb.org/t/p/w400" + path
    }
    
    func movieTrailers() -> [Video]? {
        return trailers?.videos?.compactMap({ video  in
            if video.type == .Trailer {
                return video
            } else {
                return nil
            }
        })
    }
}

//Codable implementation
extension Movie {
    func decodeEntity(from decoder: Decoder) throws {
        //Get Container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        //Decode Properties
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0
        title = try container.decodeIfPresent(String.self, forKey: .title)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        genreIds = try container.decodeIfPresent([Int].self, forKey: .genreIds)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        
        let decodedReleaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        if let stringDate = decodedReleaseDate, let formattedDate = DateHelper.sharedInstance.dateFromString(stringDate) {
            releaseDate = formattedDate
        }
        
        let decodedFirstAirDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        if let stringDate = decodedFirstAirDate, let formattedDate = DateHelper.sharedInstance.dateFromString(stringDate) {
            firsAirDate = formattedDate
        }
        
        //Get extra params
        if let extraParamsKey = CodableParamKey.params.convertToCodingUserInfoKey(),
            let extraParams = decoder.userInfo[extraParamsKey] as? [CodableParamKey: String] {
            category = extraParams[.movieCategory] ?? ""
            source = extraParams[.movieSource] ?? ""
        }
        
        //Try to get trailers
        trailers = try container.decodeIfPresent(Trailers.self, forKey: CodingKeys.media)
    }
}


//Encodable Protocol
extension Movie {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(voteAverage, forKey: .voteAverage)
        try container.encode(title, forKey: .title)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(originalTitle, forKey: .originalTitle)
        try container.encode(name, forKey: .name)
        try container.encode(genreIds, forKey: .genreIds)
        try container.encode(overview, forKey: .overview)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(firsAirDate, forKey: .firsAirDate)
    }
}

extension Movie {
    enum CodingKeys: String, CodingKey {
        case id
        case voteAverage = "vote_average"
        case title
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case name = "name"
        case genreIds = "genre_ids"
        case overview
        case releaseDate = "release_date"
        case firsAirDate = "first_air_date"
        case media = "videos"
    }
}
