//
//  PokedexStoryboardController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 8/2/2567 BE.
//

import UIKit

class PokedexStoryboardController: UIViewController {
    // MARK: - Varibles
    let pokedexViewModel: PokedexViewModel = PokedexViewModel()
    
    // MARK: - UI Components
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        pokedexViewModel.loadPokemonData()
        pokedexViewModel.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self

        let cardCell = UINib(nibName: "PokemonStoryboardCardCell", bundle: nil)
        collectionView.register(cardCell, forCellWithReuseIdentifier: PokemonStoryboardCardCell.identifier)
        let smallCell = UINib(nibName: "PokemonStoryboardSmallCell", bundle: nil)
        collectionView.register(smallCell, forCellWithReuseIdentifier: PokemonStoryboardSmallCell.identifier)
    }
    
    private func setupNavbar() {
        title = String(localized: "pokedex_tabbar_title")
        if let nav = self.navigationController?.navigationBar {
            nav.backgroundColor = .clear
            nav.prefersLargeTitles = false
            nav.tintColor = .pinkPokemon
            nav.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        }
        
        let searchButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                            target: self,
                                                            action: #selector(searchButtonTapped))
        
        var columnsImageName: String
        switch pokedexViewModel.collectionViewDisplayType {
        case .oneColumn:
            columnsImageName = "square.grid.2x2"
        case .twoColumns:
            columnsImageName = "square.grid.3x3"
        case .threeColumns:
            columnsImageName = "rectangle.grid.1x2"
        }
        
        let columnsButton = UIBarButtonItem(image: UIImage(systemName: columnsImageName),
                                            style: .plain,
                                            target: self,
                                            action: #selector(toggleColumnDisplayed))
        
        self.navigationItem.leftBarButtonItems = [columnsButton]
        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc private func searchButtonTapped() {
        performSegue(withIdentifier: "PresentSearch", sender: Any.self)
    }
    
    @objc private func toggleColumnDisplayed() {
        pokedexViewModel.tapChangeDisplayType()
        setupNavbar()
        collectionView.reloadData()
        
    }
    
}

extension PokedexStoryboardController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokedexViewModel.pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch pokedexViewModel.collectionViewDisplayType {

        case .oneColumn:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonStoryboardCardCell.identifier, for: indexPath) as? PokemonStoryboardCardCell else{
                fatalError("failed to dequeue view cell")
            }
            let pokemon = self.pokedexViewModel.pokemons[indexPath.row]
            cell.configPokemonCell(pokemon: pokemon)
            
            return cell
            
        case .twoColumns:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonStoryboardCell.identifier, for: indexPath) as? PokemonStoryboardCell else{
                fatalError("failed to dequeue view cell")
            }
            let pokemon = self.pokedexViewModel.pokemons[indexPath.row]
            cell.configPokemonCell(pokemon: pokemon)
            
            return cell
            
        case .threeColumns:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonStoryboardSmallCell.identifier, for: indexPath) as? PokemonStoryboardSmallCell else{
                fatalError("failed to dequeue view cell")
            }
            let pokemon = self.pokedexViewModel.pokemons[indexPath.row]
            cell.configPokemonCell(pokemon: pokemon)
            
            return cell
        }
    }
}

extension PokedexStoryboardController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch pokedexViewModel.collectionViewDisplayType {
        case .oneColumn:
            let width = self.view.frame.width - 40
            let height = ((self.view.frame.width - 40)/2) - 13.34
            return  CGSize(width: width, height: height)
        case .twoColumns:
            let size = ((self.view.frame.width - 40)/2) - 13.34
            return  CGSize(width: size, height: size)
        case .threeColumns:
            let size = ((self.view.frame.width - 40)/3) - 6.25
            return  CGSize(width: size, height: size)
        }
    }
    
    // vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch pokedexViewModel.collectionViewDisplayType {
        case .oneColumn:
            return 20
        case .twoColumns:
            return 20
        case .threeColumns:
            return 5
        }
    }
    
    // horizontal spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch pokedexViewModel.collectionViewDisplayType {
        case .oneColumn:
            return 0
        case .twoColumns:
            return 20
        case .threeColumns:
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        hidesBottomBarWhenPushed = true
        performSegue(withIdentifier: "PresentPokemon", sender: pokedexViewModel.pokemons[indexPath.item])
        hidesBottomBarWhenPushed = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PresentPokemon" {
            if let pokemon = sender as? Pokemon,
               let destinationVC = segue.destination as? DetailStoryboardController {
                destinationVC.setPokemon(pokemon)
            }
        }
    }
}

extension PokedexStoryboardController: PokedexViewModelDelegate {
    func toggleViewReload() {
        collectionView.reloadData()
    }
    
    func toggleAlert(messege: String) {
        showAlert(message: messege)
    }
    
}
