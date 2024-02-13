//
//  DetailTextLabel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 13/2/2567 BE.
//

import UIKit

class DetailTextLabel: UILabel{
    
    init(text: String){
        super.init(frame: .zero)
        self.text = text
        self.textColor = UIColor.label
        self.font = .notoSansRegular(size: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
