//
//  Extension.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 19/1/2567 BE.
//

import Foundation
import UIKit

extension UIColor {
    static var pinkPokemon: UIColor {
        return UIColor(red: 0.941, green: 0.388, blue: 0.396, alpha: 1)
    }
}

extension UIViewController{
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func setColorBackgroundFromType(type: String) {
        if let color = UIColor(named: type) {
            self.view.backgroundColor = color
        } else {
            self.view.backgroundColor = .gray
        }
    }
    
    enum DisplayType {
        case oneColumn
        case twoColumns
        case threeColumns
    }
}

extension UIView {
    func setColorBackgroundFromType(type: String) {
        if let color = UIColor(named: type) {
            self.backgroundColor = color
        } else {
            self.backgroundColor = .gray
        }
    }   
    
}

extension UIView {

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
