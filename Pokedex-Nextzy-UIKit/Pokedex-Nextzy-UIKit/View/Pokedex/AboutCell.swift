//
//  AboutCell.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 25/1/2567 BE.
//

import UIKit
import MapKit

class AboutCell: UITableViewCell {
    // MARK: - Variables
    static let identifier = "aboutCell"
    var pokemon: Pokemon?
    // MARK: - UI Components
    lazy var pokemonDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var pokemonType: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    lazy var pokemonHeight: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var pokemonWeignt: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var weightHeightHStack: UIStackView = {
        var heightSubtitle = AboutSubtitleLabel(title: "Height")
        var weightSubtitle = AboutSubtitleLabel(title: "Weight")
        let heighStack = UIStackView(arrangedSubviews: [
            heightSubtitle,
            self.pokemonHeight
        ])
        heighStack.axis = .vertical
        heighStack.spacing = 10
        
        let weightStack = UIStackView(arrangedSubviews: [
            weightSubtitle,
            self.pokemonWeignt
        ])
        weightStack.axis = .vertical
        weightStack.spacing = 10
        
        
        let stack = UIStackView(arrangedSubviews: [
            heighStack,
            UIView.spacer(size: 80, for: .horizontal),
            weightStack,
           
        ])
        stack.axis = .horizontal
        stack.spacing = 10
        
        return stack
    }()
    
    // breeding
    lazy var breedTitle = AboutTitleLabel(title: "Breeding")
    
    
    lazy var breedingStack: UIStackView = {
        // subtitle
        var genderSubtitle = AboutSubtitleLabel(title: "Gender")
        var eggGroupSubtitle = AboutSubtitleLabel(title: "Egg Cycle")
        var eggCycleSubtitle = AboutSubtitleLabel(title: "Base EXP")
        
        // sub stack
        let genderHStack = UIStackView(arrangedSubviews: [
            genderSubtitle,
            UIView.spacer(size: 22, for: .horizontal),
            AboutTextLabel(text: "♂ \(pokemon?.malePercentage ?? "N/A") ♀ \(pokemon?.femalePercentage ?? "N/A")")
            
        ])
        genderHStack.axis = .horizontal
        genderHStack.spacing = 10
        
        let eggGroupHStack = UIStackView(arrangedSubviews: [
            eggGroupSubtitle,
            UIView.spacer(size: 7, for: .horizontal),
            AboutTextLabel(text: pokemon?.eggGroups ?? "N/A")
        ])
        eggGroupHStack.axis = .horizontal
        eggGroupHStack.spacing = 10
        
        let eggCycleHStack = UIStackView(arrangedSubviews: [
            eggCycleSubtitle,
            UIView.spacer(size: 27, for: .horizontal),
            AboutTextLabel(text: pokemon?.cycles ?? "N/A")
        ])
        eggGroupHStack.axis = .horizontal
        eggGroupHStack.spacing = 10
        
        // big stack
        let stack = UIStackView(arrangedSubviews: [
            genderHStack,
            eggGroupHStack,
            eggCycleHStack
        ])
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 10
        
        return stack
    }()
    
    // location
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        let initialLocation = CLLocationCoordinate2D(latitude: 13.752709852833902, longitude: 100.56156446958983)
        let zoomDistance: CLLocationDistance = 1400000

        let coordinateRegion = MKCoordinateRegion(
                    center: initialLocation,
                    latitudinalMeters: zoomDistance,
                    longitudinalMeters: zoomDistance
        )
        mapView.setRegion(coordinateRegion, animated: true)
        return mapView
    }()
    
    lazy var locationTitle = AboutTitleLabel(title: "Location")
    
    // training
    lazy var trainingTitle = AboutTitleLabel(title: "Training")
    lazy var trainingStack: UIStackView = {
        // subtitle
        var trainingSubtitle = AboutSubtitleLabel(title: "Base EXP")
        
        // sub stack
        let trainingStack = UIStackView(arrangedSubviews: [
            trainingSubtitle,
            AboutTextLabel(text: pokemon?.baseExp ?? "N/A")
            
        ])
        
        trainingStack.axis = .horizontal
//        trainingStack.spacing = 10
        trainingStack.alignment = .leading
        return trainingStack
    }()
    
    // MARK: - init
    func configCell(pokemon: Pokemon){
        self.pokemon = pokemon
        self.pokemonDescription.text = pokemon.xDescription
        self.pokemonType.text = pokemon.types[0]
        self.pokemonWeignt.text = pokemon.weight
        self.pokemonHeight.text = pokemon.height
        self.setupUI()
    }


    func setupUI() {
        let mapViewWrapper = UIView()
        mapViewWrapper.addSubview(mapView)

        let detailSubViews = [
                pokemonDescription,
                pokemonType,
                // height and weight
                weightHeightHStack,
                // breeding
                breedTitle,
                breedingStack,
                // location
                locationTitle,
                mapViewWrapper,
                // training
                trainingTitle,
                trainingStack
        ]
        let stack = UIStackView(arrangedSubviews: detailSubViews)
        stack.axis = .vertical
        stack.spacing = 30
        stack.alignment = .center
        self.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25)
        ])
        
        
        
        NSLayoutConstraint.activate([
            breedingStack.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            breedingStack.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
        ])

        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           mapView.topAnchor.constraint(equalTo: mapViewWrapper.topAnchor),
           mapView.leadingAnchor.constraint(equalTo: mapViewWrapper.leadingAnchor),
           mapView.trailingAnchor.constraint(equalTo: mapViewWrapper.trailingAnchor),
           mapView.bottomAnchor.constraint(equalTo: mapViewWrapper.bottomAnchor)
        ])

        mapViewWrapper.translatesAutoresizingMaskIntoConstraints = false
        mapViewWrapper.layer.cornerRadius = 20
        NSLayoutConstraint.activate([
            mapViewWrapper.topAnchor.constraint(equalTo: locationTitle.bottomAnchor, constant: 10),
            mapViewWrapper.leadingAnchor.constraint(equalTo: stack.leadingAnchor), // Adjust as needed
            mapViewWrapper.trailingAnchor.constraint(equalTo: stack.trailingAnchor), // Adjust as needed
            mapViewWrapper.heightAnchor.constraint(equalToConstant: 150) // Adjust the height as needed
        ])
        
        NSLayoutConstraint.activate([
            trainingStack.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            trainingStack.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
        ])
    }
}

class AboutTitleLabel: UILabel{
    
    init(title: String){
        super.init(frame: .zero)
        self.text = title
        self.textColor = UIColor.pinkPokemon
        self.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class AboutSubtitleLabel: UILabel{
    
    init(title: String){
        super.init(frame: .zero)
        self.text = title
        self.textColor = UIColor.gray
        self.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class AboutTextLabel: UILabel{
    
    init(text: String){
        super.init(frame: .zero)
        self.text = text
        self.textColor = UIColor.black
        self.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

