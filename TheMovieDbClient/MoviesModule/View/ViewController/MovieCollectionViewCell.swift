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
        
        titleLabel.text = movie.title ?? movie.name
        scoreLabel.text = String(movie.voteAverage)
        
        if let imagePath = movie.imagePath(), let imageUrl = URL(string: imagePath) {
            movieImageView.af_setImage(withURL: imageUrl)
        }
        
        let dateToShow = movie.releaseDate ?? movie.firsAirDate
        
        if let releaseDate = dateToShow {
            releaseDateLabel.text = String(DateHelper.sharedInstance.componentFromDate(releaseDate, component: .year))
        } else {
            releaseDateLabel.text = NSLocalizedString("UNKNOWN", comment: "Unknown information")
        }
    }
}
