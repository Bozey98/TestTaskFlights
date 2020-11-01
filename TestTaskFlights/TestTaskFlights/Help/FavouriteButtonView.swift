//
//  FavouriteButtonView.swift
//  ZhekaTask
//
//  Created by Денис Мусатов on 02.11.2020.
//

import SwiftUI

struct FavouriteButtonView: View {
    
    @ObservedObject var flightList: FlightList
    var flight: FlightModel
    var action: (() -> ())
    
    init(in flightList: FlightList, for flight: FlightModel, action: @escaping () -> ()) {
        self.flightList = flightList
        self.flight = flight
        self.action = action
    }
    
    var body: some View {
        Image(systemName: flightList.getImageName(from: flight))
            .onTapGesture(count: 1, perform: action)
            .foregroundColor(self.flightList.getColor(for: flight))
    }
}
