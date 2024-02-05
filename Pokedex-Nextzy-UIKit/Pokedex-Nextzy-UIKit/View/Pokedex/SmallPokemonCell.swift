//
//  SmallPokemonCell.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 24/1/2567 BE.
//

import UIKit
import Kingfisher

class SmallPokemonCell: UICollectionViewCell {
    // MARK: - Varibles
    static let identifier = "SmallPokemonCell"
    
    // MARK: - UI Components
    
    lazy var pokemonImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // MARK: - UI Setup
    func configPokemonCell(pokemon: Pokemon){
        self.layer.cornerRadius = 10
        self.setColorBackgroundFromType(type: pokemon.types[0])
        self.setupCellUI()
        self.pokemonImage.kf.setImage(with: pokemon.imageUrl, placeholder: UIImage(named: "pokeball-profile"))
    }
    
    func setupCellUI(){
        self.addSubview(pokemonImage)
        self.pokemonImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            self.pokemonImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.pokemonImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.pokemonImage.widthAnchor.constraint(equalToConstant: (self.frame.width / 1.5)),
            self.pokemonImage.heightAnchor.constraint(equalToConstant: (self.frame.width / 1.5))
        
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        self.pokemonImage.image = nil
        self.backgroundColor = .white
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
}


