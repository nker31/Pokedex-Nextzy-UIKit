//
//  TabBarViewModel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 2/2/2567 BE.
//

import Foundation

protocol TabBarViewModelDelegate: AnyObject {
    func toggleAlert(messege: String)
    func toggleProgessView(isHidden: Bool)
    func toggleViewReload()
}

class TabBarViewModel {
    private let authManager = AuthenticationManager.shared
    private let myPokemonManager = MyPokemonManager.shared
    weak var delegate: TabBarViewModelDelegate?

    func loadView() {
        delegate?.toggleProgessView(isHidden: false)
        Task {
            await authManager.fetchUserData()
            await myPokemonManager.fetchMyPokemon(userID: authManager.currentUser?.id ?? "")
            sleep(UInt32(2.0))
            DispatchQueue.main.async {
                self.delegate?.toggleViewReload()
                self.delegate?.toggleProgessView(isHidden: true)
            }
        }
    }

}
