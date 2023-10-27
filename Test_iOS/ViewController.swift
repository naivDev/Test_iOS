//
//  ViewController.swift
//  Test_iOS
//
//  Created by Oscar Ivan Pérez Salazar on 23/10/23.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var latitude : Double? = 0
    var longitude : Double? = 0
    var radius : Double? = 0
    var manager : CLLocationManager?
    let airportTextLabel = UILabel()
    let finderTextlabel = UILabel()
    let radiusTextlabel = UILabel()
    let descriptionTextlabel = UILabel()
    let slider = UISlider()
    let button = UIButton()
    var array : [AirportListModel] = []
    var presenter = AirportSearchPresenter(serviceLayer: ServiceLayer())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  UIColor(white: 0.9, alpha: 1.0)
        presenter.setViewDelegate(airportSearchProtocol: self)
        setUpUI()
        
        NotificationCenter.default.addObserver(self, selector:#selector(dataSuccess(_:)), name: NSNotification.Name("View"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager = CLLocationManager()
        manager?.delegate = self
        manager?.desiredAccuracy = kCLLocationAccuracyKilometer
        manager?.requestWhenInUseAuthorization()
        manager?.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        print(String(latitude ?? 0) + " y " + String(longitude ?? 0))
    }
    
    func setUpUI() {
        view.addSubview(airportTextLabel)
        view.addSubview(finderTextlabel)
        view.addSubview(radiusTextlabel)
        view.addSubview(slider)
        view.addSubview(descriptionTextlabel)
        view.addSubview(button)
        
        airportTextLabel.translatesAutoresizingMaskIntoConstraints = false
        finderTextlabel.translatesAutoresizingMaskIntoConstraints = false
        radiusTextlabel.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextlabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        airportTextLabel.text = "AIRPORT"
        airportTextLabel.textAlignment = .center
        airportTextLabel.textColor = UIColor.white
        airportTextLabel.font = UIFont.systemFont(ofSize: 30.0)
        airportTextLabel.font = UIFont.boldSystemFont(ofSize: 45.0)
        
        finderTextlabel.text = "finder"
        finderTextlabel.textAlignment = .center
        finderTextlabel.textColor = UIColor.white
        finderTextlabel.font = UIFont.systemFont(ofSize: 20.0)
        finderTextlabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        
        radiusTextlabel.text = "10"
        radiusTextlabel.textAlignment = .center
        radiusTextlabel.textColor = UIColor.gray
        radiusTextlabel.font = UIFont.systemFont(ofSize: 50.0)
        radiusTextlabel.font = UIFont.boldSystemFont(ofSize: 80.0)
        
        slider.minimumValue = 10
        slider.maximumValue = 350
        slider.value = 10
        slider.isContinuous = true
        slider.tintColor = UIColor.systemBlue
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        descriptionTextlabel.text = "Radius in KM"
        descriptionTextlabel.textAlignment = .center
        descriptionTextlabel.textColor = UIColor.gray
        descriptionTextlabel.font = UIFont.systemFont(ofSize: 10.0)
        descriptionTextlabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        
        button.configuration = .tinted()
        button.configuration?.title = "SEARCH"
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 0.7
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 4.0
        button.layer.shadowOpacity = 0.5
        button.layer.borderColor = UIColor.blue.cgColor
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        let leftPadding: CGFloat = 30
        let rightPading: CGFloat = -30
        let heighAnchor: CGFloat = 50
        
        NSLayoutConstraint.activate([
            
            airportTextLabel.centerXAnchor.constraint(equalTo: finderTextlabel.centerXAnchor),
            airportTextLabel.bottomAnchor.constraint(equalTo: finderTextlabel.topAnchor, constant: 20),
            airportTextLabel.heightAnchor.constraint(equalToConstant: 40),
            
            finderTextlabel.centerXAnchor.constraint(equalTo: radiusTextlabel.centerXAnchor),
            finderTextlabel.bottomAnchor.constraint(equalTo: radiusTextlabel.topAnchor, constant: -70),
            finderTextlabel.heightAnchor.constraint(equalToConstant: 80),
            
            radiusTextlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            radiusTextlabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            slider.topAnchor.constraint(equalTo: radiusTextlabel.bottomAnchor, constant: 20),
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftPadding),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightPading),
            
            descriptionTextlabel.centerXAnchor.constraint(equalTo: slider.centerXAnchor),
            descriptionTextlabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 10),
            
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant:  -60),
            button.heightAnchor.constraint(equalToConstant: heighAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftPadding),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightPading)
        ])
    }
    
    @objc func sliderValueChanged(){
        let sliderValue = Int(slider.value)
        radiusTextlabel.text = "\(sliderValue)"
        self.radius = Double(sliderValue)
    }
    
    @objc func didTapButton() {
        //Cambiar si se simula con celular fisico el presenter con los datos obtenidos en tiempo real (latitude y longitude)
        //presenter.getAirports(latitude: latitude, longitude: longitude , radius: Int(radius ?? 0))
        presenter.getAirports(latitude: 19.439876902025098 , longitude: -99.07153126824896 , radius: Int(radius ?? 0))
        let vc = storyboard?.instantiateViewController(identifier: "TabBarController")
        
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @objc func dataSuccess(_ notification: Notification) {
        let vc = (storyboard!.instantiateViewController(identifier: "TabBarController") as? UITabBarController)!
        let map = vc.viewControllers![0] as? MapViewController
        map?.arrayListAirport = array
        map?.radius = radius!
        map?.latitude = Double(latitude!)
        map?.latitude = Double(longitude!)
        let list = vc.viewControllers![1] as? ListMapViewController
        list?.radius = radius!
                list?.arrayListAirport = array
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController : AirportSearchProtocol {
    
    func showAirports(_ airports: [AirportListModel]) {
        array = airports
        print("Aeropuertos Airports: \([array])")
    }
    
    func showError(_ error: Error) {
        print("Error: " + error.localizedDescription)
    }
}

