//
//  SearchMoviesInteractor.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 09/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit

class SearchMoviesInteractor: SearchPresenterToSearchInteractorProtocol {
    
    private weak var presenter: SearchInteractorToSearchPresenterProtocol?
    private lazy var restClient: IRestClientService = {
        return RestClientService()
    }()
    private lazy var persistenceService: IPersistenceService = {
        return PersistenceService()
    }()
    
    init(presenter: SearchInteractorToSearchPresenterProtocol) {
        self.presenter = presenter
    }
    
    func searchMovies(_ query: String, forSource source: MovieSource) {
        if ReachabilityHelper.sharedInstance.isInternetConnectionAvailable() {
            searchOnline(query, forSource: source)
        } else {
            searchOffline(query, forSource: source)
        }
    }
    
    private func searchOnline(_ query: String, forSource source: MovieSource) {
        restClient.searchMovies(query: query, source: source.encodeToParam()) { [weak self] response in
            
            guard let self = self else { return }
            
            if let response = response {
                do {
                    let extraParams: [CodableParamKey : String] = [CodableParamKey.movieSource: source.rawValue]
                    let moviePage: PaginatedResponse<Movie> = try self.persistenceService.persistEntity(response, extraParameters: extraParams)
                    self.presenter?.moviesSearchSuccess(moviesModelArray: moviePage.results)
                } catch {
                    print(error)
                    self.presenter?.moviesSearchFailed()
                }
            } else {
                self.presenter?.moviesSearchFailed()
            }
        }
    }
    
    private func searchOffline(_ query: String, forSource source: MovieSource) {
        if let movies = persistenceService.fetchMovies(query: query, inSource: source.rawValue) {
            self.presenter?.moviesSearchSuccess(moviesModelArray: movies)
        } else {
            self.presenter?.moviesSearchFailed()
        }
    }
}
