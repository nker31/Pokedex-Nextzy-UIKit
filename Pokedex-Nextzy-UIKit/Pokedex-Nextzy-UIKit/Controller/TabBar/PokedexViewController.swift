//
//  PokedexViewController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 19/1/2567 BE.
//

import UIKit

class PokedexViewController: UIViewController{
    
    
    
    // MARK: - Varibles
    private let authViewModel: AuthViewModel
    private let pokedexViewModel: PokedexViewModel
    private var pokemonArray:[Pokemon] = []
    
    init(authViewModel: AuthViewModel, pokedexViewModel: PokedexViewModel) {
        self.authViewModel = authViewModel
        self.pokedexViewModel = pokedexViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var isDisplayThreeColumns = false
    
    
    // MARK: - UI Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.identifier)
        return collectionView
    }()
    

    

    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupUI()
        
        
    }
    
    // MARK: - UI Setup
    private func setupNavbar() {
        self.view.backgroundColor = .red
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.pinkPokemon
        
        let searchButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        
        let columnsImageName = isDisplayThreeColumns ? "square.grid.2x2" : "square.grid.3x3"
        let columnsButton = UIBarButtonItem(image: UIImage(systemName: columnsImageName), style: .plain, target: self, action: #selector(toggleColumnDisplayed))
        
        self.navigationItem.leftBarButtonItems = [columnsButton]
        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    private func setupUI(){
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        
        self.view.backgroundColor = UIColor.pinkPokemon
        
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        
        ])

    }
    private func loadData() {
        Task {
            do {
                await pokedexViewModel.fecthPokemonAPI()
                pokemonArray = pokedexViewModel.pokemons ?? [MOCK_POKEMON[0]]
                print("Debugger: Finished to fetching pokemon \(pokemonArray[0])")
                collectionView.reloadData()
            }
        }
    }
    
    // MARK: - Selectors
    
    @objc private func searchButtonTapped() {

    }
    
    
    @objc private func toggleColumnDisplayed(){
        isDisplayThreeColumns.toggle()
        setupNavbar()
        
    }

}

extension PokedexViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    // number of cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemonArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.identifier, for: indexPath) as? PokemonCell else{
            fatalError("failed to dequeue view cell")
        }
        let pokemon = self.pokemonArray[indexPath.row]
        cell.configPokemonCell(pokemon: pokemon)
        
        return cell
    }
    
    
}

extension PokedexViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = ((self.view.frame.width - 40)/2) - 13.34
        return CGSize(width: size, height: size)
    }
    
    // vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    // horizomtal spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
    }
}


