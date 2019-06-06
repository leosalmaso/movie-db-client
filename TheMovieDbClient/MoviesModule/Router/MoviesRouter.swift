//
//  MoviesRouter.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 04/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit

class MoviesRouter: PresenterToRouterProtocol {
    static func createMoviesModule() -> MainMovieListViewController {
        return MainMovieListViewController(movieSource: .movie)
    }
    
    static func createSeriesModule() -> MainMovieListViewController {
        return MainMovieListViewController(movieSource: .tv)
        
    }
}
