//
//  IPersistenceService.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 07/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit

protocol IPersistenceService {
    func persistEntity<T:Codable>(_ entity: Data, extraParameters params: [CodableParamKey : Any]?) throws -> T
    func fetchMovies(withCategory category: String, inSource source: String, inPage page: Int) -> [Movie]?
}
