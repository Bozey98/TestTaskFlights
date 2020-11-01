//
//  ContentView.swift
//  ZhekaTask
//
//  Created by Денис Мусатов on 30.10.2020.
//

import SwiftUI

struct ContentView: View {
    
    let views = [AnyView(FavouritesView()),AnyView(BrowseView())]
    @State var number = 1
    @ObservedObject var flightList = FlightList()
    @ObservedObject var flightChoise = FlightChoise()
    var body: some View {

        VStack(spacing: 0) {
            ZStack {
                Color.white
                VStack {
                    Spacer()
                    Text("Flights").bold().padding()
                    HStack {
                        Button(action: { number = 0 } ) {
                            Text("Favourite").bold()
                        }.buttonStyle(MenuButton(tag: 0, number: number))
                        
                        Button(action: { number = 1 } ) {
                            Text("Browse").bold()
                        }.buttonStyle(MenuButton(tag: 1, number: number))
                    }
                }.foregroundColor(.black)
            }
            .frame(height: UIScreen.main.bounds.height / 6)
            
            PagesView(views: views, number: $number)
                .environmentObject(flightList)
                .environmentObject(flightChoise)
                .edgesIgnoringSafeArea(.bottom)
                
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
        .customSheet(isPresented: $flightChoise.isPresented) {
            ZStack {
                DetailView(flight: self.flightChoise.flight)
                    .environmentObject(self.flightChoise)
                    .environmentObject(flightList)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

