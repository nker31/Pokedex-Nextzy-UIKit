//
//  DetailTextCompents.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 26/1/2567 BE.
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

class DetailDescription: UILabel{
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


