//
//  ChatUIView.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 06/02/2023.
//

import SwiftUI

struct ChatUIView: View {
    
    var largeImageSize: CGFloat = 50
    var smallImageSize: CGFloat = 20
    var smallImageUrl : String = AssetsManager.iconsName.accept.value()
    var borderWith : CGFloat = 3
    var borderColor : String = ColorManager.ConfigColorsEnum.primaryColor.nameId()
    var headerImage = AssetsManager.iconsName.logo_tcha_vertical.rawValue
    
    var userTest : [(imageUrl : String, time : String, message : String, name : String, userCertified : Bool)] = [
        (AssetsManager.iconsName.woman1.value(), "12:44", "Hey there i'm using TCHA", "Bébé DJ", userCertified : true),
        (AssetsManager.iconsName.man1.value(), "12:44", "Hey there i'm using TCHA", "Marcel TATSINDA", userCertified : true),
        (AssetsManager.iconsName.picarb.value(), "12:44", "Hey there i'm using TCHA", "Yannick Edouard", userCertified : false),
        (AssetsManager.iconsName.man2.value(), "12:44", "Hey there i'm using TCHA", "Sévérin TSAFACK", userCertified : false),
        (AssetsManager.iconsName.woman2.value(), "12:44", "Hey there i'm using TCHA", "Esmeralda Lombard", userCertified : true),
        (AssetsManager.iconsName.woman3.value(), "12:44", "Hey there i'm using TCHA", "Ashley BELINGA", userCertified : true)]
    
    var body: some View {
        
        
        VStack {
            
            HeaderPageView(title: "MESSAGERIE", image: self.headerImage)
            
            List(0..<userTest.count){ i in
                
                DualImageWithTitleMessageTime(largeImageUrl: userTest[i].imageUrl, largeImageSize: largeImageSize, smallImageUrl: smallImageUrl, smallImageSize: smallImageSize, borderWith: borderWith, borderColor: borderColor, message: userTest[i].message, name: userTest[i].name, time: userTest[i].time, userCertified: userTest[i].userCertified, messageWidth: 270.0).padding(2)
                
            }.listStyle(PlainListStyle())
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct ChatUIView_Previews: PreviewProvider {
    static var previews: some View {
        ChatUIView()
    }
}
