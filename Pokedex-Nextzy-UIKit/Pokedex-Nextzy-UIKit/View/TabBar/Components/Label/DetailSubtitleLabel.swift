//
//  DetailSubtitleLabel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 13/2/2567 BE.
//

import UIKit

class DetailSubtitleLabel: UILabel{
    
    init(title: String){
        super.init(frame: .zero)
        self.text = title
        self.textColor = UIColor.gray
        self.font = .notoSansSemiBold(size: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
