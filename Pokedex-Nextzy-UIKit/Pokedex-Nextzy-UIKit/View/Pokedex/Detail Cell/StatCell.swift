//
//  StatCell.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 25/1/2567 BE.
//

import UIKit


class StatCell: UITableViewCell {
    static let identifier = "statCell"
    var pokemon: Pokemon?
    
    
    func configCell(pokemon: Pokemon){
        self.pokemon = pokemon
        self.setupUI()
    }
    
    func setupUI(){
        if let pokemon = self.pokemon{
            self.backgroundColor = .white
            let hpStatBar = StatBar(label: "HP", stat: pokemon.hp )
            let attackStatBar = StatBar(label: "Attack", stat: pokemon.hp )
            let defenseStatBar = StatBar(label: "Defense", stat: pokemon.hp)
            let specialAttackStatBar = StatBar(label: "Sp.ATK", stat: pokemon.hp)
            let specialDefenseStatBar = StatBar(label: "Sp.DEF", stat: pokemon.hp)
            let speedStatBar = StatBar(label: "Speed", stat: pokemon.hp)
            let totalStatBar = StatBar(label: "Total", stat: pokemon.total, maxStat: 600)
            
            let weaknessTitle = DetailTitleLabel(title: "Weakness")
            var weaknessArray: [UIView] = []
            for type in pokemon.weaknesses{
                weaknessArray.append(PokemonTypeComponent(type: type))
            }
            let weaknessStack = UIStackView(arrangedSubviews: weaknessArray)
            weaknessStack.axis = .horizontal
            weaknessStack.spacing = 10
            
            let stack = UIStackView(arrangedSubviews: [
                hpStatBar,
                attackStatBar,
                defenseStatBar,
                specialAttackStatBar,
                specialDefenseStatBar,
                speedStatBar,
                totalStatBar
            ])
            stack.axis = .vertical
            stack.spacing = 30
            self.addSubview(stack)
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            
            NSLayoutConstraint.activate([
                stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
                stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            ])
            
            self.addSubview(weaknessTitle)
            self.addSubview(weaknessStack)
            weaknessTitle.translatesAutoresizingMaskIntoConstraints = false
            weaknessStack.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                weaknessTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                weaknessTitle.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 60),
                weaknessStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                weaknessStack.topAnchor.constraint(equalTo: weaknessTitle.bottomAnchor, constant: 20),
                weaknessStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -150)
            ])
        }
    }
}


