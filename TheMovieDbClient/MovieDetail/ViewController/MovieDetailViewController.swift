//
//  MovieDetailViewController.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 02/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    let movie = MockHelper.sharedInstance.sampleMovie()!
    let movieVideos = MockHelper.sharedInstance.sampleMovieTrailers()?.youtube
    
    //private
    private let cellInsets = UIEdgeInsets(top: 0.0, left: 7.5, bottom: 0.0, right: 7.5)
    
    @IBOutlet weak var mediaCollectionView: UICollectionView! {
        didSet {
            let cell = UINib(nibName: "HeaderCollectionViewCell", bundle: nil)
            mediaCollectionView.register(cell, forCellWithReuseIdentifier: "HeaderCellIdentifier")
            mediaCollectionView.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieVideos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mediaCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCellIdentifier", for: indexPath) as! HeaderCollectionViewCell
        cell.fillCell(withVideo: movieVideos![indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = movieVideos?[indexPath.row] {
            
        }
    }
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (collectionView.frame.width / 2) - cellInsets.left - cellInsets.right
        return CGSize(width: cellWidth, height: cellWidth * 0.67)
    }
}
