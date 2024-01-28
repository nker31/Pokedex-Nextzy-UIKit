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
    private let myPokedexViewModel: MyPokemonViewModel
    private var isDisplayThreeColumns = false
    private var pokemonArray:[Pokemon] = []
    
    init(authViewModel: AuthViewModel, pokedexViewModel: PokedexViewModel, myPokedexViewModel: MyPokemonViewModel) {
        self.authViewModel = authViewModel
        self.pokedexViewModel = pokedexViewModel
        self.myPokedexViewModel =  myPokedexViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI Components
    let refreshControl = UIRefreshControl()
    
    lazy var progressView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.isHidden = true
        return view
    }()
    lazy var progresslabel: UILabel = {
        let label = UILabel()
        label.text = "Loading"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.identifier)
        collectionView.register(SmallPokemonCell.self, forCellWithReuseIdentifier: SmallPokemonCell.identifier)
        return collectionView
    }()
    
    

    

    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
        setupNavbar()
        

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        refreshControl.addTarget(self, action: #selector(pullRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
    }
    
    // MARK: - UI Setup
    private func setupNavbar() {
        self.view.backgroundColor = .red
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.tintColor = UIColor.pinkPokemon
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        let searchButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        
        let columnsImageName = isDisplayThreeColumns ? "square.grid.2x2" : "square.grid.3x3"
        let columnsButton = UIBarButtonItem(image: UIImage(systemName: columnsImageName), style: .plain, target: self, action: #selector(toggleColumnDisplayed))
        
        self.navigationItem.leftBarButtonItems = [columnsButton]
        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    private func setupUI(){
        self.view.backgroundColor = UIColor.pinkPokemon
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        
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
    private func loadData() {
        // should start progress view here
        progressView.isHidden = false
        Task {
            do {
                pokemonArray = await pokedexViewModel.fecthPokemonAPI()
                sleep(UInt32(1.0))
                collectionView.reloadData()
                progressView.isHidden = true
            }
        }
    }
    
    // MARK: - Selectors
    
    @objc private func searchButtonTapped() {
            let searchViewController = SearchViewController( pokedexViewModel: pokedexViewModel)
            let navigationController = UINavigationController(rootViewController: searchViewController)
        navigationController.modalPresentationStyle = .overFullScreen
            present(navigationController, animated: true, completion: nil)
        }
    
    
    @objc private func toggleColumnDisplayed(){
        isDisplayThreeColumns.toggle()
        setupNavbar()
        setupUI()
        collectionView.reloadData() 
    }
    
    @objc func pullRefresh(_ sender: Any) {
        loadData()
        refreshControl.endRefreshing()
    }


}

extension PokedexViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    // number of cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemonArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isDisplayThreeColumns {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallPokemonCell.identifier, for: indexPath) as? SmallPokemonCell else{
                fatalError("failed to dequeue view cell")
            }
            let pokemon = self.pokemonArray[indexPath.row]
            cell.configPokemonCell(pokemon: pokemon)
            
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.identifier, for: indexPath) as? PokemonCell else{
                fatalError("failed to dequeue view cell")
            }
            let pokemon = self.pokemonArray[indexPath.row]
            cell.configPokemonCell(pokemon: pokemon)
            
            return cell
            
        }
        
    }
    
    
}

extension PokedexViewController: UICollectionViewDelegateFlowLayout{
     
    
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
        print("Selected pokemon: \(self.pokemonArray[indexPath.item].name)")

        let pokemonDetailVC = DetailViewController(pokemon: self.pokemonArray[indexPath.item], pokedexViewModel: pokedexViewModel, myPokemonViewModel: myPokedexViewModel
        )
        

        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(pokemonDetailVC, animated: true)
        hidesBottomBarWhenPushed = false
    }

}


