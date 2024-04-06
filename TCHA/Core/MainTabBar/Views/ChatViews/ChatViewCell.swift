//
//  ChatViewCell.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 06/02/2023.
//

import SwiftUI

struct DualImageWithTitleMessageTime: View {
    
    var largeImageUrl :String
    var largeImageSize: CGFloat
    var smallImageUrl : String
    var smallImageSize: CGFloat
    var borderWith : CGFloat
    var borderColor : String
    var message : String
    var name : String
    var time : String
    var userCertified: Bool
    var lineLimit : Int = 1
    var messageWidth : CGFloat?
    var titleTextSize : CGFloat = 18
    var messageTextSize : CGFloat = 14
    var largeImageOpacity : Double = 1
    
    var body: some View {
        
        HStack {
            
            if userCertified {
                DualUIImage(largeImageUrl: self.largeImageUrl, largeImageSize: self.largeImageSize, smallImageUrl: self.smallImageUrl, smallImageSize: self.smallImageSize, borderWith: self.borderWith, borderColor: self.borderColor, largeImageOpacity: largeImageOpacity)
            }else {
                DualUIImage(largeImageUrl: self.largeImageUrl, largeImageSize: self.largeImageSize, smallImageUrl: smallImageUrl, smallImageSize: 0, borderWith: 0, borderColor: borderColor, largeImageOpacity: largeImageOpacity)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                HStack() {
                    Text(self.name)
                        .font(.system(size: titleTextSize))
                        .bold()
                        .lineLimit(self.lineLimit)
                    Spacer()
                    if !self.time.isEmpty || self.time != "" {
                        Text(self.time)
                            .font(.system(size: 14))
                            .foregroundColor(Color.gray)
                            .lineLimit(self.lineLimit)
                    }
                }
                
                if messageWidth == nil {
                    Text(self.message)
                        .font(.system(size: messageTextSize))
                        .foregroundColor(Color.gray)
                        .lineLimit(.max)
                        .frame(width: .infinity)
                        .multilineTextAlignment(.leading)
                }else{
                    Text(self.message)
                        .font(.system(size: messageTextSize))
                        .foregroundColor(Color.gray)
                        .lineLimit(self.lineLimit)
                        .frame(width: messageWidth)
                }
                
                    
            }
            
        }
    }
}

struct DualImageWithTitleMessageTime_Previews: PreviewProvider {
    static var previews: some View {
        
        DualImageWithTitleMessageTime(largeImageUrl : AssetsManager.iconsName.woman1.value(), largeImageSize: 60, smallImageUrl : AssetsManager.iconsName.accept.value(), smallImageSize: 25,  borderWith: 3, borderColor : ColorManager.ConfigColorsEnum.primaryColor.nameId(), message: "Bonjour, j'ai déja transféré votre colis, il arrivera dans 06 jours", name: "Ngouan Iton", time: "12:24", userCertified: true, lineLimit: 1, messageWidth: 270.0)
            .previewLayout(.sizeThatFits)
      
    }
}
