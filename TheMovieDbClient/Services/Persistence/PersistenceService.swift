//
//  PersistenceService.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 07/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import CoreData

class PersistenceService: IPersistenceService {
    private lazy var decoder: JSONDecoder = {
        return JSONDecoder()
    }()

    func persistEntity<T:Codable>(_ entity: Data, extraParameters params: [CodableParamKey : Any]?    ) throws -> T {
        let context = CoreDataHelper.sharedInstance.newContext()
        decoder.userInfo[CoreDataHelper.managedObjectContext!] = context
        
        if let params = params, let extraParamsKey = CodableParamKey.params.convertToCodingUserInfoKey() {
            decoder.userInfo[extraParamsKey] = params
        }
        
        let response = try self.decoder.decode(T.self, from: entity)
        try context.save()
        
        return response
    }
}

//Movies
extension PersistenceService {
    func fetchMovies(withCategory category: String, inSource source: String, inPage page: Int) -> [Movie]? {
        
        let context = CoreDataHelper.sharedInstance.newContext()
        let request = NSFetchRequest<Movie>(entityName: "Movie")
        request.predicate = NSPredicate(format: "category = %@ AND source = %@", category, source)
        
        do {
            let movies = try context.fetch(request)
            return movies
        } catch {
            print("Error Fetching Movies")
            return nil
        }
    }
}
