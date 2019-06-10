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
    case Clip
    case OpeningCredits = "Opening Credits"
}


struct Video: Codable {
    let id: String
    let name: String
    let size: Int
    let key: String
    let type: VideoType
    
    func videoUrl() -> URL? {
        return URL(string: "https://www.youtube.com/watch?v=" + key)
    }
    
    func videoPlaceholderUrl() -> URL? {
        return URL(string: "https://img.youtube.com/vi/\(key)/hqdefault.jpg")
    }
}
