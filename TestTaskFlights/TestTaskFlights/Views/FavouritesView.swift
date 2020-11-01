//
//  FavouritesView.swift
//  ZhekaTask
//
//  Created by Денис Мусатов on 01.11.2020.
//

import SwiftUI

struct FavouritesView: View {
    
    @EnvironmentObject var flightList: FlightList
    @EnvironmentObject var flightChoise: FlightChoise
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1))
                .edgesIgnoringSafeArea(.bottom)
            VStack {
                ScrollView {
                    ForEach(flightList.favouriteFlights) { flight in
                        FlightCellView(flight: flight)
                            .onTapGesture(count: 1, perform: {
                                withAnimation {
                                    self.flightChoise.select(flight)
                                }
                            })
                    }
                }
                Spacer()
            }.edgesIgnoringSafeArea(.bottom)
            
            
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
