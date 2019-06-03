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
    
    //private
    private let cellInsets = UIEdgeInsets(top: 0.0, left: 7.5, bottom: 0.0, right: 7.5)
    private let collectionViewInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    private let items = MockHelper.sharedInstance.sampleMovies()

    
    //Outlets
    @IBOutlet weak var movieCollectionView: UICollectionView! {
        didSet {
            let cell = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
            movieCollectionView.register(cell, forCellWithReuseIdentifier: "MovieCellIdentifier")
            movieCollectionView.contentInset = collectionViewInsets
            movieCollectionView.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var categorySelector: MXSegmentedControl! {
        didSet {
            categorySelector.append(title: "Popular")
            categorySelector.append(title: "Top Rated")
            categorySelector.append(title: "Upcoming")
        }
    }
    
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MainMovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCellIdentifier", for: indexPath) as! MovieCollectionViewCell
        cell.fillCell(withMovie: items![indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = items?[indexPath.row] {
            
        }
    }
}

extension MainMovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (collectionView.frame.width / 2) - cellInsets.left - cellInsets.right
        return CGSize(width: cellWidth, height: cellWidth * 1.8)
    }
}
