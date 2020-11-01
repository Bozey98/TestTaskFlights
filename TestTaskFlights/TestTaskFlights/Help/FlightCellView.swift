//
//  FlightCellView.swift
//  ZhekaTask
//
//  Created by Денис Мусатов on 31.10.2020.
//

import SwiftUI

struct FlightCellView: View {
    
    @EnvironmentObject var flightList: FlightList
    
    var flight: FlightModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(radius: 5)
            VStack {
                HStack(alignment: .top) {
                    Image("plane")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: UIScreen.main.bounds.height / 12, height: UIScreen.main.bounds.height / 12)

                        
                    VStack(alignment: .leading, spacing: 7) {
                        HStack {
                            Text(flight.originName)
                            Image(systemName: "arrow.right").font(.footnote).foregroundColor(.gray)
                            Text(flight.destinationName)
                        }
                        HStack {
                            Text(flight.originIata).foregroundColor(.gray)
                            Text(flight.getDate()).foregroundColor(.gray)
                        }.font(.footnote)
                        HStack {
                            Text(flight.company).foregroundColor(.gray)
                        }.font(.footnote)
                    }
                    
                    Spacer()
                    
                    FavouriteButtonView(in: flightList, for: flight) {
                        flightList.markAsFavoutite(flight)
                    }
                    
                        
                }
                .padding(20)
                
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(height: 1)
                    .padding([.leading], 20)
                    .padding([.trailing], 10)
                    .opacity(0.4)
                
                HStack {
                    Spacer()
                    Text("Price").font(.caption).foregroundColor(.gray)
                    Text("\(flight.price) P")
                }.padding([.horizontal,.bottom])
                
                
                
                Spacer()
            }
            
        }
        .foregroundColor(.black)
        .padding()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 4)
        
        
    }
}

struct FlightCellView_Previews: PreviewProvider {
    static var previews: some View {
        FlightCellView(flight: FlightModel())
    }
}
