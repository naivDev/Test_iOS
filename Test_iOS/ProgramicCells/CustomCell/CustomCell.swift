//
//  ListAirportCell.swift
//  Test_iOS
//
//  Created by Oscar Ivan Pérez Salazar on 27/10/23.
//

import UIKit

class CustomCell : UITableViewCell {
    
     var airportNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     var countryCodeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     var latitudeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     var longitudeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy private var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(stackView)
        addSubview(airportNameLabel)
        addSubview(countryCodeLabel)
        addSubview(latitudeLabel)
        addSubview(longitudeLabel)
        
        let leftPadding: CGFloat = 15
        let bottom: CGFloat = 5
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            airportNameLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
            airportNameLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            
            countryCodeLabel.topAnchor.constraint(equalTo: airportNameLabel.bottomAnchor, constant: bottom),
            countryCodeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: leftPadding),
            
            latitudeLabel.topAnchor.constraint(equalTo: countryCodeLabel.bottomAnchor, constant: bottom),
            latitudeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: leftPadding),
            
            longitudeLabel.topAnchor.constraint(equalTo: latitudeLabel.bottomAnchor, constant: bottom),
            longitudeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: leftPadding),
            
        ])
    }
}
