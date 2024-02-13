//
//  PokemonTypeOverlay.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 29/1/2567 BE.
//

import UIKit

class PokemonTypeOverlay: UIView{
    var type: String
    
    init(type: String) {
        self.type = type
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    var label:UILabel = {
        let label = UILabel()
        label.font = .notoSansSemiBold(size: 12)
        label.textColor = .white
        return label
    }()
    
    var labelOverlay: UIView = {
        let view = UIView()
        return view
    }()
    
    func setupUI() {
        label.text = self.type
        labelOverlay.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        labelOverlay.layer.cornerRadius = 9
        
        self.addSubview(labelOverlay)
        self.addSubview(label)
        
        labelOverlay.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: labelOverlay.topAnchor, constant: 2),
            label.bottomAnchor.constraint(equalTo: labelOverlay.bottomAnchor, constant: -2),
            label.leadingAnchor.constraint(equalTo: labelOverlay.leadingAnchor, constant: 7),
            label.trailingAnchor.constraint(equalTo: labelOverlay.trailingAnchor, constant: -7),
            
            labelOverlay.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
