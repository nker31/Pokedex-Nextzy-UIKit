//
//  DetailDescriptionLabel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 13/2/2567 BE.
//

import UIKit

class DetailDescriptionLabel: UILabel {
    
    init(title: String){
        super.init(frame: .zero)
        self.text = title
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.textAlignment = .center
        self.font = .notoSansRegular(size: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
