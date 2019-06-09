//
//  RestClientService.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 20/05/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit
import Alamofire

class RestClientService: IRestClientService {
    
    //All of theses properties should be in a safter place. This is only to simplify the code
    private let baseUrl = "https://api.themoviedb.org/3/"
    private let apiKey = "ac38b6fbf191c9aaf5c4c8235f31066d"
    
    func fetch(movieType type: String, forCategory category: String, inPage page: Int, completion: @escaping (Data?) -> Void) {
        let path = "\(type)/\(category)"
        fetch(from: path, withParams: nil) { response in
            
            guard let response = response else {
                completion(nil)
                return
            }
            
            completion(response)
        }
    }
    
    private func fetch(from path: String, withParams params: [String : Any]?, completion: @escaping (Data?) -> Void) {
        
        guard let url = URL(string: baseUrl + path) else {
            completion(nil)
            return
        }
        
        Alamofire.request(url,
                          method: .get,
                          parameters: encodeBaseParameters(params))
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms:\(String(describing: response.result.error))")
                    completion(nil)
                    return
                }
                
                guard let value = response.data else {
                        print("Malformed data received from fetch")
                        completion(nil)
                        return
                }
                
                completion(value)
        }
    }
    
    //On this function we can add repetitive params
    private func encodeBaseParameters(_ params: [String : Any]?) -> [String : Any] {
        
        let newParams: [String: Any] = ["api_key" : apiKey]
        
        guard let params = params else {
            return newParams
        }
        
        return newParams.merging(params) { (newParams, params) in newParams }
    }
}


