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
    
    private lazy var decoder: JSONDecoder = {
        return JSONDecoder()
    }()
    
    private weak var presenter: InteractorToPresenterProtocol?
    
    init(presenter: InteractorToPresenterProtocol) {
        self.presenter = presenter
    }
    
    func fetchMovies(forCategory category: MovieCategory, page: Int) {
        restClient.fetch(movieType: .movie, forCategory: category.encodeToParam(), inPage: page) { [weak self] response in
            guard let self = self else { return }
            
            if let response = response {
                do {
                    let paginatedResponse = try self.decoder.decode(PaginatedResponse<Movie>.self, from: response)
                    self.presenter?.moviesFetchedSuccess(moviesModelArray: paginatedResponse.results, forCategory: category)
                    
                } catch {
                    print(error)
                    self.presenter?.moviesFetchFailed()
                }
            } else {
                self.presenter?.moviesFetchFailed()
            }
        }
    }
}
