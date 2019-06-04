//
//  MainPresenter.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 04/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit

enum MainTabs: Int {
    case Movies = 0
    case Series = 1
}

protocol MainViewProtocol: class {
    func changeToTab(_ tabIndex: Int)
    func showMessage(_ message: String)
    func addViewController(_ viewController: UIViewController, toTabPosition position: Int)
}

class MainPresenter {
    weak var delegate : MainViewProtocol?
    
    func initViewController() {
        //Add Movie Tab
        delegate?.addViewController(MoviesRouter.createMoviesModule(), toTabPosition: 0)
        
        //Add Series Tab
        delegate?.addViewController(MoviesRouter.createSeriesModule(), toTabPosition: 1)
    }
}
