//
//  FlightsList.swift
//  ZhekaTask
//
//  Created by Денис Мусатов on 31.10.2020.
//

import SwiftUI

class FlightList: ObservableObject {
    @Published private(set) var flights: [FlightModel]
    
    var favouriteFlights: [FlightModel] {
        flights.filter { $0.isFavourite }
    }
    
    init() {
        flights = []
        fetchData()
        
    }
    
    func markAsFavoutite(_ flight: FlightModel) {
        flights[flightIndex(of: flight)].isFavourite.toggle()
    }
    
    func flightIndex(of flight: FlightModel) -> Int {
        flights.firstIndex(where: {$0.id == flight.id})!
    }
    
    func getImageName(from flight: FlightModel) -> String {
        flights[flightIndex(of: flight)].isFavourite ? "heart.fill" : "heart"
    }
    
    func getColor(for flight: FlightModel) -> Color {
        flights[flightIndex(of: flight)].isFavourite ? .red : .gray
    }
    
    
    
    func makeFlight(data: SkyScannerData) -> [FlightModel] {
        data.quotes.map { qoute in
            let price = qoute.minPrice
            guard let origin = data.places.first(where: {qoute.outboundLeg.originId == $0.placeId}) else { return FlightModel() }
            guard let destination = data.places.first(where: {qoute.outboundLeg.destinationId == $0.placeId}) else { return FlightModel() }
            
            guard let company = data.carriers.first(where: {qoute.outboundLeg.carrierIds.first! == $0.carrierId})?.name else { return FlightModel()}
            
            let originName = origin.cityName
            let originIata = origin.iataCode
            let destinationName = destination.cityName
            let destinationIata = destination.iataCode
            let data = qoute.quoteDateTime
            
            return FlightModel(originName: originName, originIata: originIata, destinationName: destinationName, destinationIata: destinationIata, price: price, data: data, company: company)
            
        }
    }
    
    func fetchData() {
        let headers = [
            "x-rapidapi-host": "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com",
            "x-rapidapi-key": "7ac3dd095emshcafe4f08288ecbcp17a7f9jsn184ee95ea1f8"
        ]

        let request = NSMutableURLRequest(
            url: NSURL(string: "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/browseroutes/v1.0/US/RUB/en-US/SVO-sky/JFK-sky/2020-11-11")! as URL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0
        )
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if let fetchData = data {
                print(fetchData)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .custom { (keys) -> CodingKey in
                    let key = keys.last!.stringValue
                    return LowerKey(stringValue: key)
                    
                }
                if let decoded = try? decoder.decode(SkyScannerData.self, from: fetchData) {
                    DispatchQueue.main.async {
                        self.flights = self.makeFlight(data: decoded)
                        
                    }
                }
            }
        }.resume()

    }
}

