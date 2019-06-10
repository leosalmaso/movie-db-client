//
//  MoviesProtocols.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 04/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import Foundation
import UIKit

protocol PresenterToRouterProtocol: class {
    static func createMoviesModule() -> MainMovieListViewController
    static func createSeriesModule() -> MainMovieListViewController
}

protocol ViewToPresenterProtocol: class {
    func initView()
    func fetchMovies(forCategory category: MovieCategory)
    func didChangeSelectedCategory(toIndexCategory index: Int)
    func defineMovieSource(_ movieSource: MovieSource)
    func categoryForIndex(_ index: Int) -> MovieCategory
    func didSelectMovie(_ movie: Movie)
}

protocol PresenterToViewProtocol: class{
    func showMovies(_ movies: [Movie], forCategory category: String)
    func updateCategories(_ categories: [String])
    func isLoading(_ isLoading: Bool)
    func showError(_ error: String)
    func showMessage(_ message: String)
    func navigateToViewController(_ viewController: UIViewController)
}

protocol PresenterToInteractorProtocol: class {
    func fetchMoviesForCategory(_ category: MovieCategory, forSource source: MovieSource, inPage page: Int)
}

protocol InteractorToPresenterProtocol: class {
    func moviesFetchedSuccess(moviesModelArray movies: [Movie], forCategory category: MovieCategory)
    func moviesFetchedSuccessOffline(moviesModelArray movies: [Movie], forCategory category: MovieCategory)
    func moviesFetchFailed()
}
