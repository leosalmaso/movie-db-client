//
//  UIViewControllerHelper.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 03/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import Foundation
import AVKit
import YoutubeDirectLinkExtractor

extension UIViewController {
    func playVideo(videoURL: URL, completionHandler: @escaping () -> Void) {
        
        let y = YoutubeDirectLinkExtractor()
        y.extractInfo(for: .urlString(videoURL.absoluteString), success: { [weak self] info in
            guard let self = self, let loLink = info.lowestQualityPlayableLink, let loUrl = URL(string:loLink) else { return }
            
            let player = AVPlayer(url: loUrl)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            
            self.present(playerViewController, animated: true) {
                player.play()
            }
            completionHandler()
        }) { error in
            completionHandler()
            print(error)
        }
    }
}
