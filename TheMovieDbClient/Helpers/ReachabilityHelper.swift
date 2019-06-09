//
//  ReachabilityHelper.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 08/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import Alamofire

class ReachabilityHelper {
    
    public static let sharedInstance: ReachabilityHelper = {
        return ReachabilityHelper()
    }()
    
    func isInternetConnectionAvailable() -> Bool {
       return NetworkReachabilityManager()!.isReachable
    }
}
