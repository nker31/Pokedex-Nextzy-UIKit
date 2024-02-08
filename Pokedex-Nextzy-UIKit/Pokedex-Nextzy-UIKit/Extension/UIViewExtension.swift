//
//  UIViewExtension.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 8/2/2567 BE.
//

import Foundation
import UIKit

extension UIView {
    
    func setColorBackgroundFromType(type: String) {
        if let color = UIColor(named: type) {
            self.backgroundColor = color
        } else {
            self.backgroundColor = .gray
        }
    }

    static func spacer(size: CGFloat = 50, for layout: NSLayoutConstraint.Axis = .horizontal) -> UIView {
        let spacer = UIView()
        
        if layout == .horizontal {
            spacer.widthAnchor.constraint(equalToConstant: size).isActive = true
        } else {
            spacer.heightAnchor.constraint(equalToConstant: size).isActive = true
        }
        
        return spacer
    }

}
