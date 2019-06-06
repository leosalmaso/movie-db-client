//
//  MovieCollectionViewCell.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 28/05/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit
import AlamofireImage


class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        movieImageView.image = UIImage(named: "placeholder")
        releaseDateLabel.text = ""
        scoreLabel.text = ""
    }
    
    func fillCell(withMovie movie: Movie) {
        
        titleLabel.text = movie.title
        
        if let imagePath = movie.imagePath(), let imageUrl = URL(string: imagePath) {
            movieImageView.af_setImage(withURL: imageUrl)
        }
        
        if let stringReleaseDate = movie.releaseDate, let releaseDate = DateHelper.sharedInstance.dateFromString(stringReleaseDate) {
            releaseDateLabel.text = String(DateHelper.sharedInstance.componentFromDate(releaseDate, component: .year))
        } else {
            releaseDateLabel.text = NSLocalizedString("UNKNOWN", comment: "Unknown information")
        }
        
        if let voteAverage = movie.voteAverage {
            scoreLabel.text = String(voteAverage)
        }
    }
}
