//
//  CustomsImageView.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 06/02/2023.
//

import SwiftUI

struct CustomsImageView: View {

    var body: some View {
    
        Text("Hello world!")

    }
}

struct CustomsImageView_Previews: PreviewProvider {
    static var previews: some View {
        CustomsImageView()
            .previewLayout(.sizeThatFits)
    }
}

struct CircleImageView: View {
    
    @State var imageUrl : String
    var size: CGFloat
    
    var body: some View {
        
        if imageUrl.isEmpty{
            Rectangle()
                .frame(width: size, height: size, alignment: .center)
                .clipShape(Circle())
                .foregroundColor(Color(.grayAppColor2))
        }else{
            Image(imageUrl)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size, alignment: .center)
                .clipShape(Circle())
        }
        
    }
}

struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView(imageUrl: "", size: 80)
            .previewLayout(.sizeThatFits)
    }
}


struct DualUIImage: View {
    var largeImageUrl :String
    var largeImageSize: CGFloat
    var smallImageUrl : String
    var smallImageSize: CGFloat
    var borderWith : CGFloat
    var borderColor : String
    var largeImageOpacity : Double = 1
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            
            //Border
            ZStack {
                Circle()
                    .strokeBorder(Color(borderColor),lineWidth: self.borderWith)
                    .frame(width: largeImageSize*1.05, height: largeImageSize*1.05)
                    .foregroundColor(Color(borderColor))
                
                CircleImageView(imageUrl: largeImageUrl, size: largeImageSize)
                    .opacity(largeImageOpacity)
            }
            
            
            Image(smallImageUrl)
                .resizable()
                .frame(width: smallImageSize, height: smallImageSize)
                .foregroundColor(.green)
            
            
        }
        
    }
}

struct DualUIImage_Previews: PreviewProvider {
    static var previews: some View {
        DualUIImage(largeImageUrl : AssetsManager.iconsName.woman1.value(), largeImageSize: 100, smallImageUrl : AssetsManager.iconsName.accept.value(), smallImageSize: 35,  borderWith: 3, borderColor : ColorManager.ConfigColorsEnum.primaryColor.nameId())
            .previewLayout(.sizeThatFits)
    }
}

struct RoundImageView: View {
    
    var imageUrl : String
    var size: CGFloat
    
    var body: some View {
        
        Image(imageUrl)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size, height: size, alignment: .center)
            .clipShape(Circle())
        
        
    }
}

struct RoundImageView_Previews: PreviewProvider {
    static var previews: some View {
        RoundImageView(imageUrl: AssetsManager.iconsName.man2.value(), size: 80)
            .previewLayout(.sizeThatFits)
    }
}

struct HorizontalImageOverlayListView: View {
    
    
    var dualImageList : [DualUIImage]
    var totalNumber : Int
    
    var body: some View {
        
        HStack{
            
            
            ForEach(0..<dualImageList.count) { i in
                
                if i != 0{
                    dualImageList[i]
                        .padding(.leading, -15)
                }else {
                    dualImageList[i]
                }
            }
            
            Text("+ \(totalNumber - (dualImageList.count))")
                .font(.system(size: 12))
                .lineLimit(1)
                .frame(width: 20)
            
        }
    }
}

struct HorizontalImageOverlayListView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        var dual1 = DualUIImage(largeImageUrl : AssetsManager.iconsName.woman1.value(), largeImageSize: 35, smallImageUrl : AssetsManager.iconsName.accept.value(), smallImageSize: 14,  borderWith: 3, borderColor : ColorManager.ConfigColorsEnum.primaryColor.nameId())
        
        var dual2 = DualUIImage(largeImageUrl : AssetsManager.iconsName.woman2.value(), largeImageSize: 35, smallImageUrl : "", smallImageSize: 14,  borderWith: 0, borderColor : ColorManager.ConfigColorsEnum.primaryColor.nameId())
        
        var dual3 = DualUIImage(largeImageUrl : AssetsManager.iconsName.man1.value(), largeImageSize: 35, smallImageUrl : AssetsManager.iconsName.accept.value(), smallImageSize: 14,  borderWith: 3, borderColor : ColorManager.ConfigColorsEnum.primaryColor.nameId())
        
        var dual4 = DualUIImage(largeImageUrl : AssetsManager.iconsName.man2.value(), largeImageSize: 35, smallImageUrl : AssetsManager.iconsName.accept.value(), smallImageSize: 14,  borderWith: 3, borderColor : ColorManager.ConfigColorsEnum.primaryColor.nameId())
        
        var dual5 = DualUIImage(largeImageUrl : AssetsManager.iconsName.woman3.value(), largeImageSize: 35, smallImageUrl : "", smallImageSize: 14,  borderWith: 0, borderColor : ColorManager.ConfigColorsEnum.primaryColor.nameId())
        
        HorizontalImageOverlayListView(dualImageList: [dual1, dual2, dual3, dual4, dual5], totalNumber: 9)
            .previewLayout(.sizeThatFits)
    }
}
