//
//  PokedexViewController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 19/1/2567 BE.
//

import UIKit

class PokedexViewController: UIViewController {

    // MARK: - Varibles
    private let pokedexViewModel: PokedexViewModel
    private let myPokemonViewModel: MyPokemonViewModel
    private var displayType: DisplayType = .twoColumns
    private var pokemonArray: [Pokemon] = []
    
    init(myPokemonViewModel: MyPokemonViewModel) {
        self.pokedexViewModel = PokedexViewModel()
        self.myPokemonViewModel = myPokemonViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    let refreshControl: UIRefreshControl = {
        let controller = UIRefreshControl()
        controller.addTarget(self, action: #selector(pullRefresh), for: .valueChanged)
        return controller
    }()
    
    lazy var progressView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.3)
        view.isHidden = true
        return view
    }()
    
    lazy var progresslabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "loading_label_text")
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.identifier)
        collectionView.register(SmallPokemonCell.self, forCellWithReuseIdentifier: SmallPokemonCell.identifier)
        collectionView.register(PokemonCardCell.self, forCellWithReuseIdentifier: PokemonCardCell.identifier)
        return collectionView
    }()
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavbar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokedexViewModel.loadPokemonData()
        setupUI()
        self.collectionView.refreshControl = refreshControl
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    // MARK: - UI Setup
    private func setupNavbar() {
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.backgroundColor = .clear
            navigationBar.prefersLargeTitles = false
            navigationBar.tintColor = .pinkPokemon
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        }
        
        let searchButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, 
                                                            target: self,
                                                            action: #selector(searchButtonTapped))
        
        var columnsImageName: String
        switch displayType {
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
    
    private func setupUI() {
        self.view.backgroundColor = .pinkPokemon
        
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.progressView.addSubview(progresslabel)
        progresslabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progresslabel.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            progresslabel.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
            
            progressView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            progressView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            progressView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),

            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    // MARK: - Selectors
    
    @objc private func searchButtonTapped() {
        let searchViewController = SearchViewController( pokedexViewModel: pokedexViewModel)
        let navigationController = UINavigationController(rootViewController: searchViewController)
        navigationController.modalPresentationStyle = .overFullScreen
            present(navigationController, animated: true, completion: nil)
    }
    
    
    @objc private func toggleColumnDisplayed() {
        pokedexViewModel.tapChangeDisplayType()
        setupNavbar()
        collectionView.reloadData()
        
    }
    
    @objc func pullRefresh(_ sender: Any) {
        pokedexViewModel.loadPokemonData()
        refreshControl.endRefreshing()
    }
}

extension PokedexViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // number of cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokedexViewModel.pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch pokedexViewModel.collectionViewDisplayType {

        case .oneColumn:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCardCell.identifier, for: indexPath) as? PokemonCardCell else{
                fatalError("failed to dequeue view cell")
            }
            let pokemon = self.pokedexViewModel.pokemons[indexPath.row]
            cell.configPokemonCell(pokemon: pokemon)
            
            return cell
            
        case .twoColumns:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.identifier, for: indexPath) as? PokemonCell else{
                fatalError("failed to dequeue view cell")
            }
            let pokemon = self.pokedexViewModel.pokemons[indexPath.row]
            cell.configPokemonCell(pokemon: pokemon)
            
            return cell
            
        case .threeColumns:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallPokemonCell.identifier, for: indexPath) as? SmallPokemonCell else{
                fatalError("failed to dequeue view cell")
            }
            let pokemon = self.pokedexViewModel.pokemons[indexPath.row]
            cell.configPokemonCell(pokemon: pokemon)
            
            return cell
        }
    }
    
    
}

extension PokedexViewController: UICollectionViewDelegateFlowLayout {
    
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
    
    // horizomtal spacing
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
        let pokemonDetailVC = DetailViewController(pokemon: self.pokedexViewModel.pokemons[indexPath.item])
        
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(pokemonDetailVC, animated: true)
        hidesBottomBarWhenPushed = false
    }

}

extension PokedexViewController: PokedexViewModelDelegate {
    func toggleViewReload() {
        collectionView.reloadData()
    }
    
}

