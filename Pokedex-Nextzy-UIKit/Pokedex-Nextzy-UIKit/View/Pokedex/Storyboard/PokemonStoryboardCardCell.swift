//
//  PokemonStoryboardCardCell.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 9/2/2567 BE.
//

import UIKit

class PokemonStoryboardCardCell: UICollectionViewCell {
    // MARK: - Varibles
    static let identifier = "PokemonStoryboardCardCell"

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
