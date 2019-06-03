//
//  Video.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 02/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import Foundation

enum VideoType: String, Codable {
    case Teaser
    case Featurette
    case Trailer
}

struct Video: Codable {
    let name: String
    let size: String
    let source: String
    let type: VideoType
    
    func videoUrl() -> URL? {
        return URL(string: "https://www.youtube.com/watch?v=" + source)
    }
    
    func videoPlaceholderUrl() -> URL? {
        return URL(string: "https://img.youtube.com/vi/\(source)/hqdefault.jpg")
    }
}
