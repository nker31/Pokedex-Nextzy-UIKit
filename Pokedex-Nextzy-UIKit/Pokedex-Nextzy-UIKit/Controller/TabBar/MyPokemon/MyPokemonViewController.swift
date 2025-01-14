//
//  MyPokemonViewController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 27/1/2567 BE.
//

import UIKit

class MyPokemonViewController: UIViewController {
    
    // MARK: - Varibles
    private let myPokemonViewModel: MyPokemonViewModel
    
    // MARK: - Initializer
    init() {
        self.myPokemonViewModel = MyPokemonViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PokemonCardCell.self, forCellWithReuseIdentifier: PokemonCardCell.identifier)
        collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.identifier)
        collectionView.register(SmallPokemonCell.self, forCellWithReuseIdentifier: SmallPokemonCell.identifier)
        return collectionView
    }()
    
    lazy var emptyView: UIView = {
        let view = MyPokemonEmptyView()
        view.isHidden = true
        return view
    }()
    
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavbar()
        myPokemonViewModel.loadMyPokemonData()
        self.emptyView.isHidden = !self.myPokemonViewModel.myPokemonsID.isEmpty
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPokemonViewModel.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        self.setupUI()
    }
    
    // MARK: - UI Setup
    
    func setupNavbar() {
        guard let navigationBar = self.navigationController?.navigationBar else {
            return
        }
        navigationBar.backgroundColor = .clear
        navigationBar.prefersLargeTitles = false
        navigationBar.tintColor = .pinkPokemon
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        
        var columnsImageName: String
        switch myPokemonViewModel.collectionViewDisplayType {
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
    }
    
    func setupUI(){
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(emptyView)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            emptyView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            emptyView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            emptyView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    // MARK: - Selectors
    @objc private func toggleColumnDisplayed() {
        myPokemonViewModel.tapChangeDisplayType()
        setupNavbar()
    }

}

extension MyPokemonViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // number of cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPokemonViewModel.displayedPokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch myPokemonViewModel.collectionViewDisplayType {

        case .oneColumn:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCardCell.identifier, for: indexPath) as? PokemonCardCell else{
                fatalError("failed to dequeue view cell")
            }
            let pokemon = myPokemonViewModel.displayedPokemons[indexPath.row]
            cell.configPokemonCell(pokemon: pokemon)
            
            return cell
            
        case .twoColumns:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.identifier, for: indexPath) as? PokemonCell else{
                fatalError("failed to dequeue view cell")
            }
            let pokemon = myPokemonViewModel.displayedPokemons[indexPath.row]
            cell.configPokemonCell(pokemon: pokemon)
            
            return cell
            
        case .threeColumns:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallPokemonCell.identifier, for: indexPath) as? SmallPokemonCell else{
                fatalError("failed to dequeue view cell")
            }
            let pokemon = myPokemonViewModel.displayedPokemons[indexPath.row]
            cell.configPokemonCell(pokemon: pokemon)
            
            return cell
        }
    }
    
}

extension MyPokemonViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch myPokemonViewModel.collectionViewDisplayType {
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
        switch myPokemonViewModel.collectionViewDisplayType {
        case .oneColumn:
            return 20
        case .twoColumns:
            return 20
        case .threeColumns:
            return 5
        }
    }
    
    // horizomtal spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch myPokemonViewModel.collectionViewDisplayType {
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
        let pokemonDetailVC = DetailViewController(pokemon: myPokemonViewModel.displayedPokemons[indexPath.item])
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(pokemonDetailVC, animated: true)
        hidesBottomBarWhenPushed = false
    }

}

extension MyPokemonViewController: MyPokemonViewModelDelegate {
    func toggleViewReload() {
        collectionView.reloadData()
    }
    
}
