//
//  DetailTitleLabel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 13/2/2567 BE.
//

import UIKit

class DetailTitleLabel: UILabel{
    
    init(title: String){
        super.init(frame: .zero)
        self.text = title
        self.textColor = UIColor.pinkPokemon
        self.font = .notoSansSemiBold(size: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
