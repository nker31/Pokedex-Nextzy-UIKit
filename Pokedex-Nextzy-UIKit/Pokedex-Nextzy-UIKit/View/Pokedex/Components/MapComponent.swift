//
//  MapComponent.swift
//  Pokedex-Nextzy-UIKit
//
//  Created by Nathat Kuanthanom on 26/1/2567 BE.
//

import UIKit
import MapKit

class MapComponent: UIView{
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    var mapView: MKMapView = {
        let mapView = MKMapView()
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
        return mapView
    }()
    
    func setupUI(){
        self.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
    }
    
    
}
