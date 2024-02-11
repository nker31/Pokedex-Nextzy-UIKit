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
    @IBOutlet weak var tabMenuView: UISegmentedControl!
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        detailViewModel?.checkFavorite()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = headerView
        tableView.delegate = self
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
        if let pokemon = self.pokemon {
            pokemonImageView.kf.setImage(with: pokemon.imageUrl)
            setColorBackgroundFromType(type: pokemon.types[0])
            headerView.setColorBackgroundFromType(type: pokemon.types[0])
        }
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
}

extension DetailStoryboardController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tabMenuView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}

extension DetailStoryboardController: DetailViewModelDelegate {
    func toggleTableViewReload() {
        tableView.reloadData()
    }
    
    func toggleNavbarReload() {
        self.setupNavbar()
    }
}
