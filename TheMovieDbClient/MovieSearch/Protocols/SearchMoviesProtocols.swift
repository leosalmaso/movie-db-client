//
//  SearchMoviesProtocol.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 09/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import Foundation
import UIKit

protocol SearchPresenterToSearchRouterProtocol: class {
    static func createSearchModule() -> SearchMoviesViewController
}

protocol SearchViewToSearchPresenterProtocol: class {
    func initView()
    func searchMovies(_ query: String, forSoure source: MovieSource)
}

protocol SearchPresenterToSearchViewProtocol: class{
    func showMovies(_ movies: [Movie])
    func isLoading(_ isLoading: Bool)
    func showError(_ error: String)
    func showMessage(_ message: String)
    func navigateToViewController(_ viewController: UIViewController)
}

protocol SearchPresenterToSearchInteractorProtocol: class {
    func searchMovies(_ query: String, forSource source: MovieSource)
}

protocol SearchInteractorToSearchPresenterProtocol: class {
    func moviesSearchSuccess(moviesModelArray movies: [Movie])
    func moviesSearchSuccessOffline(moviesModelArray movies: [Movie])
    func moviesSearchFailed()
}
