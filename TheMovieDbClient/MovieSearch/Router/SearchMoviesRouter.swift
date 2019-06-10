//
//  SearchMoviesRouter.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 09/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import Foundation
import UIKit

class SearchMoviesRouter {
    static func createSearchModule() -> UIViewController {
        return SearchMoviesViewController()
    }
    
    static func createMovieDetailViewController(movieId: Int, inSource source: String) -> MovieDetailViewController {
        return MovieDetailViewController(movieId: movieId, inSource: source)
    }
}
