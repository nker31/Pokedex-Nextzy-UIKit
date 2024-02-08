//
//  CustomButton.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 19/1/2567 BE.
//

import UIKit

class CustomButton: UIButton {

    init(title: String, cornerRadius: CGFloat = 0){
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .notoSansMedium(size: 18)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = UIColor(red: 0.941, green: 0.388, blue: 0.396, alpha: 1)
        self.alpha = 1
        self.layer.cornerRadius = cornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
