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
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }
}
