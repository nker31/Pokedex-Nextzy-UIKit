//
//  TabBarController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 19/1/2567 BE.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Varibles
    private let tabBarViewModel: TabBarViewModel
    
    // MARK: - Initializer
    init() {
        self.tabBarViewModel = TabBarViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    lazy var progressView = PokeballProgressView()
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarViewModel.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarViewModel.delegate = self
        self.setupTab()
        self.setupUI()
        
        UINavigationBar.appearance().barTintColor = .systemBackground
        UINavigationBar.appearance().tintColor = .pinkPokemon
    }
    
    // MARK: - UI Setup
    private func setupTab() {
        self.tabBar.barTintColor = UIColor.systemBackground
        self.tabBar.tintColor = UIColor.pinkPokemon
        
        let pokedex = self.createNav(with: String(localized: "pokedex_tabbar_title"), and: UIImage(systemName: "pawprint.fill"), vc: PokedexViewController())
        
        let myPokemon = self.createNav(with: String(localized: "my_pokemon_tabbar_title"), and: UIImage(systemName: "heart.text.square"), vc: MyPokemonViewController())
        
        let profile = self.createNav(with: String(localized: "profile_tabbar_title"), and: UIImage(systemName: "person.fill"), vc: ProfileViewController())
        
        self.setViewControllers([pokedex, myPokemon, profile], animated: true)
    }
    
    private func createNav(with title:String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title
        return nav
    }
    
    private func setupUI() {
        self.view.addSubview(progressView)
        progressView.isHidden = true
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: self.view.topAnchor),
            progressView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            progressView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }

}

extension TabBarController: TabBarViewModelDelegate {
    func toggleAlert(messege: String) {
        showAlert(message: messege)
    }
    
    func toggleProgessView(isHidden: Bool) {
        progressView.isHidden = isHidden
    }
    
    func toggleViewReload() {
        self.setupTab()
    }
    
}
