//
//  MainMovieListViewController.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 27/05/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit
import PureLayout
import MXSegmentedControl

class MainMovieListViewController: UIViewController {

    @IBOutlet weak var movieCollectionView: UICollectionView! {
        didSet {
            let cell = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
            movieCollectionView.register(cell, forCellWithReuseIdentifier: "MovieCellIdentifier")
        }
    }
    
    @IBOutlet weak var categorySelector: MXSegmentedControl! {
        didSet {
            categorySelector.append(title: "Popular")
            categorySelector.append(title: "Top Rated")
            categorySelector.append(title: "Upcoming")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MainMovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCellIdentifier", for: indexPath)
        return cell
    }
}
