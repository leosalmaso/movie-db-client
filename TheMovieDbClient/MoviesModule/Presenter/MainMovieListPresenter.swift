//
//  MainMovieListPresenter.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 27/05/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit

class MainMovieListPresenter {
    
    //Define the first tab as default category
    private let defaultCategory = MovieCategory.defaultValue()
    
    //Set movie as default value
    private var movieSource: MovieSource = .movie
    private var categoryPageNumber: [MovieCategory : Int]
    private weak var view: PresenterToViewProtocol?
    
    private lazy var interactor: PresenterToInteractorProtocol = {
        return MoviesInteractor(presenter: self)
    }()
    
    init(view: PresenterToViewProtocol) {
        self.view = view
        self.categoryPageNumber = [MovieCategory : Int]()
    }
    
    private func page(forCategory category: MovieCategory) -> Int {
        if let page = categoryPageNumber[category] {
            return page
        } else {
            categoryPageNumber[category] = 0
            return 0
        }
    }
    
    private func moviesFetched(moviesModelArray movies: [Movie], forCategory category: MovieCategory) {
        view?.isLoading(false)
        view?.showMovies(movies, forCategory: category.rawValue)
    }
}

extension MainMovieListPresenter: ViewToPresenterProtocol {
    
    func initView() {
        view?.updateCategories(MovieCategory.allCasesForSource(movieSource).map({ category in return category.rawValue }))
        fetchMovies(forCategory: defaultCategory)
    }
    
    func fetchMovies(forCategory category: MovieCategory) {
        view?.isLoading(true)
        interactor.fetchMoviesForCategory(category, forSource: movieSource, inPage: page(forCategory: category))
    }
    
    func didChangeSelectedCategory(toIndexCategory index: Int) {
        let category = categoryForIndex(index)
        fetchMovies(forCategory: category)
    }
    
    func defineMovieSource(_ movieSource: MovieSource) {
        self.movieSource = movieSource
    }
    
    func categoryForIndex(_ index: Int) -> MovieCategory {
        return MovieCategory.allCasesForSource(movieSource)[index]
    }
}

extension MainMovieListPresenter: InteractorToPresenterProtocol {
    
    func moviesFetchedSuccessOffline(moviesModelArray movies: [Movie], forCategory category: MovieCategory) {
        moviesFetched(moviesModelArray: movies, forCategory: category)
        view?.showMessage("Estas viendo contenido offline")
    }
    
    func moviesFetchedSuccess(moviesModelArray movies: [Movie], forCategory category: MovieCategory) {
        moviesFetched(moviesModelArray: movies, forCategory: category)
    }
    
    func moviesFetchFailed() {
        view?.isLoading(false)
        view?.showError(NSLocalizedString("Ouch! Tuvimos un problema, reintenta en un instante", comment: "Get Movies Error"))
    }
}
