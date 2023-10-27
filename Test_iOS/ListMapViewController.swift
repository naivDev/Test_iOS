//
//  ListMapViewController.swift
//  Test_iOS
//
//  Created by Oscar Ivan Pérez Salazar on 26/10/23.
//

import UIKit

class ListMapViewController: UIViewController {

    var arrayListAirport : [AirportListModel] = []
    var radius : Double = 0 
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("Arreglo de lista de estaciones \(arrayListAirport)")
        
        configureView()
        
    }
    
    func configureView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 140
        tableView.register(CustomCell.self, forCellReuseIdentifier: "\(CustomCell.self)")
        tableView.register(HeaderSectionCell.self, forHeaderFooterViewReuseIdentifier: "\(HeaderSectionCell.self)")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}
extension ListMapViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayListAirport.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(CustomCell.self)" , for: indexPath) as? CustomCell else {return UITableViewCell()
       
        }

        let airport = arrayListAirport[indexPath.row]
        
        cell.airportNameLabel.text = airport.name
        cell.countryCodeLabel.text = airport.alpha2countryCode
        cell.latitudeLabel.text = "Latitude: \(airport.latitude)"
        cell.longitudeLabel.text = "Longitude: \(airport.longitude)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "\(HeaderSectionCell.self)") as? HeaderSectionCell else{
            return UITableViewHeaderFooterView()
        }
        
        headerCell.setData(title: "Aeropuertos en un radio de \(Int(self.radius)) Km")
        return headerCell
    }
}
