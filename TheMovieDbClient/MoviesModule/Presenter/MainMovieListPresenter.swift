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
    private let defaultCategory = MovieCategory.allCases.first!
    
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
}

extension MainMovieListPresenter: ViewToPresenterProtocol {
    
    func initView() {
        view?.updateCategories(MovieCategory.allCases.map({ category in return category.rawValue }))
        fetchMovies(forCategory: defaultCategory)
    }
    
    func fetchMovies(forCategory category: MovieCategory) {
        view?.isLoading(true)
        interactor.fetchMovies(forCategory: category, page: page(forCategory: category))
    }
    
    func didChangeSelectedCategory(_ category: MovieCategory) {
        fetchMovies(forCategory: category)
    }
}

extension MainMovieListPresenter: InteractorToPresenterProtocol {
    func moviesFetchedSuccess(moviesModelArray movies: Array<Movie>, forCategory category: MovieCategory) {
        view?.isLoading(false)
        view?.showMovies(movies, forCategory: category.rawValue)
    }
    
    func moviesFetchFailed() {
        view?.isLoading(false)
        view?.showError(NSLocalizedString("Ouch! Tuvimos un problema, reintenta en un instante", comment: "Get Movies Error"))
    }
}
