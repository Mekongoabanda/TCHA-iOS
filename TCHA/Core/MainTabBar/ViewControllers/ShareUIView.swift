//
//  ShareUIView.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 24/02/2023.
//

import SwiftUI
import UIKit

struct ShareUIView: View {
    
    var headerImage = AssetsManager.iconsName.logo_tcha_vertical.rawValue
    @State var showForm = false
    
    var body: some View {
        
        VStack {
            
            HeaderPageView(title: "PUBLIER UN VOYAGE", image: self.headerImage)
            
            Spacer()
            
            Image(AssetsManager.iconsName.earth_product_icon.rawValue)
                .resizable()
                .scaledToFit()
                .padding(EdgeInsets(top: 0, leading: 60, bottom: 0, trailing: 60))
            
            Spacer()
            
            Button(action: {
                // Action à effectuer lors du clic sur le bouton
                self.showForm = true
            }) {
                Text("PUBLIER UN VOYAGE")
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .foregroundColor(.white)
                    .font(.system(size: 25, weight: .heavy, design: .default))
                    .background(Color(ColorManager.ConfigColorsEnum.primaryColor.nameId()))
                    .cornerRadius(25)
            }
            
            Spacer()
            
            
        }.padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
            .sheet(isPresented: $showForm) {
                FormUIViews()
            }
        
    }
}



struct ShareUIView_Previews: PreviewProvider {
    static var previews: some View {
        ShareUIView()
    }
}
