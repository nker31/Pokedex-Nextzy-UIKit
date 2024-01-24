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
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        
        return label
    }()
    
    lazy var pokemonImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    
    // MARK: - Life Cycle
    
    
    // MARK: - UI Setup
    func configPokemonCell(pokemon: Pokemon){
        self.layer.cornerRadius = 20
        self.pokemonName.text = pokemon.name
        self.setPokemonCellBGColor(type: pokemon.types[0])
        self.setupCellUI()
        self.pokemonImage.kf.setImage(with: pokemon.imageUrl, placeholder: UIImage(named: "pokeball-profile"))
        self.createPokemonTypeStackView(types: pokemon.types)
        
    }
    
    func setupCellUI(){
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
    
    func createPokemonTypeStackView(types:[String]){
        var items: [UIView] = []
        for type in types {
            let label = UILabel()
            label.text = type
            label.font = .systemFont(ofSize: 13,weight: .semibold)
            label.textColor = .white
            items.append(label)
            
        }
        let labelStackView = UIStackView(arrangedSubviews: items)
        labelStackView.axis = .vertical
        labelStackView.spacing = 5
        
        self.addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: self.pokemonName.bottomAnchor, constant: 10),
            labelStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15)
        ])
    }
    
    
    private func setPokemonCellBGColor(type: String){
        switch type{
        case "Fire":
            self.backgroundColor = UIColor(red: 1, green: 0.616, blue: 0.333, alpha: 1) // #ff9d55
        case "Water":
            self.backgroundColor = UIColor(red: 0.302, green: 0.565, blue: 0.839, alpha: 1) // #4d90d6
        case "Grass":
            self.backgroundColor = UIColor(red: 0.392, green: 0.733, blue: 0.365, alpha: 1) // #64bb5d
        case "Ground":
            self.backgroundColor = UIColor(red: 0.851, green: 0.467, blue: 0.275, alpha: 1) // #d97746
        case "Electric":
            self.backgroundColor = UIColor(red: 0.945, green: 0.835, blue: 0.227, alpha: 1) // #f1d53a
        case "Poison":
            self.backgroundColor = UIColor(red: 0.667, green: 0.42, blue: 0.784 , alpha: 1) // #aa6bc8
        case "Psychic":
            self.backgroundColor = UIColor(red: 0.973, green: 0.439, blue: 0.463, alpha: 1) // #f87076
        case "Fighting":
            self.backgroundColor = UIColor(red: 0.812, green: 0.243, blue: 0.42, alpha: 1) // #cf3e6b
        case "Ghost":
            self.backgroundColor = UIColor(red: 0.322, green: 0.412, blue: 0.678, alpha: 1) // #5269ad
        case "Dragon":
            self.backgroundColor = UIColor(red: 0.031, green: 0.424, blue: 0.765, alpha: 1) // #086cc3
        case "Fairy":
            self.backgroundColor = UIColor(red: 0.929, green: 0.565, blue: 0.902, alpha: 1) // #ed90e6
        case "Flying":
            self.backgroundColor = UIColor(red: 0.557, green: 0.663, blue: 0.871, alpha: 1) // #8ea9de
        case "Normal":
            self.backgroundColor = UIColor(red: 0.569, green: 0.6, blue: 0.639, alpha: 1) // #9199a3
        case "Rock" :
            self.backgroundColor = UIColor(red: 0.773, green: 0.718, blue: 0.549, alpha: 1) // #c5b78c
        case "Bug":
            self.backgroundColor = UIColor(red: 0.569, green: 0.753, blue: 0.176, alpha: 1) // #91c02d
        case "Ice":
            self.backgroundColor = UIColor(red: 0.447, green: 0.808, blue: 0.745, alpha: 1) // #72cebe
        case "Steel":
            self.backgroundColor = UIColor(red: 0.353, green: 0.557, blue: 0.627, alpha: 1) // #5a8ea0
        default:
            self.backgroundColor = .gray
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()

        self.pokemonName.text = nil
        self.pokemonImage.image = nil
        self.backgroundColor = .white
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }

    
    // MARK: - Selectors
    
}


