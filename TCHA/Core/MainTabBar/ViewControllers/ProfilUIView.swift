//
//  ProfilUIView.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 29/01/2023.
//

import SwiftUI

struct ProfilUIView: View {
    
    var largeImageUrl :String = AssetsManager.iconsName.man2.value()
    var largeImageSize: CGFloat = 85
    var smallImageUrl : String = AssetsManager.iconsName.accept.value()
    var smallImageSize: CGFloat = 30
    var borderWith : CGFloat = 3
    var borderColor : String = ColorManager.ConfigColorsEnum.primaryColor.nameId()
    var name : String = "Edouard TEST"
    @State var userCertified: Bool = true
    
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 30) {
            
            Text("Profile")
                .foregroundColor(Color(ColorManager.ConfigColorsEnum.blackColor.nameId()))
                .bold()
                .font(Font.system(size: 20))
            
            if userCertified {
                DualUIImage(largeImageUrl: self.largeImageUrl, largeImageSize: self.largeImageSize, smallImageUrl: self.smallImageUrl, smallImageSize: self.smallImageSize, borderWith: self.borderWith, borderColor: self.borderColor)
            }else {
                DualUIImage(largeImageUrl: self.largeImageUrl, largeImageSize: self.largeImageSize, smallImageUrl: smallImageUrl, smallImageSize: 0, borderWith: 0, borderColor: borderColor)
            }
            
            Text(name)
                .foregroundColor(Color(ColorManager.ConfigColorsEnum.blackColor.nameId()))
                .bold()
                .font(Font.system(size: 20))
            
            Button("Edit Profile >>") {
                
            }.padding(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
                .foregroundColor(.white)
                .font(Font.system(size: 16, weight: .bold))
                .background(Color(ColorManager.ConfigColorsEnum.primaryColor.nameId()))
                .cornerRadius(25)
            
            Divider().foregroundColor(Color(ColorManager.ConfigColorsEnum.grayAppColor.nameId()))
            
            ProfileOptionUIview(rightIcon: AssetsManager.iconsName.arrow_right_round.value(), title: "Settings", leftIcon: AssetsManager.iconsName.gear.value(), leftImageSize: 25, titleSize: 16, leftIconSize: 40)
            
            ProfileOptionUIview(rightIcon: AssetsManager.iconsName.arrow_right_round.value(), title: "Payments Infos", leftIcon: AssetsManager.iconsName.credit_card.value(), leftImageSize: 25, titleSize: 16, leftIconSize: 40)
            
            ProfileOptionUIview(rightIcon: AssetsManager.iconsName.arrow_right_round.value(), title: "Informations", leftIcon: AssetsManager.iconsName.information.value(), leftImageSize: 25, titleSize: 16, leftIconSize: 40)
            
            ProfileOptionUIview(rightIcon: AssetsManager.iconsName.arrow_right_round.value(), title: "Log Out", leftIcon: AssetsManager.iconsName.logout.value(), leftImageSize: 25, titleSize: 16, leftIconSize: 40)
            
            Spacer()
            
        }.padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
    }
}

struct ProfilUIView_Previews: PreviewProvider {
    static var previews: some View {
        
        ProfilUIView(largeImageUrl: AssetsManager.iconsName.woman3.value(), largeImageSize: 100, smallImageUrl: AssetsManager.iconsName.accept.value(), smallImageSize: 35, borderWith: 3, borderColor: ColorManager.ConfigColorsEnum.primaryColor.nameId(), name: "Cynthia ENOW", userCertified: true)
    }
}

struct ProfileOptionUIview: View {
    
    var rightIcon : String
    var title : String
    var leftIcon : String
    var leftImageSize = CGFloat()
    var titleSize = CGFloat()
    var leftIconSize = CGFloat()
    
    var body: some View {
        
        HStack{
            
            ZStack{
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 40, height: 40)
                    .cornerRadius(6)
                    .shadow(radius: 6)
                
                Image(leftIcon)
                    .resizable()
                    .frame(width: leftImageSize, height: leftImageSize)
            }
            
            Text(title)
                .foregroundColor(Color(ColorManager.ConfigColorsEnum.blackColor.nameId()))
                .bold()
                .font(Font.system(size: titleSize))
            
                .padding(.leading, 10)
            Spacer()
            
            Image(rightIcon)
                .resizable()
                .frame(width: leftIconSize, height: leftIconSize)
            
            
            
        }
        
    }
}



struct ProfileOptionUIview_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ProfileOptionUIview(rightIcon: AssetsManager.iconsName.arrow_right_round.value(), title: "Settings", leftIcon: AssetsManager.iconsName.gear.value(), leftImageSize: 25, titleSize: 16, leftIconSize: 40)
            .previewLayout(.sizeThatFits)
    }
}

