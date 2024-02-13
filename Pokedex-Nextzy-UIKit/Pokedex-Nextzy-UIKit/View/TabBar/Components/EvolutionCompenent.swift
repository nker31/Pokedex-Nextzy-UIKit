//
//  EvolutionCompenents.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 26/1/2567 BE.
//

import UIKit

class EvolutionComponent: UIView{
    // MARK: - Variables
    var pokemonFirstForm: Pokemon
    var pokemonSecondForm: Pokemon
    var levelText: String
    
    // MARK: - Initializer
    init(pokemonOne: Pokemon, pokemonTwo: Pokemon, level: String) {
        self.pokemonFirstForm = pokemonOne
        self.pokemonSecondForm = pokemonTwo
        self.levelText = level
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    var pokemonFirstFormImageView: UIImageView = UIImageView()
    var pokemonSecondFormImageView: UIImageView = UIImageView()
    var pokemonFirstFormLabel: UILabel = {
        let label = UILabel()
        label.font = .notoSansSemiBold(size: 14)
        label.textColor = .gray
        return label
    }()
    var pokemonSecondFormLabel: UILabel = {
        let label = UILabel()
        label.font = .notoSansSemiBold(size: 14)
        label.textColor = .gray
        return label
    }()
    var levelLabel:UILabel = {
        let label = UILabel()
        label.font = .notoSansSemiBold(size: 16)
        label.textColor = .gray
        return label
    }()

    // MARK: - UI Setup
    func setupUI() {
        pokemonFirstFormImageView.kf.setImage(with: self.pokemonFirstForm.imageUrl)
        pokemonSecondFormImageView.kf.setImage(with: self.pokemonSecondForm.imageUrl)
        levelLabel.text = self.levelText
        
        // first pokemon
        pokemonFirstFormLabel.text = self.pokemonFirstForm.name
        let firstFormStack = UIStackView(arrangedSubviews: [
            pokemonFirstFormImageView,
            pokemonFirstFormLabel
            
        ])
        firstFormStack.axis = .vertical
        firstFormStack.spacing = 10
        firstFormStack.alignment = .center
        
        // second pokemon
        pokemonSecondFormLabel.text = self.pokemonSecondForm.name
        let secondFormStack = UIStackView(arrangedSubviews: [
            pokemonSecondFormImageView,
            pokemonSecondFormLabel
            
        ])
        secondFormStack.axis = .vertical
        secondFormStack.spacing = 10
        secondFormStack.alignment = .center
        
        // container
        let stack = UIStackView(arrangedSubviews: [
                    firstFormStack,
                    levelLabel,
                    secondFormStack
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
        
        pokemonFirstFormImageView.translatesAutoresizingMaskIntoConstraints = false
        pokemonSecondFormImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pokemonFirstFormImageView.widthAnchor.constraint(equalToConstant: 80),
            pokemonFirstFormImageView.heightAnchor.constraint(equalToConstant: 65),
            pokemonSecondFormImageView.widthAnchor.constraint(equalToConstant: 80),
            pokemonSecondFormImageView.heightAnchor.constraint(equalToConstant: 65),
            
        ])
    }

}
