//
//  DetailView.swift
//  ZhekaTask
//
//  Created by Денис Мусатов on 01.11.2020.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject var flightChoise: FlightChoise
    @EnvironmentObject var flightList: FlightList
    
    var flight: FlightModel
    
    let color1 = Color(.sRGB, red: 51/255, green: 94/255, blue: 185/255, opacity: 1)
    let color2 = Color(.sRGB, red: 21/255, green: 148/255, blue: 220/255, opacity: 1)
    let images = ["img1", "img2", "img3", "img1", "img2", "img3"]

    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Image("backImage")
                Spacer()
            }
            VStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            self.flightChoise.isPresented = false
                        }
                    }) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    
                    Spacer()
                }
                .foregroundColor(.white).font(.title)
                .padding([.top],40)
                .padding(.leading)
                Spacer()
            }
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.white)
                    VStack(spacing: 0) {
                        headerView
                        priceView
                        scrollView
                        Spacer()
                    }
                }
            }.frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height / 1.8)
            
        }.edgesIgnoringSafeArea(.all)
    }
    
    
    var headerView: some View {
        
        ZStack {
            VStack {
                HStack(alignment: .top) {
                    Spacer()
                    FavouriteButtonView(in: flightList, for: flight) {
                        flightList.markAsFavoutite(flight)
                    }
                }
                Spacer()
            }
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(flight.getShortDate()).foregroundColor(.gray)
                    Text(flight.originIata).font(.largeTitle).bold().foregroundColor(.black)
                    Text(flight.originName).foregroundColor(.gray)
                }
                Spacer()
                Image(systemName: "chevron.right").font(.title).foregroundColor(.gray)
                Spacer()
                VStack(alignment: .leading, spacing: 4) {
                    Text(flight.getShortTime()).foregroundColor(.gray)
                    Text(flight.destinationIata).font(.largeTitle).bold().foregroundColor(.black)
                    Text(flight.destinationName).foregroundColor(.gray)
                }
            }
        }
        .frame(height: UIScreen.main.bounds.height / 10)
        .padding()
        .padding([.top, .horizontal])
        
    }
    
    
    var priceView: some View {
        
        ZStack {
            LinearGradient(gradient: .init(colors: [color1, color2]), startPoint: .leading, endPoint: .trailing)
                .frame(height: UIScreen.main.bounds.height / 9)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                
            HStack {
                VStack {
                    Text("Price")
                    Text("\(flight.price) P").bold().font(.title)
                }
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 1, height: UIScreen.main.bounds.height / 100 * 7)
                    .padding()
                    
                VStack {
                    Text("Boarding")
                    Text(flight.getShortTime(addInterval: 10)).bold().font(.title)
                }.padding(.horizontal)
            }.foregroundColor(.white)
        }.shadow(radius: 5)
        .padding(.horizontal)
        
    }
    
    var scrollView: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(images, id: \.self) { image in
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width / 3)
                        .shadow(radius: 10)
                }
            }.padding()
        }
        
    }
    
}

struct DetailView_Previews: PreviewProvider {
    
    static let flight = FlightModel(originName: "Moscow", originIata: "SVO", destinationName: "New York City", destinationIata: "SFA", price: 12345, data: "2020-11-01T12:12:12", company: "Aeroflot")
    
    static var previews: some View {
        DetailView(flight: flight)
    }
}
