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
        self.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        self.setTitleColor(.black, for: .normal)
        self.backgroundColor = .systemBackground
        self.alpha = 0.6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
