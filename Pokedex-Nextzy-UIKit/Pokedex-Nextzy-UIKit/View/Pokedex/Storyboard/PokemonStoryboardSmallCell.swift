//
//  PokemonStoryboardSmallCell.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 9/2/2567 BE.
//

import UIKit

class PokemonStoryboardSmallCell: UICollectionViewCell {
    // MARK: - Varibles
    static let identifier = "PokemonStoryboardSmallCell"

    // MARK: - UI Components
    @IBOutlet weak var pokemonImageView: UIImageView!

    // MARK: - UI Setup
    func configPokemonCell(pokemon: Pokemon) {
        guard let type = pokemon.types.first else { return }
        setColorBackgroundFromType(type: type)
        pokemonImageView.kf.setImage(with: pokemon.imageUrl, placeholder: UIImage(named: "pokeball"))
    }
}
