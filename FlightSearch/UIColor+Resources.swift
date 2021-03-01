//
//  UIColor+Resources.swift
//  FlightSearch
//
//  Created by Andrey Ovsyannikov on 28.11.2020.
//  Copyright © 2020 home.com. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var backgroundPrimary: UIColor {
        dynamic(light: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), dark: #colorLiteral(red: 0.1411764706, green: 0.1450980392, blue: 0.1568627451, alpha: 1))
    }
    
    static var backgroundSecondary: UIColor {
        dynamic(light: #colorLiteral(red: 0.937254902, green: 0.9450980392, blue: 0.9529411765, alpha: 1), dark: #colorLiteral(red: 0.1137254902, green: 0.1176470588, blue: 0.1254901961, alpha: 1))
    }
    
    static var backgroundNavigation: UIColor {
        dynamic(light: #colorLiteral(red: 0.09411764706, green: 0.2588235294, blue: 0.537254902, alpha: 1), dark: #colorLiteral(red: 0.007843137255, green: 0.007843137255, blue: 0.007843137255, alpha: 1))
    }
    
    static var textPrimary: UIColor {
        dynamic(light: #colorLiteral(red: 0.05098039216, green: 0.07450980392, blue: 0.1098039216, alpha: 1), dark: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.937254902, alpha: 1))
    }
    
    static var textSecondary: UIColor {
        dynamic(light: #colorLiteral(red: 0.431372549, green: 0.4431372549, blue: 0.4666666667, alpha: 1), dark: #colorLiteral(red: 0.6196078431, green: 0.6196078431, blue: 0.6235294118, alpha: 1))
    }
    
    static var textPlaceholder: UIColor {
        dynamic(light: #colorLiteral(red: 0.6235294118, green: 0.6588235294, blue: 0.7098039216, alpha: 1), dark: #colorLiteral(red: 0.5450980392, green: 0.5607843137, blue: 0.5764705882, alpha: 1))
    }
    
    static var searchTint: UIColor {
        dynamic(light: #colorLiteral(red: 0.6235294118, green: 0.6588235294, blue: 0.7098039216, alpha: 1), dark: #colorLiteral(red: 0.5450980392, green: 0.5607843137, blue: 0.5764705882, alpha: 1))
    }
    
    static var searchClearTint: UIColor {
        dynamic(light: #colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.7529411765, alpha: 1), dark: #colorLiteral(red: 0.3490196078, green: 0.3490196078, blue: 0.3647058824, alpha: 1))
    }
    
    static var searchBackground: UIColor {
        dynamic(light: #colorLiteral(red: 0.9333333333, green: 0.937254902, blue: 0.9450980392, alpha: 1), dark: #colorLiteral(red: 0.1803921569, green: 0.1882352941, blue: 0.2039215686, alpha: 1))
    }
    
    static var accent: UIColor {
        dynamic(light: #colorLiteral(red: 0.1803921569, green: 0.4549019608, blue: 0.9607843137, alpha: 1), dark: #colorLiteral(red: 0.2196078431, green: 0.5098039216, blue: 0.9176470588, alpha: 1))
    }
    
    static var searchAccent: UIColor {
        dynamic(light: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), dark: #colorLiteral(red: 0.5411764706, green: 0.5607843137, blue: 0.5764705882, alpha: 1))
    }
    
    static var separator: UIColor {
        dynamic(light: #colorLiteral(red: 0.8039215686, green: 0.8274509804, blue: 0.862745098, alpha: 1), dark: #colorLiteral(red: 0.2392156863, green: 0.2470588235, blue: 0.262745098, alpha: 1))
    }
    
    static var white: UIColor {
        #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.937254902, alpha: 1)
    }
}

extension UIColor {
    
    private static func dynamic(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13, *) {
            return .init {
                switch $0.userInterfaceStyle {
                case .dark:
                    return dark
                case .light,
                     .unspecified:
                    return light
                @unknown default:
                    return light
                }
            }
        } else {
            return light
        }
    }
}
