//
//  LoginTextField.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 29/1/2567 BE.
//

import UIKit

class LoginTextField: UITextField {
    
    enum TextFieldType{
        case email
        case password
    }

    let type: TextFieldType
    
    init(textfieldType: TextFieldType) {
        self.type = textfieldType
        super.init(frame: .zero)
        self.autocapitalizationType = .none
        self.borderStyle = .none
        self.placeholder = "Enter your email"
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.size.height))
        self.leftViewMode = .always
        self.textColor = .white
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        
        switch type{
            
        case .email:
            self.placeholder = String(localized: "email_placeholder")
        case .password:
            self.placeholder = String(localized: "password_placeholder")
            self.isSecureTextEntry = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
