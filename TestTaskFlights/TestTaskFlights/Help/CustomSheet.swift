//
//  CustomSheet.swift
//  ZhekaTask
//
//  Created by Денис Мусатов on 01.11.2020.
//

import SwiftUI

struct CustomSheet<CustomView: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    var presentedView: CustomView
    
    init(isPresented: Binding<Bool>, @ViewBuilder presentedView:  () -> CustomView) {
        self._isPresented = isPresented
        self.presentedView = presentedView()
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content.zIndex(0)
            if isPresented {
                presentedView
                    .zIndex(1)
                    .transition(.slideUp)
            }
            
        }
    }
}

extension View {
    func customSheet<CustomView: View>(isPresented: Binding<Bool>, @ViewBuilder presentedView: () -> CustomView) -> some View {
        self.modifier(CustomSheet(isPresented: isPresented, presentedView: presentedView))
    }
}


extension AnyTransition {
    static var slideUp: AnyTransition {
        let appear = AnyTransition.move(edge: .bottom)
        let dissapear = AnyTransition.move(edge: .bottom)
        
        return AnyTransition.asymmetric(insertion: appear, removal: dissapear)
    }
    
}

