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
        let movieVC = MainMovieListViewController(nibName:"MainMovieListViewController", bundle:nil)
        movieVC.movieSource = .movie
        return movieVC
    }
    
    static func createSeriesModule() -> MainMovieListViewController {
        let seriesVC = MainMovieListViewController(nibName:"MainMovieListViewController", bundle:nil)
        seriesVC.movieSource = .tv
        return seriesVC
    }
}
