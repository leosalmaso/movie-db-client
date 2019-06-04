//
//  MoviesProtocols.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 04/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit

protocol PresenterToRouterProtocol: class {
    static func createMoviesModule() -> MainMovieListViewController
    static func createSeriesModule() -> MainMovieListViewController
}
