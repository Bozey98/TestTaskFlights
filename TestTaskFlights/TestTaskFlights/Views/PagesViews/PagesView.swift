//
//  PagesView.swift
//  ZhekaTask
//
//  Created by Денис Мусатов on 01.11.2020.
//

import SwiftUI

struct PagesView: View {
    
    let viewControllers: [UIViewController]
    @Binding var number: Int
    
    init(views: [AnyView], number: Binding<Int>) {
        viewControllers = views.map {
            UIHostingController(rootView: $0)
        }
        self._number = number
    }
    
    var body: some View {
        PageViewController(number: $number, controllers: viewControllers)
    }
}
