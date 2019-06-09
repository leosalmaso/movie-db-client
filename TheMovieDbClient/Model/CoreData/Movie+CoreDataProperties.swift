//
//  Movie+CoreDataProperties.swift
//  
//
//  Created by Leo Salmaso on 06/06/2019.
//
//

import Foundation
import CoreData


extension Movie {
    @NSManaged public var id: Int
    @NSManaged public var voteAverage: Double
    @NSManaged public var title: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var name: String?
    @NSManaged public var genreIds: [Int]?
    @NSManaged public var overview: String?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var firsAirDate: Date?
    
    //Calculated Properties
    @NSManaged public var source: String
    @NSManaged public var category: String
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }
}
