//
//  TabBarStoryboardController.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 8/2/2567 BE.
//

import UIKit

class TabBarStoryboardController: UITabBarController {
    
    // MARK: - Varibles
    private let tabBarViewModel: TabBarViewModel = TabBarViewModel()
    
    // MARK: - UI Components
    lazy var progressView = PokeballProgressView()
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarViewModel.delegate = self
        tabBarViewModel.loadView()
        UINavigationBar.appearance().barTintColor = .systemBackground
        UINavigationBar.appearance().tintColor = .pinkPokemon
        navigationItem.setHidesBackButton(true, animated: false)
    }

}

extension TabBarStoryboardController: TabBarViewModelDelegate {
    func toggleAlert(messege: String) {
        showAlert(message: messege)
    }
    
    func toggleProgessView(isHidden: Bool) {
        progressView.isHidden = isHidden
    }
    
    func toggleViewReload() {
    }
    
}
