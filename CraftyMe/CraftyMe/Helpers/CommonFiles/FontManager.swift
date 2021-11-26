//
//  FontManager.swift
//  CraftyMe
//
//  Created by Daksh Upadhyay on 2021-11-26.
//  Copyright © 2021 CraftyMe. All rights reserved.

import Foundation
import UIKit

public enum MontserratFont: String {
    case regular = "Montserrat-Regular"
    case semiBold = "Montserrat-SemiBold"
    case semiBoldItalic = "Montserrat-SemiBoldItalic"
    case bold = "Montserrat-Bold"
}

class FontManager: NSObject {
    
    class func montserratFont(fontName: MontserratFont, size: CGFloat) -> UIFont {
        return UIFont(name: fontName.rawValue, size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
}
