//
//  ListMapPresenter.swift
//  Test_iOS
//
//  Created by Oscar Ivan Pérez Salazar on 26/10/23.
//

import Foundation

protocol ListAirportProtocol: AnyObject {
    
    func showListAirports(_ airports: [AirportListModel])
    func showListError(_ error: Error)
}

class ListMapPresenter {
    
    weak var listAirportProtocol : ListAirportProtocol!
    
    func setViewDelegate(listAirportProtocol: ListAirportProtocol?){
        self.listAirportProtocol = listAirportProtocol
    }
    
    func sendListAirport(listAirports: [AirportListModel]) {
        self.listAirportProtocol.showListAirports(listAirports)
    }
    
}
