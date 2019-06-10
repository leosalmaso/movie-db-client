//
//  MoviesRouter.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 04/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit

class MoviesRouter: PresenterToRouterProtocol {
    static func createMoviesModule() -> UIViewController {
        return MainMovieListViewController(movieSource: .movie)
    }
    
    static func createSeriesModule() -> UIViewController {
        return MainMovieListViewController(movieSource: .tv)
        
    }
    
    static func createMovieDetailViewController(movieId: Int, inSource source: String) -> MovieDetailViewController {
        return MovieDetailViewController(movieId: movieId, inSource: source)
    }
}
