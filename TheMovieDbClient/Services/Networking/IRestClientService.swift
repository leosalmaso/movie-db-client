//
//  IRestClientService.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 18/05/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit

protocol IRestClientService {
    func fetchMovies(source: String, forCategory category: String, inPage page: Int, completion: @escaping (Data?) -> Void)
    func fetchMovie(movieId: Int, inSource source: String, completion: @escaping (Data?) -> Void)
}
