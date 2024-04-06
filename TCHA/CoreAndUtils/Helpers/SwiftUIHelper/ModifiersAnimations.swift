//
//  ModifierAnimation.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 13/06/2023.
//

import SwiftUI

struct ModifiersAnimations: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ModifiersAnimations_Previews: PreviewProvider {
    static var previews: some View {
        ModifiersAnimations()
    }
}

//Bounce object
struct BouncingAnimationModifier: ViewModifier {
    @State private var isBouncing = false
    @State var scale = 1.5
    @State private var defaultScale = 1.0

    func body(content: Content) -> some View {
        content
            .scaleEffect(isBouncing ? scale : defaultScale)
            .animation(Animation.spring().repeatForever(autoreverses: true))
            .onAppear {
                isBouncing = true
            }
            .onDisappear {
                isBouncing = false
            }
    }
    
}

