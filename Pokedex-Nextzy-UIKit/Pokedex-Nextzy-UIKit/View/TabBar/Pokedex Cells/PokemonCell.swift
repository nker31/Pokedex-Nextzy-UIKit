//
//  PokemonCell.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 23/1/2567 BE.
//

import UIKit
import Kingfisher

class PokemonCell: UICollectionViewCell {
    // MARK: - Varibles
    static let identifier = "PokemonCell"
    
    // MARK: - UI Components
    lazy var pokemonName: UILabel = {
        let label = UILabel()
        label.font = .notoSansSemiBold(size: 18)
        label.textColor = .white
        return label
    }()
    
    lazy var pokemonImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let labelStackView = UIStackView()

    // MARK: - UI Setup
    func configPokemonCell(pokemon: Pokemon) {
        self.layer.cornerRadius = 20
        self.pokemonName.text = pokemon.name
        self.setColorBackgroundFromType(type: pokemon.types[0])
        self.setupCellUI()
        self.pokemonImage.kf.setImage(with: pokemon.imageUrl, placeholder: UIImage(named: "pokeball"))
        self.createPokemonTypeStackView(types: pokemon.types)
    }
    
    func setupCellUI() {
        self.addSubview(pokemonName)
        self.addSubview(pokemonImage)
        
        self.pokemonName.translatesAutoresizingMaskIntoConstraints = false
        self.pokemonImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.pokemonName.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            self.pokemonName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            
            self.pokemonImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            self.pokemonImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            self.pokemonImage.widthAnchor.constraint(equalToConstant: (self.frame.width / 2)),
            self.pokemonImage.heightAnchor.constraint(equalToConstant: (self.frame.width / 2))
        ])
    }
    
    func createPokemonTypeStackView(types: [String]) {
        labelStackView.subviews.forEach { $0.removeFromSuperview() }
        
        for type in types {
            let typeComponents = PokemonTypeOverlay(type: type)
            labelStackView.addArrangedSubview(typeComponents)
            
        }
        labelStackView.axis = .vertical
        labelStackView.spacing = 30
        
        self.addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: self.pokemonName.bottomAnchor, constant: 10),
            labelStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}


