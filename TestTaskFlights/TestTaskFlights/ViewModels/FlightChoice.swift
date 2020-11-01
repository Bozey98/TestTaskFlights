//
//  FlightChoice.swift
//  ZhekaTask
//
//  Created by Денис Мусатов on 01.11.2020.
//

import Foundation

class FlightChoise: ObservableObject {
    @Published var isPresented = false
    @Published var flight = FlightModel()
    
    func select(_ flight: FlightModel) {
        self.flight = flight
        self.isPresented = true
    }
}
