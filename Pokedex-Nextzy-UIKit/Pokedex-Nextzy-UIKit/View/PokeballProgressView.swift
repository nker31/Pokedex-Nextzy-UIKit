//
//  PokeballProgressView.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 24/1/2567 BE.
//

import UIKit

class PokeballProgressView: UIView {
    
    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        animatePokeball()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - UI Components
    lazy var imageView : UIImageView = {
        let image = UIImage(named: "pokeball")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    lazy var progresslabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "loading_label_text")
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    // MARK: - UI Setup
    func setupUI(){
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        self.addSubview(progresslabel)
        progresslabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progresslabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progresslabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: progresslabel.topAnchor, constant: -10),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            
        ])
        
    }
    
    func animatePokeball(){
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {
            self.imageView.transform = self.imageView.transform.rotated(by: .pi)
        }
    }
    
    
    
}
