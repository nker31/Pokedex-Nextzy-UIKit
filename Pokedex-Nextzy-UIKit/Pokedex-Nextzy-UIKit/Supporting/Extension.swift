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
    func setColorBackgroundFromType(type: String){
        switch type{
        case "Fire":
            self.view.backgroundColor = UIColor(red: 1, green: 0.616, blue: 0.333, alpha: 1) // #ff9d55
        case "Water":
            self.view.backgroundColor = UIColor(red: 0.302, green: 0.565, blue: 0.839, alpha: 1) // #4d90d6
        case "Grass":
            self.view.backgroundColor = UIColor(red: 0.392, green: 0.733, blue: 0.365, alpha: 1) // #64bb5d
        case "Ground":
            self.view.backgroundColor = UIColor(red: 0.851, green: 0.467, blue: 0.275, alpha: 1) // #d97746
        case "Electric":
            self.view.backgroundColor = UIColor(red: 0.945, green: 0.835, blue: 0.227, alpha: 1) // #f1d53a
        case "Poison":
            self.view.backgroundColor = UIColor(red: 0.667, green: 0.42, blue: 0.784 , alpha: 1) // #aa6bc8
        case "Psychic":
            self.view.backgroundColor = UIColor(red: 0.973, green: 0.439, blue: 0.463, alpha: 1) // #f87076
        case "Fighting":
            self.view.backgroundColor = UIColor(red: 0.812, green: 0.243, blue: 0.42, alpha: 1) // #cf3e6b
        case "Ghost":
            self.view.backgroundColor = UIColor(red: 0.322, green: 0.412, blue: 0.678, alpha: 1) // #5269ad
        case "Dragon":
            self.view.backgroundColor = UIColor(red: 0.031, green: 0.424, blue: 0.765, alpha: 1) // #086cc3
        case "Fairy":
            self.view.backgroundColor = UIColor(red: 0.929, green: 0.565, blue: 0.902, alpha: 1) // #ed90e6
        case "Flying":
            self.view.backgroundColor = UIColor(red: 0.557, green: 0.663, blue: 0.871, alpha: 1) // #8ea9de
        case "Normal":
            self.view.backgroundColor = UIColor(red: 0.569, green: 0.6, blue: 0.639, alpha: 1) // #9199a3
        case "Rock" :
            self.view.backgroundColor = UIColor(red: 0.773, green: 0.718, blue: 0.549, alpha: 1) // #c5b78c
        case "Bug":
            self.view.backgroundColor = UIColor(red: 0.569, green: 0.753, blue: 0.176, alpha: 1) // #91c02d
        case "Ice":
            self.view.backgroundColor = UIColor(red: 0.447, green: 0.808, blue: 0.745, alpha: 1) // #72cebe
        case "Steel":
            self.view.backgroundColor = UIColor(red: 0.353, green: 0.557, blue: 0.627, alpha: 1) // #5a8ea0
        default:
            self.view.backgroundColor = .gray
        }
    }
    
    enum DisplayType{
        case oneColumn
        case twoColumns
        case threeColumns
    }
}

extension UIView{
    func setColorBackgroundFromType(type: String){
        switch type{
        case "Fire":
            self.backgroundColor = UIColor(red: 1, green: 0.616, blue: 0.333, alpha: 1) // #ff9d55
        case "Water":
            self.backgroundColor = UIColor(red: 0.302, green: 0.565, blue: 0.839, alpha: 1) // #4d90d6
        case "Grass":
            self.backgroundColor = UIColor(red: 0.392, green: 0.733, blue: 0.365, alpha: 1) // #64bb5d
        case "Ground":
            self.backgroundColor = UIColor(red: 0.851, green: 0.467, blue: 0.275, alpha: 1) // #d97746
        case "Electric":
            self.backgroundColor = UIColor(red: 0.945, green: 0.835, blue: 0.227, alpha: 1) // #f1d53a
        case "Poison":
            self.backgroundColor = UIColor(red: 0.667, green: 0.42, blue: 0.784 , alpha: 1) // #aa6bc8
        case "Psychic":
            self.backgroundColor = UIColor(red: 0.973, green: 0.439, blue: 0.463, alpha: 1) // #f87076
        case "Fighting":
            self.backgroundColor = UIColor(red: 0.812, green: 0.243, blue: 0.42, alpha: 1) // #cf3e6b
        case "Ghost":
            self.backgroundColor = UIColor(red: 0.322, green: 0.412, blue: 0.678, alpha: 1) // #5269ad
        case "Dragon":
            self.backgroundColor = UIColor(red: 0.031, green: 0.424, blue: 0.765, alpha: 1) // #086cc3
        case "Fairy":
            self.backgroundColor = UIColor(red: 0.929, green: 0.565, blue: 0.902, alpha: 1) // #ed90e6
        case "Flying":
            self.backgroundColor = UIColor(red: 0.557, green: 0.663, blue: 0.871, alpha: 1) // #8ea9de
        case "Normal":
            self.backgroundColor = UIColor(red: 0.569, green: 0.6, blue: 0.639, alpha: 1) // #9199a3
        case "Rock" :
            self.backgroundColor = UIColor(red: 0.773, green: 0.718, blue: 0.549, alpha: 1) // #c5b78c
        case "Bug":
            self.backgroundColor = UIColor(red: 0.569, green: 0.753, blue: 0.176, alpha: 1) // #91c02d
        case "Ice":
            self.backgroundColor = UIColor(red: 0.447, green: 0.808, blue: 0.745, alpha: 1) // #72cebe
        case "Steel":
            self.backgroundColor = UIColor(red: 0.353, green: 0.557, blue: 0.627, alpha: 1) // #5a8ea0
        default:
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
