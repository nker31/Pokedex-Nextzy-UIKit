//
//  TabBarController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 19/1/2567 BE.
//

import UIKit

class TabBarController: UITabBarController {
    
    private let authViewModel: AuthViewModel
    private let pokedexViewModel: PokedexViewModel
    private let myPokemonViewModel: MyPokemonViewModel
    
    init(authViewModel: AuthViewModel, pokedexViewModel: PokedexViewModel, myPokemonViewModel: MyPokemonViewModel) {
        self.authViewModel = authViewModel
        self.pokedexViewModel = pokedexViewModel
        self.myPokemonViewModel = myPokemonViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task{
            do{
                await authViewModel.fetchUserData()
                print("Debugger: currunt user \(String(describing: authViewModel.currentUser))")
                if let currentUser = authViewModel.currentUser {
                    await myPokemonViewModel.fetchMyPokemon(userID: currentUser.id)
                    print("Debugger: My Pokemon array \(myPokemonViewModel.myPokemonIDs)")
                    print("Debugger: fetched my pokemon in tabmenu complete")
                }
                self.setupTab()
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTab()

        // Set tab bar
        self.tabBar.barTintColor = UIColor.systemBackground
        self.tabBar.tintColor = UIColor.pinkPokemon

        // Set navigation bar appearance
        UINavigationBar.appearance().barTintColor = UIColor.systemBackground
        UINavigationBar.appearance().tintColor = UIColor.pinkPokemon

    }

    
    // MARK: - set up
    
    private func setupTab(){
        let pokedex = self.createNav(with: "Pokedex", and: UIImage(systemName: "pawprint.fill"), vc: PokedexViewController(authViewModel: authViewModel,pokedexViewModel: pokedexViewModel, myPokedexViewModel: myPokemonViewModel))
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

}
