//
//  DetailViewController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 25/1/2567 BE.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    // MARK: - Varibles
    enum selectedMenu {
        case about
        case stat
        case evolution
    }
    var isPresentMenu = selectedMenu.about
    
    private var isLiked = false
    private let pokemon: Pokemon
    var pokedexViewModel: PokedexViewModel
    var myPokemonViewModel: MyPokemonViewModel
    var filteredPokemon: [Pokemon]
    
    init(pokemon: Pokemon, pokedexViewModel: PokedexViewModel, myPokemonViewModel: MyPokemonViewModel) {
        self.pokemon = pokemon
        self.pokedexViewModel = pokedexViewModel
        self.myPokemonViewModel = myPokemonViewModel
        self.filteredPokemon = pokedexViewModel.pokemons?.filter { pokemon.evolutions.contains($0.id) } ?? []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .red
        tableView.register(AboutCell.self, forCellReuseIdentifier: AboutCell.identifier)
        tableView.register(StatCell.self, forCellReuseIdentifier: StatCell.identifier)
        tableView.register(EvolutionCell.self, forCellReuseIdentifier: EvolutionCell.identifier)
        return tableView
    }()
    
    lazy var headerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 250))
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var pokeballBackground: UIImageView = {
        let image = UIImage(named: "pokeball-logo")
        let imageView = UIImageView(image: image)
        imageView.layer.opacity = 0.3
        return imageView
    }()
    
    lazy var tabMenu: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [String(localized: "about_segment_title"), String(localized: "stat_segment_title"), String(localized: "evolution_segment_title")])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segmentedControl.backgroundColor = .systemGray5
        return segmentedControl
    }()
    
    lazy var tabMenuView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        view.backgroundColor = .systemGray4
        return view
    }()
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if myPokemonViewModel.myPokemonIDs.contains(self.pokemon.id){
            self.isLiked = true
        }
        self.setupNavbar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.animatePokeball()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    // MARK: - UI Setup
    private func setupNavbar() {
        self.title = pokemon.name
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let favButton = UIBarButtonItem(
            image: UIImage(systemName: isLiked ? "heart.fill" : "heart"),
            style: .plain,
            target: self,
            action: #selector(didTapFavButton)
            )
        self.navigationItem.rightBarButtonItem = favButton
    }

    private func setupUI() {
        // table view
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.setColorBackgroundFromType(type: pokemon.types[0])
        self.tableView.tableHeaderView = headerView
        
        // pokeball background
        self.headerView.addSubview(pokeballBackground)
        self.pokeballBackground.translatesAutoresizingMaskIntoConstraints = false
        
        // image view
        self.headerView.addSubview(pokemonImageView)
        self.pokemonImageView.kf.setImage(with: pokemon.imageUrl)
        self.pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // tab menu
        self.tabMenuView.addSubview(tabMenu)
        self.tabMenu.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // table view
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 50),
            
            // header view
            self.pokemonImageView.centerXAnchor.constraint(equalTo: self.headerView.centerXAnchor),
            self.pokemonImageView.bottomAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: -20),
            self.pokemonImageView.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2),
            self.pokemonImageView.heightAnchor.constraint(equalToConstant: self.view.frame.width / 2),
            
            // pokeball background
            self.pokeballBackground.centerXAnchor.constraint(equalTo: self.headerView.centerXAnchor),
            self.pokeballBackground.centerYAnchor.constraint(equalTo: self.headerView.centerYAnchor),
            self.pokeballBackground.widthAnchor.constraint(equalToConstant: self.view.frame.width / 1.5),
            self.pokeballBackground.heightAnchor.constraint(equalToConstant: self.view.frame.width / 1.5),
            
            // tab menu
            self.tabMenu.topAnchor.constraint(equalTo: self.tabMenuView.topAnchor),
            self.tabMenu.leadingAnchor.constraint(equalTo: self.tabMenuView.leadingAnchor),
            self.tabMenu.trailingAnchor.constraint(equalTo: self.tabMenuView.trailingAnchor),
            self.tabMenu.bottomAnchor.constraint(equalTo: self.tabMenuView.bottomAnchor),
        ])
    }
   
    // MARK: - Selectors
    @objc func didTapFavButton(_ sender: UIBarButtonItem) {
        Task{
            await self.myPokemonViewModel.addPokemonToFavList(pokemonID: pokemon.id)
        }
        isLiked.toggle()
        self.setupNavbar()
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        print("Selected menu: \(sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "")")
        switch sender.selectedSegmentIndex {
        case 0:
            isPresentMenu = selectedMenu.about
        case 1:
            isPresentMenu = selectedMenu.stat
        case 2:
            isPresentMenu = selectedMenu.evolution
        default:
            print("Debugger: error")
        }
        self.tableView.reloadData()
    }
    
    func animatePokeball() {
        UIView.animate(withDuration: 2, delay: 0, options: [.repeat, .autoreverse]) {
            self.pokeballBackground.transform = self.pokeballBackground.transform.rotated(by: .pi)
        }
    }

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch isPresentMenu{
            
        case .about:
            let cell = tableView.dequeueReusableCell(withIdentifier: AboutCell.identifier, for: indexPath) as! AboutCell
            cell.configCell(pokemon: self.pokemon)
            return cell
            
        case .stat:
            let cell = tableView.dequeueReusableCell(withIdentifier: StatCell.identifier, for: indexPath) as! StatCell
            cell.configCell(pokemon: self.pokemon)
            return cell
 
            
        case .evolution:
            let cell = tableView.dequeueReusableCell(withIdentifier: EvolutionCell.identifier, for: indexPath) as! EvolutionCell
            cell.configCell(pokemon: self.pokemon, filteredPokemon: filteredPokemon)
            return cell
        }
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tabMenuView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        print("offsetY:", offsetY)

        if offsetY >= -95 {
            navigationController?.navigationBar.backgroundColor = .clear
            navigationController?.navigationBar.tintColor = .pinkPokemon
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        } else {
            navigationController?.navigationBar.backgroundColor = .clear
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }
    
}

