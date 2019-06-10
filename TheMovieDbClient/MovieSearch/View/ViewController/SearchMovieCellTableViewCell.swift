//
//  SearchMovieCellTableViewCell.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 09/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit
import AlamofireImage

class SearchMovieCellTableViewCell: UITableViewCell {

    static let identifier = "SearchCellIdentifier"
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func prepareForReuse() {
        movieImageView.image = UIImage(named:"placeholder")
        titleLabel.text = ""
        overviewLabel.text = ""
    }
    
    func fillCell(_ movie: Movie) {
        titleLabel.text = movie.title ?? movie.name
        overviewLabel.text = movie.overview
        
        if let imagePath = movie.imagePath(), let imageUrl = URL(string: imagePath) {
            movieImageView.af_setImage(withURL: imageUrl)
        }
    }
}
