//
//  FetchModels.swift
//  ZhekaTask
//
//  Created by Денис Мусатов on 31.10.2020.
//

import Foundation


struct SkyScannerData: Codable {
    var quotes: [Quotes]
    var carriers: [Carriers]
    var places: [Places]
}

struct Quotes: Codable {
    var quoteId: Int
    var minPrice: Int
    var direct: Bool
    var outboundLeg: OutboundLeg
    var quoteDateTime: String
}

struct OutboundLeg: Codable {
    var carrierIds: [Int]
    var originId: Int
    var destinationId: Int
    var departureDate: String
}

struct Carriers: Codable {
    var carrierId: Int
    var name: String
}

struct Places: Codable {
    var placeId: Int
    var iataCode: String
    var name: String
    var type: String
    var skyscannerCode: String
    var cityName: String
    var cityId: String
    var countryName: String
}


struct LowerKey: CodingKey {
    var stringValue: String
    
    init(stringValue: String) {
        self.stringValue = stringValue.prefix(1).lowercased() + stringValue.dropFirst()
    }
    
    var intValue: Int?
    
    init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = ""
    }
    
    
}
