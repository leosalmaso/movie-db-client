//
//  MoviesInteractor.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 05/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit

class MoviesInteractor: PresenterToInteractorProtocol {
    
    private lazy var restClient: IRestClientService = {
        return RestClientService()
    }()
    
    private lazy var persistenceService: IPersistenceService = {
        return PersistenceService()
    }()
    
    private weak var presenter: InteractorToPresenterProtocol?
    
    init(presenter: InteractorToPresenterProtocol) {
        self.presenter = presenter
    }
    
    //Movies
    private func fetchOnlineMovies(_ category: MovieCategory, forSource source: MovieSource, inPage page: Int) {
        restClient.fetchMovies(source: source.encodeToParam(), forCategory: category.encodeToParam(), inPage: page) { [weak self] response in
            guard let self = self else { return }
            
            if let response = response {
                do {
                    let extraParams: [CodableParamKey : String] = [CodableParamKey.movieCategory : category.rawValue, CodableParamKey.movieSource: source.rawValue]
                    let moviePage: PaginatedResponse<Movie> = try self.persistenceService.persistEntity(response, extraParameters: extraParams)
                    self.presenter?.moviesFetchedSuccess(moviesModelArray: moviePage.results, forCategory: category)
                } catch {
                    print(error)
                    self.presenter?.moviesFetchFailed()
                }
            } else {
                self.presenter?.moviesFetchFailed()
            }
        }
    }
    
    private func fetchOfflineMovies(_ category: MovieCategory, forSource source: MovieSource, inPage page: Int) {
        let movies = persistenceService.fetchMovies(withCategory: category.rawValue, inSource: source.rawValue, inPage: page)
        
        if let movies = movies {
            presenter?.moviesFetchedSuccessOffline(moviesModelArray: movies, forCategory: category)
        } else {
            presenter?.moviesFetchFailed()
        }
    }
    
    func fetchMoviesForCategory(_ category: MovieCategory, forSource source: MovieSource, inPage page: Int) {
        if ReachabilityHelper.sharedInstance.isInternetConnectionAvailable() {
            fetchOnlineMovies(category, forSource: source, inPage: page)
        } else {
            fetchOfflineMovies(category, forSource: source, inPage: page)
        }
    }
}
