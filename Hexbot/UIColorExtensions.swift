//
//  Extensions.swift
//  Hexbot
//
//  Created by Atheer on 2019-06-13.
//  Copyright © 2019 Atheer. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    // the method is public
    // convenience init? is used because even if we don't enter value which
    // is necessary for regular init we could give it a default value
    // it also must call another another initializer from the same class.
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            // we can't use the # it doesn't work so our start will begin from #
            // and start one forward told by the offsetBy value
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count > 5{
                // scanning parses string from hexColor
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    // Hex work by 0-9 and A-F
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
            
        }
        
        return nil
    }
}
