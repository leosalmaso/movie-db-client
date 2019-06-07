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
    @NSManaged public var id: Int
    @NSManaged public var voteAverage: Double
    @NSManaged public var title: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var name: String?
    @NSManaged public var genreIds: [Int]?
    @NSManaged public var overview: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var firsAirDate: String?
    var media: Trailers?
    
    func imagePath() -> String? {
        guard let path = posterPath else {
            return nil
        }
        
        return "https://image.tmdb.org/t/p/w400" + path
    }
    
    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedObjectContext) else {
                fatalError("Failed to decode Movie")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0
        title = try container.decodeIfPresent(String.self, forKey: .title)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        genreIds = try container.decodeIfPresent([Int].self, forKey: .genreIds)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        firsAirDate = try container.decodeIfPresent(String.self, forKey: .firsAirDate)
    }
    
    // MARK: - Encodable
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
