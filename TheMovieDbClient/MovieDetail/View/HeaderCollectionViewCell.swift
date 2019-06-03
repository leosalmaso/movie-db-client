//
//  HeaderCollectionViewCell.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 02/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var previewVideoImage: UIImageView!
    @IBOutlet weak var playImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillCell(withVideo video: Video) {
        previewVideoImage.af_setImage(withURL: video.videoPlaceholderUrl()!)
    }
    
}
