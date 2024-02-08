//
//  PokemonTypeComponent.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 26/1/2567 BE.
//

import UIKit

class PokemonTypeComponent:UIView{
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
    var label: UILabel = {
        let label = UILabel()
        label.font = .notoSansSemiBold(size: 14)
        label.textColor = .white
        return label
    }()
    
    var labelOverlay: UIView = {
        let view = UIView()
        return view
    }()
    
    func setupUI(){
        label.text = self.type
        labelOverlay.setColorBackgroundFromType(type: type)
        labelOverlay.layer.cornerRadius = 10
        
        self.addSubview(labelOverlay)
        self.addSubview(label)
        
        labelOverlay.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: labelOverlay.topAnchor, constant: 5),
            label.bottomAnchor.constraint(equalTo: labelOverlay.bottomAnchor, constant: -5),
            label.leadingAnchor.constraint(equalTo: labelOverlay.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: labelOverlay.trailingAnchor, constant: -10),
            
            
            labelOverlay.topAnchor.constraint(equalTo: self.topAnchor),
            labelOverlay.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            labelOverlay.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            labelOverlay.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
        
        
    }
    
    
}
