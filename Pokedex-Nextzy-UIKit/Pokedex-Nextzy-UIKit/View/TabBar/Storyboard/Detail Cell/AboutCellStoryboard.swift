//
//  AboutCellStoryboard.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 11/2/2567 BE.
//

import UIKit
import MapKit

class AboutCellStoryboard: UITableViewCell {

    // MARK: - Varibles
    static let identifier = "AboutCellStoryboard"
    private var pokemon: Pokemon?
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typesStack: UIStackView!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var eggGroupLabel: UILabel!
    @IBOutlet weak var eggCycleLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var baseEXPLabel: UILabel!
    
    func configCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        setupUI()
    }
    
    func setupUI() {
        guard let pokemon = self.pokemon else { return }
        descriptionLabel.text = pokemon.xDescription
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        genderLabel.text = "♂ \(pokemon.malePercentage ?? "N/A") ♀ \(pokemon.femalePercentage ?? "N/A")"
        eggGroupLabel.text = pokemon.eggGroups
        eggCycleLabel.text = pokemon.cycles
        baseEXPLabel.text = pokemon.baseExp
        
        setupMap()
        createPokemonTypeStackView(types: pokemon.types)
    }
    func setupMap() {
        let myOfficeLocation = CLLocationCoordinate2D(latitude: 13.752709852833902, longitude: 100.56156446958983)
        let zoomDistance: CLLocationDistance = 1400000
        let coordinateRegion = MKCoordinateRegion(
            center: myOfficeLocation,
            latitudinalMeters: zoomDistance,
            longitudinalMeters: zoomDistance
        )
        mapView.setRegion(coordinateRegion, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = myOfficeLocation
        annotation.title = "Nextzy Office"
        mapView.addAnnotation(annotation)
        
    }
    
    func createPokemonTypeStackView(types: [String]) {
        typesStack.subviews.forEach { $0.removeFromSuperview() }
        for type in types {
            let typeComponents = PokemonTypeComponent(type: type)
            typesStack.addArrangedSubview(typeComponents)
        }
    }
    
}
