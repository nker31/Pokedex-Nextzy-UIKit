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
    private var isLiked = false
    private let pokemon: Pokemon
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .red
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
    
    lazy var tabMenu: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["About", "Stats", "Evolutions"])
        segmentedControl.selectedSegmentIndex = 0
//        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var tabMenuView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        view.backgroundColor = .white
        return view
    }()
    

    
    
    
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavbar()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AboutCell.self, forCellReuseIdentifier: AboutCell.identifier)
  
    }
    
    
    // MARK: - UI Setup
    private func setupNavbar(){
        self.title = pokemon.name
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let favButton = UIBarButtonItem(
            image: UIImage(systemName: isLiked ? "heart.fill" : "heart"),
            style: .plain,
            target: self,
            action: #selector(didTapFavButton)
            )
        self.navigationItem.rightBarButtonItem = favButton
        
    }

    
    
    private func setupUI(){

        // table view
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.setColorBackgroundFromType(type: pokemon.types[0])
        self.tableView.tableHeaderView = headerView
        
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
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            
            // header view
            self.pokemonImageView.centerXAnchor.constraint(equalTo: self.headerView.centerXAnchor),
            self.pokemonImageView.bottomAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: -20),
            self.pokemonImageView.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2),
            self.pokemonImageView.heightAnchor.constraint(equalToConstant: self.view.frame.width / 2),
            
            // tab menu
            self.tabMenu.topAnchor.constraint(equalTo: self.tabMenuView.topAnchor),
            self.tabMenu.leadingAnchor.constraint(equalTo: self.tabMenuView.leadingAnchor),
            self.tabMenu.trailingAnchor.constraint(equalTo: self.tabMenuView.trailingAnchor),
            self.tabMenu.bottomAnchor.constraint(equalTo: self.tabMenuView.bottomAnchor),

            
            
        ])

    }
    
   
    
    
    
    // MARK: - Selectors
    @objc func didTapFavButton(_ sender: UIBarButtonItem){
        isLiked.toggle()
        self.setupNavbar()
        print("Debugger: like it, isLike \(self.isLiked)")
    }


}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AboutCell.identifier, for: indexPath) as! AboutCell

            // Parse data to the cell
        cell.configCell(pokemon: self.pokemon)

            return cell
        }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tabMenuView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            // Return the desired height for your cells
//            return 1200
//        }
}
