//
//  TabBarController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 19/1/2567 BE.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Varibles
    private let authViewModel: AuthViewModel
    private let pokedexViewModel: PokedexViewModel
    private let myPokemonViewModel: MyPokemonViewModel
    
    // MARK: - Initializer
    init(authViewModel: AuthViewModel, pokedexViewModel: PokedexViewModel, myPokemonViewModel: MyPokemonViewModel) {
        self.authViewModel = authViewModel
        self.pokedexViewModel = pokedexViewModel
        self.myPokemonViewModel = myPokemonViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
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

    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        progressView.isHidden = false
        Task{
            do{
                await authViewModel.fetchUserData()
                if let currentUser = authViewModel.currentUser {
                    await myPokemonViewModel.fetchMyPokemon(userID: currentUser.id)
                }
                self.setupTab()
                sleep(UInt32(2.0))
                progressView.isHidden = true
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTab()
        self.setupUI()
        

        // Set navigation bar appearance
        UINavigationBar.appearance().barTintColor = UIColor.systemBackground
        UINavigationBar.appearance().tintColor = UIColor.pinkPokemon

    }
    
    // MARK: - UI Setup
    private func setupTab(){
        // Set tab bar
        self.tabBar.barTintColor = UIColor.systemBackground
        self.tabBar.tintColor = UIColor.pinkPokemon
        
        // assign viewController to tab menu
        let pokedex = self.createNav(with: "Pokedex", and: UIImage(systemName: "pawprint.fill"), vc: PokedexViewController(authViewModel: authViewModel,pokedexViewModel: pokedexViewModel, myPokemonViewModel: myPokemonViewModel))
        let myPokemon = self.createNav(with: "My Pokemon", and: UIImage(systemName: "heart.text.square"), vc: MyPokemonViewController(authViewModel: authViewModel, pokedexViewModel: pokedexViewModel, myPokemonViewModel: myPokemonViewModel))
        let profile = self.createNav(with: "Profile", and: UIImage(systemName: "person.fill"), vc: ProfileViewController(authViewModel: authViewModel))
        self.setViewControllers([pokedex, myPokemon, profile], animated: true)
    }

    
    private func createNav(with title:String, and image: UIImage?, vc: UIViewController) -> UINavigationController{
        
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title
        return nav
    }
    
    private func setupUI(){
        
        self.progressView.addSubview(progresslabel)
        progresslabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progresslabel.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            progresslabel.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
            
            progressView.topAnchor.constraint(equalTo: self.view.topAnchor),
            progressView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            progressView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),

            
        ])
        

    }
    
    // MARK: - Selectors
    
    
    
    
        

}
