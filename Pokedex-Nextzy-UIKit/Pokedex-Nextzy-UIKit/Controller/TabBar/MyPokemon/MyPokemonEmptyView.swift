//
//  MyPokemonEmptyView.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 28/1/2567 BE.
//

import UIKit

class MyPokemonEmptyView: UIView {
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Component
    let pokemonImageView: UIImageView = {
        let image = UIImage(named: "pikachu-back")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let emptyTextLabel: UILabel = {
        let label = UILabel()
        label.text = "You haven't added any Pokémon to your favorite list yet."
        label.textAlignment = .center
        label.textColor = .gray
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - UI Setup
    
    func setupUI(){
        self.backgroundColor = .white
        self.addSubview(pokemonImageView)
        self.addSubview(emptyTextLabel)
        
        self.pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        self.emptyTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.pokemonImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.pokemonImageView.bottomAnchor.constraint(equalTo: self.emptyTextLabel.topAnchor, constant: -10),
            self.pokemonImageView.heightAnchor.constraint(equalToConstant: 200),
            
            self.emptyTextLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.emptyTextLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 20),
            self.emptyTextLabel.widthAnchor.constraint(equalToConstant: 250)
            
        ])
        
        
    }


}
