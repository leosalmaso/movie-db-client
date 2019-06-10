//
//  Trailers.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 02/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import Foundation

struct Trailers: Codable {
    let videos: [Video]?
}

extension Trailers {
    enum CodingKeys: String, CodingKey {
        case videos = "results"
    }
}
