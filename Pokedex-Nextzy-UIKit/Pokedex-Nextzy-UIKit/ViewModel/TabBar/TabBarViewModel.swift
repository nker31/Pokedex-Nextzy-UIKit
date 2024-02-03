//
//  TabBarViewModel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 2/2/2567 BE.
//

import Foundation

protocol TabBarViewModelDelegate {
    func toggleAlert(messege: String)
    func toggleProgessView(isHidden: Bool)
    func toggleViewReload()
}

class TabBarViewModel {
    
    private let authManager = AuthenticationManager.shared
    var delegate: TabBarViewModelDelegate?

    func loadView() {
        delegate?.toggleProgessView(isHidden: false)
        Task {
            await authManager.fetchUserData()
            sleep(UInt32(2.0))
            DispatchQueue.main.async {
                self.delegate?.toggleViewReload()
                self.delegate?.toggleProgessView(isHidden: true)
            }
        }
    }

}
