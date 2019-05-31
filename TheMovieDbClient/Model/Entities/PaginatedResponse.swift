//
//  PaginatedResponse.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 29/05/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit

struct PaginatedResponse<T:Codable>: Codable {
    let page: Int
    let total: Int
    let totalPage: Int
    let results: [T]
}

extension PaginatedResponse {
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case total = "total_results"
        case totalPage = "total_pages"
        case results = "results"
    }
}
