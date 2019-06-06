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
import TTGSnackbar

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
    
    func showErrorMessage(_ message: String) {
        showMessage(message, backgroundColor: .red, duration: .middle)
    }
    
    func showMessage(_ message: String) {
        showMessage(message, backgroundColor: .yellow, duration: .middle)
    }
    
    private func showMessage(_ message: String, backgroundColor: UIColor, duration: TTGSnackbarDuration) {
        let snackbar = TTGSnackbar(message: message, duration: duration)
        snackbar.backgroundColor = backgroundColor
        snackbar.show()
    }
}
