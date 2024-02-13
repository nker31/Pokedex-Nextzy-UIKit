//
//  StatCellStoryboard.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 11/2/2567 BE.
//

import UIKit

class StatCellStoryboard: UITableViewCell {
    
    // MARK: - Varibles
    static let identifier = "StatCellStoryboard"
    private var pokemon: Pokemon?
    
    // MARK: - UI Components
    @IBOutlet weak var hpStatLabel: UILabel!
    @IBOutlet weak var attackStatLabel: UILabel!
    @IBOutlet weak var defenseStatLabel: UILabel!
    @IBOutlet weak var spAttackStatLabel: UILabel!
    @IBOutlet weak var spDefenseStatLabel: UILabel!
    @IBOutlet weak var speedStatLabel: UILabel!
    @IBOutlet weak var totalStatLabel: UILabel!
    
    @IBOutlet weak var hpStatBar: UIProgressView!
    @IBOutlet weak var attackStatBar: UIProgressView!
    @IBOutlet weak var defenseStatBar: UIProgressView!
    @IBOutlet weak var spAttackStatBar: UIProgressView!
    @IBOutlet weak var spDefenseStatBar: UIProgressView!
    @IBOutlet weak var speedStatBar: UIProgressView!
    @IBOutlet weak var totalStatBar: UIProgressView!
    @IBOutlet weak var weaknessStack: UIStackView!
    
    // MARK: - Life Cycle
    
    
    // MARK: - UI Setup
    func configCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        setupUI()
    }
    
    func setupUI() {
        guard let pokemon = self.pokemon else { return }
        hpStatLabel.text = String(pokemon.hp)
        attackStatLabel.text = String(pokemon.attack)
        defenseStatLabel.text = String(pokemon.defense)
        spAttackStatLabel.text = String(pokemon.specialAttack ?? 1)
        spDefenseStatLabel.text = String(pokemon.specialDefense ?? 1)
        speedStatLabel.text = String(pokemon.speed)
        totalStatLabel.text = String(pokemon.total)
        
        hpStatBar.progress = Float(pokemon.hp) / Float(100)
        attackStatBar.progress = Float(pokemon.attack) / Float(100)
        defenseStatBar.progress = Float(pokemon.defense) / Float(100)
        spAttackStatBar.progress = Float(pokemon.specialAttack ?? 1) / Float(100)
        spDefenseStatBar.progress = Float(pokemon.specialDefense ?? 1) / Float(100)
        speedStatBar.progress = Float(pokemon.speed) / Float(100)
        totalStatBar.progress = Float(pokemon.total) / Float(600)
        
        createPokemonTypeStackView(types: pokemon.weaknesses)
    }
    
    func createPokemonTypeStackView(types: [String]) {
        weaknessStack.subviews.forEach { $0.removeFromSuperview() }
        for type in types {
            let typeComponents = PokemonTypeComponent(type: type)
            weaknessStack.addArrangedSubview(typeComponents)
        }
    }
}
