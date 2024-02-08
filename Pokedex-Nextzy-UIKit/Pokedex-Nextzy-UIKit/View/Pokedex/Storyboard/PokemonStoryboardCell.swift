//
//  PokemonStoryboardCell.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 8/2/2567 BE.
//

import UIKit

class PokemonStoryboardCell: UICollectionViewCell {
    // MARK: - Varibles
    static let identifier = "PokemonStoryboardCell"

    // MARK: - UI Components
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!

    // MARK: - UI Setup
    func configPokemonCell(pokemon: Pokemon) {
        pokemonNameLabel.text = pokemon.name
        guard let type = pokemon.types.first else { return }
        setColorBackgroundFromType(type: type)
        pokemonImageView.kf.setImage(with: pokemon.imageUrl, placeholder: UIImage(named: "pokeball"))
    }
}
