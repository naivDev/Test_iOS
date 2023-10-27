//
//  ServiceLayer.swift
//  Test_iOS
//
//  Created by Oscar Ivan Pérez Salazar on 23/10/23.
//

import Foundation

class ServiceLayer {
    
    func searchAirports(latitude: Double, longitude: Double, radius: Int, success: @escaping (_ data: [AirportListModel]) -> (), failure: @escaping (_ error: Error?) -> ()){
        
        let apiKey = "4d06311efdmsh61f67ec5753bc8ep1bde2fjsna5a1bb3daebb"
        let host = "aviation-reference-data.p.rapidapi.com"
        let urlString = "https://aviation-reference-data.p.rapidapi.com/airports/search?lat=\(latitude)&lon=\(longitude)&radius=\(radius)"
        
        guard let url = URL(string: urlString) else {
            failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        request.addValue(host, forHTTPHeaderField: "X-RapidAPI-Host")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                do {
                    let airports = try JSONDecoder().decode([AirportListModel].self, from: data)
                    success(airports)
                    print("Datos Recibidos: \(airports)")
                } catch {
                    failure(error)
                }
            }
        }.resume()
    }
    
}
