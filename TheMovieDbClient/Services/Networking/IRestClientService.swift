//
//  IRestClientService.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 18/05/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit

protocol IRestClientService {
    func fetch(movieType: String, forCategory category: String, inPage page: Int, completion: @escaping (Data?) -> Void)
}
