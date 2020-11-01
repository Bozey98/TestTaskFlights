//
//  MenuButtonStyle.swift
//  ZhekaTask
//
//  Created by Денис Мусатов on 02.11.2020.
//

import SwiftUI

struct MenuButton: ButtonStyle {
    
    var tag: Int
    var number: Int
    
    let color1 = Color(.sRGB, red: 51/255, green: 94/255, blue: 185/255, opacity: 1)
    let color2 = Color(.sRGB, red: 21/255, green: 148/255, blue: 220/255, opacity: 1)
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
            
            if tag == number {
                VStack {
                    Spacer()
                    LinearGradient(gradient: .init(colors: [color1, color2]), startPoint: .leading, endPoint: .trailing)
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                        .frame(height: 8)
                }
            }
            
        }.frame(width: UIScreen.main.bounds.width / 2 - 30, height: 50)
        
            
    }
}
