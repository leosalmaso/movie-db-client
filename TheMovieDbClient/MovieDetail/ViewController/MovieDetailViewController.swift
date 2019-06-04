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
    
    @IBOutlet weak var mediaCollectionView: UICollectionView! {
        didSet {
            let cell = UINib(nibName: "HeaderCollectionViewCell", bundle: nil)
            mediaCollectionView.register(cell, forCellWithReuseIdentifier: "HeaderCellIdentifier")
            mediaCollectionView.backgroundColor = .clear
            mediaCollectionView.isPagingEnabled = true
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var loadingVideoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovie(movie)
    }
    
    func loadMovie(_ movie: Movie) {
        titleLabel.text = movie.title
        
        if let stringReleaseDate = movie.releaseDate, let releaseDate = DateHelper.sharedInstance.dateFromString(stringReleaseDate) {
            releaseDateLabel.text = String(DateHelper.sharedInstance.componentFromDate(releaseDate, component: .year))
        }
        
        if let voteAverage = movie.voteAverage {
            scoreLabel.text = String(voteAverage)
        }
        
        overviewLabel.text = movie.overview
    }
}

extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.media?.videos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mediaCollectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCellIdentifier", for: indexPath) as! HeaderCollectionViewCell
        cell.fillCell(withVideo: movie.media!.videos[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = movie.media?.videos[indexPath.row], let movieUrl = movie.videoUrl() {
            loadingVideoView.isHidden = false
            playVideo(videoURL: movieUrl, completionHandler: { [weak self] in
                guard let self = self else { return }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.loadingVideoView.isHidden = true
                }
            })
        }
    }
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = view.frame.width
        return CGSize(width: cellWidth, height: cellWidth * 0.75)
    }
}
