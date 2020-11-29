//
//  UIColor+Resources.swift
//  FlightSearch
//
//  Created by Андрей Овсянников on 28.11.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var backgroundPrimary: UIColor {
        dynamic(light: "#fefefe", dark: "#242528")
    }
    
    static var backgroundSecondary: UIColor {
        dynamic(light: "#eff1f3", dark: "#1d1e20")
    }
    
    static var backgroundNavigation: UIColor {
        dynamic(light: "#184289", dark: "#020202")
    }
    
    static var textPrimary: UIColor {
        dynamic(light: "#0d131c", dark: "#eeeeef")
    }
    
    static var textSecondary: UIColor {
        dynamic(light: "#6e7177", dark: "#9e9e9f")
    }
    
    static var textPlaceholder: UIColor {
        dynamic(light: "#9fa8b5", dark: "#8b8f93")
    }
    
    static var searchTint: UIColor {
        dynamic(light: "#9fa8b5", dark: "#8b8f93")
    }
    
    static var searchClearTint: UIColor {
        dynamic(light: "#bfbfc0", dark: "#59595d")
    }
    
    static var searchBackground: UIColor {
        dynamic(light: "#eeeff1", dark: "#2e3034")
    }
    
    static var searchAccent: UIColor {
        dynamic(light: "#2e74f5", dark: "#3882ea")
    }
}

extension UIColor {
    
    convenience init?(hex6: String) {
        guard hex6.hasPrefix("#") else {
            return nil
        }
        
        let startIndex = hex6.index(hex6.startIndex, offsetBy: 1)
        let hexString = String(hex6[startIndex...])
        
        guard hexString.count == 6 else {
            return nil
        }
        
        let scanner = Scanner(string: hexString)
        var hexNumber: UInt64 = 0
        guard scanner.scanHexInt64(&hexNumber) else {
            return nil
        }
        
        let r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255;
        let g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255;
        let b = CGFloat(hexNumber & 0x0000FF) / 255;
        
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
    
    private static func dynamic(light: String, dark: String) -> UIColor {
        if #available(iOS 13, *) {
            return .init {
                switch $0.userInterfaceStyle {
                case .dark:
                    return UIColor(hex6: dark)!
                case .light,
                     .unspecified:
                    return UIColor(hex6: light)!
                @unknown default:
                    return UIColor(hex6: light)!
                }
            }
        } else {
            return UIColor(hex6: light)!
        }
    }
}
