//
//  AirportSearchPresenter.swift
//  Test_iOS
//
//  Created by Oscar Ivan Pérez Salazar on 25/10/23.
//

import Foundation

protocol AirportSearchProtocol: AnyObject {
    func showAirports(_ airports: [AirportListModel])
    func showError(_ error: Error)
    
}

class AirportSearchPresenter {
    
    private let serviceLayer : ServiceLayer
    
    weak var airportSearchProtocol: AirportSearchProtocol?
    
    init(serviceLayer: ServiceLayer ) {
        self.serviceLayer = serviceLayer
    }
    
    func setViewDelegate(airportSearchProtocol: AirportSearchProtocol?){
        self.airportSearchProtocol = airportSearchProtocol
    }
    
    func getAirports(latitude: Double, longitude: Double, radius: Int) {
        serviceLayer.searchAirports(latitude: latitude, longitude: longitude, radius: radius) { data in
            
            DispatchQueue.main.async {
                self.airportSearchProtocol?.showAirports(data)
                NotificationCenter.default.post(name: NSNotification.Name("View"), object: nil, userInfo: nil)
            }
        } failure: { error in
            DispatchQueue.main.async {
                self.airportSearchProtocol?.showError(error!)
            }
        }
    }
}
