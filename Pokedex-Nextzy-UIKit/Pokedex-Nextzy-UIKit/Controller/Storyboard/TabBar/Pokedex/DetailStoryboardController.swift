//
//  DetailStoryboardController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 11/2/2567 BE.
//

import UIKit
import Kingfisher

class DetailStoryboardController: UIViewController {
    // MARK: - Varibles
    private var pokemon: Pokemon?
    private var detailViewModel: DetailViewModel?
    
    // MARK: - UI Components
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tabMenuView: UIView!
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        detailViewModel?.checkFavorite()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = headerView
        tableView.dataSource = self
        
        let aboutCell = UINib(nibName: "AboutCell", bundle: nil)
        tableView.register(aboutCell, forCellReuseIdentifier: AboutCellStoryboard.identifier)
        let statCell = UINib(nibName: "StatCell", bundle: nil)
        tableView.register(statCell, forCellReuseIdentifier: StatCellStoryboard.identifier)
        let evolutionCell = UINib(nibName: "EvolutionCell", bundle: nil)
        tableView.register(evolutionCell, forCellReuseIdentifier: EvolutionCellStoryboard.identifier)
        
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - UI Setup
    private func setupNavbar() {
        if let viewModel = self.detailViewModel {
            title = viewModel.pokemon.name
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            let favButton = UIBarButtonItem(
                image: UIImage(systemName: viewModel.isLiked ? "heart.fill" : "heart"),
                style: .plain,
                target: self,
                action: #selector(didTapFavButton)
                )
            navigationItem.rightBarButtonItem = favButton
        }
    }
    
    private func setupUI() {
        guard let pokemonImageURL = self.pokemon?.imageUrl,
              let pokemonType = self.pokemon?.types.first else { return }
        pokemonImageView.kf.setImage(with: pokemonImageURL)
        setColorBackgroundFromType(type: pokemonType)
        headerView.setColorBackgroundFromType(type: pokemonType)
        headerView.layoutIfNeeded()
    }
    
    func setPokemon(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        self.detailViewModel = DetailViewModel(pokemon: pokemon)
        self.detailViewModel?.delegate = self
    }
    
    // MARK: - Selectors
    @objc func didTapFavButton(_ sender: UIBarButtonItem) {
        guard let viewModel = detailViewModel else { return }
        viewModel.tapFavorite(pokemonID: viewModel.pokemon.id)
    }

    @IBAction func didTapChangeMenu(_ sender: UISegmentedControl) {
        guard let viewModel = detailViewModel else { return }
        viewModel.tapChangeMenu(index: sender.selectedSegmentIndex)
    }
    
}

extension DetailStoryboardController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let detailViewModel = detailViewModel {
            switch detailViewModel.isPresentMenu {
                
            case .about:
                let cell = tableView.dequeueReusableCell(withIdentifier: AboutCellStoryboard.identifier, for: indexPath) as! AboutCellStoryboard
                cell.configCell(pokemon: self.pokemon ?? MOCK_POKEMON[0])
                return cell
                
            case .stat:
                let cell = tableView.dequeueReusableCell(withIdentifier: StatCellStoryboard.identifier, for: indexPath) as! StatCellStoryboard
                cell.configCell(pokemon: self.pokemon ?? MOCK_POKEMON[0])
                return cell
                
            case .evolution:
                let cell = tableView.dequeueReusableCell(withIdentifier: EvolutionCellStoryboard.identifier, for: indexPath) as! EvolutionCellStoryboard
                cell.configCell(pokemon: self.pokemon ?? MOCK_POKEMON[0], filteredPokemon: detailViewModel.filteredPokemon)
                return cell

            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: StatCellStoryboard.identifier, for: indexPath) as! StatCellStoryboard
        cell.configCell(pokemon: self.pokemon ?? MOCK_POKEMON[0])
        return cell
        
    }
    
}

extension DetailStoryboardController: DetailViewModelDelegate {
    func toggleTableViewReload() {
        headerView.layoutIfNeeded()
        tableView.reloadData()
    }
    
    func toggleNavbarReload() {
        self.setupNavbar()
    }
}
