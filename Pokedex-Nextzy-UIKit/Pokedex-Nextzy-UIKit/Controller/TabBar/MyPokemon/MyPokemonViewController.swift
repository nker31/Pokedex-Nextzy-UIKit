//
//  MyPokemonViewController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 27/1/2567 BE.
//

import UIKit

class MyPokemonViewController: UIViewController {
    
    // MARK: - Varibles
    private let authViewModel: AuthViewModel
    private let pokedexViewModel: PokedexViewModel
    private let myPokemonViewModel: MyPokemonViewModel
    private var isDisplayThreeColumns = false
    private var filteredPokemon:[Pokemon] = []
    
    // MARK: - Initializer
    init(authViewModel: AuthViewModel, pokedexViewModel: PokedexViewModel, myPokemonViewModel: MyPokemonViewModel) {
        self.authViewModel = authViewModel
        self.pokedexViewModel = pokedexViewModel
        self.myPokemonViewModel = myPokemonViewModel
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
        collectionView.backgroundColor = .white
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
        
        // filter pokemon from view model to display fav pokemon
        self.filteredPokemon = pokedexViewModel.pokemons?.filter { myPokemonViewModel.myPokemonIDs.contains($0.id) } ?? []
        self.emptyView.isHidden = !self.filteredPokemon.isEmpty
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.setupUI()
    }
    
    // MARK: - UI Setup
    
    func setupNavbar() {
        guard let navigationBar = self.navigationController?.navigationBar else {
            return
        }
        self.view.backgroundColor = .red
        navigationBar.backgroundColor = .clear
        navigationBar.prefersLargeTitles = false
        navigationBar.tintColor = UIColor.pinkPokemon
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        let columnsImageName = isDisplayThreeColumns ? "square.grid.2x2" : "square.grid.3x3"
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
    @objc private func toggleColumnDisplayed(){
        self.isDisplayThreeColumns.toggle()
        self.setupNavbar()
        self.setupUI()
        self.collectionView.reloadData()
    }

}

extension MyPokemonViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    // number of cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredPokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isDisplayThreeColumns {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallPokemonCell.identifier, for: indexPath) as? SmallPokemonCell else{
                fatalError("failed to dequeue view cell")
            }
            let pokemon = self.filteredPokemon[indexPath.row]
            cell.configPokemonCell(pokemon: pokemon)
            
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.identifier, for: indexPath) as? PokemonCell else{
                fatalError("failed to dequeue view cell")
            }
            let pokemon = self.filteredPokemon[indexPath.row]
            cell.configPokemonCell(pokemon: pokemon)
            
            return cell
            
        }
    }
    
}


extension MyPokemonViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeTwoColums = ((self.view.frame.width - 40)/2) - 13.34
        let sizeThreeColums = ((self.view.frame.width - 40)/3) - 6.25
        return isDisplayThreeColumns ? CGSize(width: sizeThreeColums, height: sizeThreeColums) : CGSize(width: sizeTwoColums, height: sizeTwoColums)
    }
    
    // vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return isDisplayThreeColumns ? 5 : 20
    }
    
    // horizomtal spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return isDisplayThreeColumns ? 5 : 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = indexPath.item
        print("Selected item: \(selectedItem)")
        print("Selected pokemon: \(self.filteredPokemon[indexPath.item].name)")

        let pokemonDetailVC = DetailViewController(pokemon: self.filteredPokemon[indexPath.item], pokedexViewModel: pokedexViewModel,myPokemonViewModel: myPokemonViewModel)
        
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(pokemonDetailVC, animated: true)
        hidesBottomBarWhenPushed = false
    }

}
