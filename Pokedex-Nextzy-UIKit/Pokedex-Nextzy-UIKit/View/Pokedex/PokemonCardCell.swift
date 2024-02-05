//
//  PokemonCardCell.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 1/2/2567 BE.
//

import UIKit
import Kingfisher

class PokemonCardCell: UICollectionViewCell {
    // MARK: - Varibles
    static let identifier = "PokemonCardCell"
    
    // MARK: - UI Components
    lazy var pokemonName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    lazy var pokemonImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // MARK: - UI Setup
    func configPokemonCell(pokemon: Pokemon) {
        self.layer.cornerRadius = 22
        self.pokemonName.text = pokemon.name
        self.setColorBackgroundFromType(type: pokemon.types[0])
        self.setupCellUI()
        self.pokemonImage.kf.setImage(with: pokemon.imageUrl, placeholder: UIImage(named: "pokeball-profile"))
        self.createPokemonTypeStackView(types: pokemon.types)
    }
    
    func setupCellUI() {
        self.addSubview(pokemonName)
        self.addSubview(pokemonImage)
        self.pokemonName.translatesAutoresizingMaskIntoConstraints = false
        self.pokemonImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.pokemonName.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.pokemonName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            
            self.pokemonImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.pokemonImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            
            self.pokemonImage.widthAnchor.constraint(equalToConstant: (self.frame.height / 1.2)),
            self.pokemonImage.heightAnchor.constraint(equalToConstant: (self.frame.height / 1.2)),
        
        ])
    }
    
    func createPokemonTypeStackView(types:[String]) {
        var items: [UIView] = []
        for type in types {
            let typeComponents = PokemonTypeOverlay(type: type)
            items.append(typeComponents)
        }
        
        let labelStackView = UIStackView(arrangedSubviews: items)
        labelStackView.axis = .vertical
        labelStackView.spacing = 30
        
        self.addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: self.pokemonName.bottomAnchor, constant: 10),
            labelStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        self.pokemonName.text = nil
        self.pokemonImage.image = nil
        
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
}
