//
//  UIColor+Extension.swift
//  Contacts
//
//  Created by Tirupati Balan on 17/04/19.
//  Copyright © 2019 Tirupati Balan. All rights reserved.
//

import Foundation

extension UIColor {
    class func themeColor(a : CGFloat? = 1.0) -> UIColor {
        if let color = UIColor.init(hex: "#50E3C2", a : a) {
            return color
        }
        return UIColor.blue
    }
    
    class func tableViewBackgroundColor(a : CGFloat? = 1.0) -> UIColor {
        if let color = UIColor.init(hex: "#F9F9F9", a : a) {
            return color
        }
        return UIColor.darkGray
    }

    class func navigationTitleColor(a : CGFloat? = 1.0) -> UIColor {
        if let color = UIColor.init(hex: "#4A4A4A", a : a) {
            return color
        }
        return UIColor.darkGray
    }
    
    class func tableViewSeparatorLineColor() -> UIColor {
        if let color = UIColor.init(hex: "#F0F0F0") {
            return color
        }
        return UIColor.lightGray
    }
    
    class func tableViewGroupHeaderColor(a : CGFloat? = 1.0) -> UIColor {
        if let color = UIColor.init(hex: "#E8E8E8", a: a) {
            return color
        }
        return UIColor.darkGray
    }

    
    public convenience init?(hex: String, a : CGFloat? = 1.0) {
        let r, g, b, alpha: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt32 = 0
                
                if scanner.scanHexInt32(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0xff00) >> 8) / 255
                    b = CGFloat((hexNumber & 0xff) >> 0) / 255
                    alpha = a!
                    
                    self.init(red: r, green: g, blue: b, alpha: alpha)
                    return
                }
            }
        }
        
        return nil
    }
}
