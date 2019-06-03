//
//  MockHelper.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 29/05/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit

private enum MockFile: String {
    case topMovies = "top_response"
    case singleMovie = "movie_object"
    case movieVideos = "trailers_object"
}

class MockHelper {

    public static let sharedInstance: MockHelper = {
        return MockHelper()
    }()
    
    private lazy var decoder: JSONDecoder = {
        return JSONDecoder()
    }()
    
    private func urlForMock(mockFile: MockFile) -> URL? {
        return Bundle.main.url(forResource: mockFile.rawValue, withExtension: "json")
    }
    
    func sampleMovies() -> [Movie]? {
        guard let topUrl = urlForMock(mockFile: .topMovies) else {
            return nil
        }
        
        do {
            let jsonData = try Data(contentsOf: topUrl)
            let movies = try decoder.decode(PaginatedResponse<Movie>.self, from: jsonData)
            
            return movies.results
        } catch {
            print(error)
            return nil
        }
    }
    
    func sampleMovie() -> Movie? {
        guard let topUrl = urlForMock(mockFile: .singleMovie) else {
            return nil
        }
        
        do {
            let jsonData = try Data(contentsOf: topUrl)
            let movie = try decoder.decode(Movie.self, from: jsonData)
            
            return movie
        } catch {
            print(error)
            return nil
        }
    }
    
    func sampleMovieTrailers() -> Trailers? {
        guard let topUrl = urlForMock(mockFile: .movieVideos) else {
            return nil
        }
        
        do {
            let jsonData = try Data(contentsOf: topUrl)
            let trailers = try decoder.decode(Trailers.self, from: jsonData)
            
            return trailers
        } catch {
            print(error)
            return nil
        }
    }
}
