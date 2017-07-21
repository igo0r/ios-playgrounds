//
//  UIColor.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 25/04/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        self.init(hex: hex, alpha:1)
    }
    
    /*
     hex color creation
     */
    convenience init(hex: String, alpha: CGFloat) {
        var hexWithoutSymbol = hex
        if hexWithoutSymbol.hasPrefix("#") {
            hexWithoutSymbol.remove(at: hex.startIndex)
        }
        
        let scanner = Scanner(string: hexWithoutSymbol)
        var hexInt:UInt32 = 0x0
        scanner.scanHexInt32(&hexInt)
        
        var r:UInt32!, g:UInt32!, b:UInt32!
        switch (hexWithoutSymbol.characters.count) {
        case 3: // #RGB
            r = ((hexInt >> 4) & 0xf0 | (hexInt >> 8) & 0x0f)
            g = ((hexInt >> 0) & 0xf0 | (hexInt >> 4) & 0x0f)
            b = ((hexInt << 4) & 0xf0 | hexInt & 0x0f)
            break;
        case 6: // #RRGGBB
            r = (hexInt >> 16) & 0xff
            g = (hexInt >> 8) & 0xff
            b = hexInt & 0xff
            break;
        default:
            break;
        }
        
        self.init(
            red: (CGFloat(r)/255),
            green: (CGFloat(g)/255),
            blue: (CGFloat(b)/255),
            alpha:alpha)
    }
    
    func blended(withFraction fraction: CGFloat, of color: UIColor) -> UIColor {
        var r1: CGFloat = 1.0, g1: CGFloat = 1.0, b1: CGFloat = 1.0, a1: CGFloat = 1.0
        var r2: CGFloat = 1.0, g2: CGFloat = 1.0, b2: CGFloat = 1.0, a2: CGFloat = 1.0
        
        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        return UIColor(red: r1 * (1 - fraction) + r2 * fraction,
                       green: g1 * (1 - fraction) + g2 * fraction,
                       blue: b1 * (1 - fraction) + b2 * fraction,
                       alpha: a1 * (1 - fraction) + a2 * fraction);
    }
}
