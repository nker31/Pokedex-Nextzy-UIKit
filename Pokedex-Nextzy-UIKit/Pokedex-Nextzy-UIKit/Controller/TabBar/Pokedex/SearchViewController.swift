//
//  SearchViewController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 24/1/2567 BE.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Variables
    private let searchViewModel: SearchViewModel
    
    // MARK: - Initializer
    init(pokedexViewModel: PokedexViewModel) {
        self.searchViewModel = SearchViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Components
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
    
    lazy var notFoundImageView: UIImageView = {
        let image = UIImage(named: "pikachu-back")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var notFoundLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.textColor = .systemGray
        label.isHidden = true
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.identifier)
        return collectionView
    }()
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavbar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupUI()
        self.searchViewModel.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    // MARK: - UI Setup
    private func setupNavbar() {
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = cancelButton
        self.navigationController?.navigationBar.tintColor = UIColor.pinkPokemon
    }

    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(notFoundImageView)
        notFoundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(notFoundLabel)
        notFoundLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            notFoundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notFoundImageView.bottomAnchor.constraint(equalTo: notFoundLabel.topAnchor, constant: 20),
            notFoundImageView.heightAnchor.constraint(equalToConstant: 200),
        
            notFoundLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notFoundLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Selectors
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Search bar tapped")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchViewModel.onSearchTextChange(searchText: searchText)
    }

}
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // number of cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.filteredPokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.identifier, for: indexPath) as? PokemonCell else{
            fatalError("failed to dequeue view cell")
        }
        
        let pokemon = searchViewModel.filteredPokemon[indexPath.row]
        cell.configPokemonCell(pokemon: pokemon)
        
        return cell
            
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
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

extension SearchViewController: SearchViewModelDelegate {
    func toggleEmptyState(isHidden: Bool, searchText: String) {
        notFoundImageView.isHidden = isHidden
        notFoundLabel.isHidden = isHidden
        notFoundLabel.text = "\(String(localized: "no_result_label_text")) \(searchText)"
    }

    func toggleCollectionViewReload() {
        collectionView.reloadData()
    }

}
