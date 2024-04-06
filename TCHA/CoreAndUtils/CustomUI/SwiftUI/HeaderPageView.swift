//
//  HeaderPageView.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 24/02/2023.
//

import SwiftUI

struct HeaderPageView: View {
    
    var title : String
    var image : String
    var body: some View {
        
        
        HStack(alignment : .center,spacing : 5) {
            Image(self.image)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
            
            Text(title.uppercased())
                .font(Font.body.bold())
            
            //Spacer()
        }
    }
}

struct HeaderPageView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderPageView(title: "Publier un trajet", image: AssetsManager.iconsName.logo_tcha_vertical.value())
            .previewLayout(.sizeThatFits)
    }
}
