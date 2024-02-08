//
//  TextButton.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 29/1/2567 BE.
//

import UIKit

class TextButton: UIButton {
    
    init(title: String){
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .notoSansBold(size: 14)
        self.setTitleColor(.white , for: .normal)
        self.backgroundColor = .clear
        self.alpha = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
