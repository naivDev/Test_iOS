//
//  MapViewController.swift
//  Test_iOS
//
//  Created by Oscar Ivan Pérez Salazar on 26/10/23.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var arrayListAirport : [AirportListModel] = []
    var radius: Double = 0
    var latitude: Double = 0
    var longitude: Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapPinView()
    }
    
    func mapPinView() {
        for airport in arrayListAirport {
            print("airport \(airport)")
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: airport.latitude, longitude: airport.longitude)
            annotation.title = airport.name
            annotation.subtitle = airport.alpha2countryCode
            mapView.addAnnotation(annotation)
        }
        
        let annotation2 = MKPointAnnotation()
        //Sustituir la latitude y longitude por las variebles conrespondientes si se simula en dispositivo fisico
        //annotation2.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation2.coordinate = CLLocationCoordinate2D(latitude: 19.439876902025098, longitude: -99.07153126824896)
        let rango = radius * 1000
        let region = MKCoordinateRegion(center: annotation2.coordinate, latitudinalMeters: rango, longitudinalMeters: rango)
        mapView.setRegion(region, animated: true)
    }
    
}


