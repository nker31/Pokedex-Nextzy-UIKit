//
//  SearchStoryboardController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 9/2/2567 BE.
//

import UIKit

class SearchStoryboardController: UIViewController {
    // MARK: - Varibles
    private let searchViewModel: SearchViewModel = SearchViewModel()
    
    // MARK: - UI Components
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var notFoundImageView: UIImageView!
    @IBOutlet weak var notFoundLabel: UILabel!
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = String(localized: "pokemon_name_placeholder")
        searchBar.delegate = self
        return searchBar
    }()
    
    lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: String(localized: "cancel_button_text"),
            style: .plain,
            target: self,
            action: #selector(cancelButtonTapped)
            )
        return button
    }()
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavbar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - UI Setup
    private func setupNavbar() {
        title = "Search"
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = cancelButton
        navigationController?.navigationBar.tintColor = .pinkPokemon
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Selectors
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

}

extension SearchStoryboardController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Search bar tapped")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchViewModel.onSearchTextChange(searchText: searchText)
    }

}

extension SearchStoryboardController: UICollectionViewDataSource, UICollectionViewDelegate {
    // number of cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.filteredPokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonStoryboardCell.identifier, for: indexPath) as? PokemonStoryboardCell else{
            fatalError("failed to dequeue view cell")
        }
        let pokemon = searchViewModel.filteredPokemon[indexPath.row]
        cell.configPokemonCell(pokemon: pokemon)
        
        return cell
    }
    
}

extension SearchStoryboardController: UICollectionViewDelegateFlowLayout {
    // cell size
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
    // collection view padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemonDetailVC = DetailViewController(pokemon: searchViewModel.filteredPokemon[indexPath.item])
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(pokemonDetailVC, animated: true)
        hidesBottomBarWhenPushed = false
    }
}

extension SearchStoryboardController: SearchViewModelDelegate {
    func toggleEmptyState(isHidden: Bool, searchText: String) {
        notFoundImageView.isHidden = isHidden
        notFoundLabel.isHidden = isHidden
        notFoundLabel.text = "\(String(localized: "no_result_label_text")) \(searchText)"
    }

    func toggleCollectionViewReload() {
        collectionView.reloadData()
    }

}
