//
//  EvolutionCompenents.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 26/1/2567 BE.
//

import UIKit

class EvolutionComponent: UIView{
    var pokemonOne: Pokemon
    var pokemonTwo: Pokemon
    var levelText: String
    
    init(pokemonOne: Pokemon, pokemonTwo: Pokemon, level: String) {
        self.pokemonOne = pokemonOne
        self.pokemonTwo = pokemonTwo
        self.levelText = level
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    var imageViewOne: UIImageView =  {
        let imageView = UIImageView()
        return imageView
    }()
    var imageViewTwo = UIImageView()
    
    var pokemonLabelOne: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .gray
        return label
    }()
    
    var pokemonLabelTwo: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .gray
        return label
    }()
    
    var levelLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .gray
        return label
    }()
    
    
    func setupUI(){
        imageViewOne.kf.setImage(with: self.pokemonOne.imageUrl)
        imageViewTwo.kf.setImage(with: self.pokemonTwo.imageUrl)
        levelLabel.text = self.levelText
        
        
        pokemonLabelOne.text = self.pokemonOne.name
        
        let vstackOne = UIStackView(arrangedSubviews: [
            imageViewOne,
            pokemonLabelOne
            
        ])
        vstackOne.axis = .vertical
        vstackOne.spacing = 10
        vstackOne.alignment = .center
        
        pokemonLabelTwo.text = self.pokemonTwo.name
        
        let vstackTwo = UIStackView(arrangedSubviews: [
            imageViewTwo,
            pokemonLabelTwo
            
        ])
        vstackTwo.axis = .vertical
        vstackTwo.spacing = 10
        vstackTwo.alignment = .center
        
        
        let stack = UIStackView(arrangedSubviews: [
                    vstackOne,
                    levelLabel,
                    vstackTwo
                ])
                stack.axis = .horizontal
                stack.spacing = 10
                stack.distribution = .equalSpacing
                stack.alignment = .center
                self.addSubview(stack)
                stack.translatesAutoresizingMaskIntoConstraints = false

                NSLayoutConstraint.activate([
                    stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                    stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                    stack.topAnchor.constraint(equalTo: self.topAnchor,constant: 20),
                    stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
                ])
        
        imageViewOne.translatesAutoresizingMaskIntoConstraints = false
        imageViewTwo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageViewOne.widthAnchor.constraint(equalToConstant: 80),
            imageViewOne.heightAnchor.constraint(equalToConstant: 65),
            imageViewTwo.widthAnchor.constraint(equalToConstant: 80),
            imageViewTwo.heightAnchor.constraint(equalToConstant: 65),
            
        ])
        
    }
    
    
    
    
    
}
