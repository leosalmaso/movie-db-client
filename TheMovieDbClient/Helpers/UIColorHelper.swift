//
//  UIColorHelper.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 08/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex:String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            self.init(red: 0.0 / 255.0,
                      green: 0.0 / 255.0,
                      blue: 0.0 / 255.0,
                      alpha: 1.0)
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
