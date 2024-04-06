//
//  UIColorExtension.swift
//  WeMoney
//
//  Created by Yannick Edouard MEKONGO ABANDA on 12/10/2022.
//

import Foundation

import UIKit

extension UIColor {

    
    convenience init(hex: String) {
        let hexa = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hexa).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hexa.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (0, 255, 255, 255)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }

    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
    func isLight() -> Bool {
        if let colorSpace = self.cgColor.colorSpace {
            if colorSpace.model == .rgb {
                guard let components = cgColor.components, components.count > 2 else
                {return false}
                let brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
                return (brightness > 0.5)
            }
            else
            {
                var white : CGFloat = 0.0
                self.getWhite(&white, alpha: nil)
                return white >= 0.5 }
        }
        return false
    }
    
    func isTransparent() -> Bool {
        return self.cgColor.alpha == 0.0
    }

}
