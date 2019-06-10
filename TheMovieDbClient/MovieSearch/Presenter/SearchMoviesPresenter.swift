//
//  SearchMoviesPresenter.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 09/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import Foundation

class SearchMoviesPresenter {
    private weak var view: SearchPresenterToSearchViewProtocol?
    private lazy var interactor: SearchPresenterToSearchInteractorProtocol = {
        return SearchMoviesInteractor(presenter: self)
    }()
    
    init(view: SearchPresenterToSearchViewProtocol) {
        self.view = view
    }
}

extension SearchMoviesPresenter: SearchViewToSearchPresenterProtocol {
    func initView() {
        //I used interface builder for speed reasons
    }
    
    func searchMovies(_ query: String, forSoure source: MovieSource) {
        view?.isLoading(true)
        interactor.searchMovies(query, forSource: source)
    }
}

extension SearchMoviesPresenter: SearchInteractorToSearchPresenterProtocol {
    func moviesSearchSuccess(moviesModelArray movies: [Movie]) {
        view?.isLoading(false)
        view?.showMovies(movies)
    }
    
    func moviesSearchSuccessOffline(moviesModelArray movies: [Movie]) {
        view?.isLoading(false)
        view?.showMovies(movies)
        view?.showMessage("Estas viendo informacion offline")
    }
    
    func moviesSearchFailed() {
        view?.isLoading(false)
        view?.showError("Hubo un problema al realizar la busqueda")
    }
    
    
}
