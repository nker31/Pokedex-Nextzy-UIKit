//
//  PokeballProgressView.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 24/1/2567 BE.
//

import UIKit

class PokeballProgressView: UIView {

    // MARK: - Varibles
    
    
    // MARK: - UI Components
    lazy var imageView : UIImageView = {
        let image = UIImage(named: "pokeball")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    lazy var labelLoading: UILabel = {
        let label = UILabel()
        label.text = "Loading"
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - UI Setup
    func setupUI(){
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.addSubview(imageView)
        self.addSubview(labelLoading)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            labelLoading.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            labelLoading.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
    }
    
    func startAnimating() {
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .curveLinear], animations: {
            self.imageView.transform = self.imageView.transform.rotated(by: .pi)
        }, completion: nil)
    }

    func stopAnimating() {
        imageView.layer.removeAllAnimations()
    }
    
    // MARK: - Selectors

}
