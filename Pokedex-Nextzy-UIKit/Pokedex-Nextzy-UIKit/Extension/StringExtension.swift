//
//  StringExtension.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 12/2/2567 BE.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }

    func isValidPassword() -> Bool {
        return count >= 8
    }
}
