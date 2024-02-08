//
//  FontExtension.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 8/2/2567 BE.
//

import Foundation
import UIKit

extension UIFont {
    static func notoSansRegular(size: CGFloat) -> UIFont? {
        return UIFont(name: "NotoSansThai-Regular", size: size)
    }
    
    static func notoSansMedium(size: CGFloat) -> UIFont? {
        return UIFont(name: "NotoSansThai-Medium", size: size)
    }
    
    static func notoSansSemiBold(size: CGFloat) -> UIFont? {
        return UIFont(name: "NotoSansThai-SemiBold", size: size)
    }
    
    static func notoSansBold(size: CGFloat) -> UIFont? {
        return UIFont(name: "NotoSansThai-Bold", size: size)
    }
}

