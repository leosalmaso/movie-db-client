//
//  MainViewController.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 04/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    lazy var presenter: MainPresenter = {
        let presenter = MainPresenter()
        presenter.delegate = self
        return presenter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.initViewController()
    }
    
    
    func openSearch() {
        let searchVC = SearchMoviesRouter.createSearchModule()
        present(searchVC, animated: true, completion: nil)
    }
}

extension MainViewController: MainViewProtocol {
    func changeToTab(_ tabIndex: Int) {
        tabBarController?.selectedIndex = tabIndex
    }
    
    func addViewController(_ viewController: UIViewController, toTabPosition position: Int) {
        
        if let navigationController = viewControllers?[position] as? UINavigationController {
            navigationController.viewControllers.append(viewController)
        } else {
            
            //Create new Navigation Controller
            let navigationController = UINavigationController()
            
            //Create new tab
            let newTab = UITabBarItem(title: viewController.title ?? "", image: UIImage(named: "default_tab_bar"), tag: position)
            viewController.tabBarItem = newTab
            
            //Add navigation controller to tab position
            navigationController.viewControllers = [viewController]
            viewControllers?.insert(navigationController, at: position)
        }
    }
    
    
}
