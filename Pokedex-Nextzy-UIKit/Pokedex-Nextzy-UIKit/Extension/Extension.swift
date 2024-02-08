//
//  Extension.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 19/1/2567 BE.
//

import Foundation
import UIKit

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
    
    func tapToHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
