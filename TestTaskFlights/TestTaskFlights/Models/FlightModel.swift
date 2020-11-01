//
//  FlightModel.swift
//  ZhekaTask
//
//  Created by Денис Мусатов on 01.11.2020.
//

import Foundation

struct FlightModel: Identifiable, Hashable {
    let id = UUID()
    let originName: String
    let originIata: String
    let destinationName: String
    let destinationIata: String
    let price: Int
    let data: String
    let company: String
    var isFavourite = false
    
    init(originName: String, originIata: String, destinationName: String, destinationIata: String, price: Int, data: String, company: String) {
        self.originName = originName
        self.originIata = originIata
        self.destinationName = destinationName
        self.destinationIata = destinationIata
        self.price = price
        self.data = data
        self.company = company
    }
    
    init() {
        self.originName = ""
        self.originIata = ""
        self.destinationName = ""
        self.destinationIata = ""
        self.price = 0
        self.data = ""
        self.company = ""
    }
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        //dd MMMM, yyyy - HH:mm
        let date = dateFormatter.date(from: data)!
        
        dateFormatter.dateFormat = "dd MMMM, yyyy - HH:mm"
        
        
        return dateFormatter.string(from: date)
    }
    
    func getShortDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        //dd MMMM, yyyy - HH:mm
        let date = dateFormatter.date(from: data)!
        
        dateFormatter.dateFormat = "dd MM, yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    func getShortTime(addInterval: Double = 0) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        //dd MMMM, yyyy - HH:mm
        var date = dateFormatter.date(from: data)!
        
        dateFormatter.dateFormat = "HH:mm"
        
        date.addTimeInterval(60*60*addInterval)
        
        return dateFormatter.string(from: date)
    }
    
    mutating func tapFavouriteHeart() {
        self.isFavourite.toggle()
    }
}
