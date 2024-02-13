//
//  AboutCell.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 25/1/2567 BE.
//

import UIKit

class AboutCell: UITableViewCell{
    
    // MARK: - Variables
    static let identifier = "aboutCell"
    var pokemon: Pokemon?
    var componentArray: [UIView] = []
    
    // MARK: - UI Components
    func configCell(pokemon: Pokemon){
        self.pokemon = pokemon
        self.setupUI()
    }
    
    func setupUI(){
        self.componentArray.removeAll()
        
        if let pokemon = self.pokemon {
            // Pokemon Description
            let pokemonDescription = DetailDescriptionLabel(title: pokemon.xDescription)
            self.componentArray.append(pokemonDescription)
            
            // Pokemon Type
            var pokemonTypeArray: [UIView] = []
            for type in pokemon.types {
                pokemonTypeArray.append(PokemonTypeComponent(type: type))
            }
            
            let typeStack = UIStackView(arrangedSubviews: pokemonTypeArray)
            typeStack.axis = .horizontal
            typeStack.spacing = 10
            self.componentArray.append(typeStack)
            
            // Pokemon Height and Weight
            let heightTitle = DetailSubtitleLabel(title: "Height")
            let weightTitle = DetailSubtitleLabel(title: "Weight")
            let pokemonHeight = DetailTextLabel(text: pokemon.height)
            let pokemonWeight = DetailTextLabel(text: pokemon.weight)
            
            let heightStack = UIStackView(arrangedSubviews: [
                heightTitle,
                pokemonHeight
            ])
            heightStack.axis = .vertical
            heightStack.spacing = 10
            
            let weightStack = UIStackView(arrangedSubviews: [
                weightTitle,
                pokemonWeight
            ])
            weightStack.axis = .vertical
            weightStack.spacing = 10
            
            let weightHeightStack = UIStackView(arrangedSubviews: [
                heightStack,
                UIView.spacer(size: 50,for: .horizontal),
                weightStack
            ])
            weightHeightStack.axis = .horizontal
            self.componentArray.append(weightHeightStack)
            
            // Pokemon Breeding
            let breedingTitle = DetailTitleLabel(title: "Breeding")
            self.componentArray.append(breedingTitle)
            
            // -- gender
            let genderSubtitle = DetailSubtitleLabel(title: "Gender")
            let pokemonGender = DetailTextLabel(text: "♂ \(pokemon.malePercentage ?? "N/A") ♀ \(pokemon.femalePercentage ?? "N/A")")
            let genderStack = UIStackView(arrangedSubviews: [
                genderSubtitle,
                pokemonGender
            ])
            genderStack.axis = .horizontal
            
            // -- egg group
            let eggGroupSubtitle = DetailSubtitleLabel(title: "Egg Group")
            let pokemonEggGroup = DetailTextLabel(text: pokemon.eggGroups)
            let eggGroupStack = UIStackView(arrangedSubviews: [
                eggGroupSubtitle,
                pokemonEggGroup
            ])
            eggGroupStack.axis = .horizontal
            
            // -- egg cycle
            let eggCycleSubtitle = DetailSubtitleLabel(title: "Egg Cycle")
            let pokemonEggCycle = DetailTextLabel(text: pokemon.cycles)
            
            let eggCycleStack = UIStackView(arrangedSubviews: [
                eggCycleSubtitle,
                pokemonEggCycle
                
            ])
            eggCycleStack.axis = .horizontal
            
            let breedingStack = UIStackView(arrangedSubviews: [
                genderStack,
                eggGroupStack,
                eggCycleStack
                
            ])
            breedingStack.axis = .vertical
            breedingStack.spacing = 10
            self.componentArray.append(breedingStack)
            
            // Pokemon Location
            let locationTitle = DetailTitleLabel(title: "Location")
            self.componentArray.append(locationTitle)
            
            let mapView = MapComponent()
            self.componentArray.append(mapView)
            
            
            // Pokemon Training
            let trainingTitle = DetailTitleLabel(title: "Training")
            self.componentArray.append(trainingTitle)
            
            let baseExpSubtitle = DetailSubtitleLabel(title: "Base EXP")
            let pokemonBaseEXP = DetailTextLabel(text: pokemon.baseExp)
            
            let baseEXPStack = UIStackView(arrangedSubviews: [
                baseExpSubtitle, pokemonBaseEXP
            ])
            baseEXPStack.axis = .horizontal
            self.componentArray.append(baseEXPStack)
            
            
            
            
            
            // biggest stack
            
            let detailStack = UIStackView(arrangedSubviews: self.componentArray)
            detailStack.axis = .vertical
            detailStack.spacing = 30
            detailStack.alignment = .center
            
            self.addSubview(detailStack)
            detailStack.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                detailStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
                detailStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                detailStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                detailStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -75)
            ])
            
            mapView.translatesAutoresizingMaskIntoConstraints = false
            baseEXPStack.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                
                weightHeightStack.leadingAnchor.constraint(equalTo: detailStack.leadingAnchor),
                weightHeightStack.trailingAnchor.constraint(equalTo: detailStack.trailingAnchor),
                
                breedingStack.leadingAnchor.constraint(equalTo: detailStack.leadingAnchor),
                breedingStack.trailingAnchor.constraint(equalTo: detailStack.trailingAnchor),
                
                mapView.leadingAnchor.constraint(equalTo: detailStack.leadingAnchor),
                mapView.trailingAnchor.constraint(equalTo: detailStack.trailingAnchor),
                mapView.heightAnchor.constraint(equalToConstant: 150),
                
                baseEXPStack.leadingAnchor.constraint(equalTo: detailStack.leadingAnchor),
                baseEXPStack.trailingAnchor.constraint(equalTo: detailStack.trailingAnchor)
            ])
        }

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.pokemon = nil
        self.componentArray.removeAll()
    }
    
}
