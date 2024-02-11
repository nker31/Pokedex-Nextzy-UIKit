//
//  SettingViewModel.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 8/2/2567 BE.
//

import Foundation

protocol SettingViewModelDelegate: AnyObject {
    func toggleAlert(messege: String)
    func toggleViewReload()
}

class SettingViewModel {
    
    weak var delegate: SettingViewModelDelegate?
    
    func switchLanguage(languageCode: String) {
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        delegate?.toggleViewReload()
        delegate?.toggleAlert(messege: "Please retart app for change language")
    }
    
}
