//
//  StepsUIViews.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 27/02/2023.
//

import SwiftUI

enum InputTypeTcha{
    case date
    case text
    case number
    case email
    case time
}

struct StepsUIViews: View {
    @State var hub = true
    @State var particular = false
    @State var confirmed = true
    @State var priceValue = 2000.0
    @State var isShowingDialog = false
    var body: some View {
        
        ZStack{
            
            Button("Afficher la popup") {
                isShowingDialog = true
                
            }.popover(isPresented: $isShowingDialog, attachmentAnchor: .point(.bottom), arrowEdge: .top) {
                
                PopupsFiltersUIViews(inHubValue: $hub,particularValue: $particular,confirmedValue: $confirmed, priceValue: $priceValue)
                    
            }
            
        }
        
        
        
    }
    
}


struct StepsUIViews_Previews: PreviewProvider {
    static var previews: some View {
        StepsUIViews()
    }
}

//-----------------------------

struct StepCircleButton: View {
    
    @Binding var buttonColor : String
    var textColor : String
    var number : Int
    
    var body: some View {
        
        ZStack(alignment: .center) {
            
            Circle()
                .foregroundColor(Color(buttonColor))
                .frame(width: 35, height: 35)
            Text("\(number)")
                .foregroundColor(Color(textColor))
                .bold()
        }
    }
    
    func editColor(color : String) {
        self.buttonColor = color
    }
}

struct StepCircleButton_Preview: PreviewProvider {
    static var previews: some View {
        let colorTest = State<String>(initialValue: ColorManager.ConfigColorsEnum.primaryColor.nameId())
        
        StepCircleButton(buttonColor: colorTest.projectedValue, textColor: ColorManager.ConfigColorsEnum.whiteColor.nameId(), number: 1)
            .previewLayout(.sizeThatFits)
    }
}

//----------------------------


//-----------------------------

struct FieldForm: View {
    
    var placeHolder : String
    @Binding var value : String
    var textSize : CGFloat = 18
    @State private var date = Date()
    var title: String = ""
    var inputType: InputTypeTcha
    
    var body: some View {
        
        VStack(alignment: .leading){
            if !title.isEmpty {
                Text(title)
                    .font(Font.system(size: 14))
                    .foregroundColor(.gray)
                    .padding(.bottom, 5)
            }
            TextField(placeHolder, text: $value)
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
                .font(Font.system(size: textSize, weight: .bold))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 2)
                    
                )
                .background(Color(ColorManager.ConfigColorsEnum.grayAppColor3.nameId()))
        }
        
    }
}

struct FieldForm_Preview: PreviewProvider {
    static var previews: some View {
        let value = State<String>(initialValue: "")
        FieldForm(placeHolder: "Ville de départ", value: value.projectedValue, title: "Ville de départ*", inputType: .date)
            .previewLayout(.sizeThatFits)
    }
}

//----------------------------


//-----------------------------

struct SwitchFormView: View {
    
    var title : String
    @Binding var active : Bool
    
    var body: some View {
        
        VStack(){
            
            Toggle(title, isOn: $active)
                .font(.custom("custom", size: 18))
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .animation(.easeInOut)
            
        }
    }
    
}

struct SwitchFormView_Preview: PreviewProvider {
    static var previews: some View {
        let active = State<Bool>(initialValue: true)
        SwitchFormView(title: "Entre particuliers", active: active.projectedValue)
            .previewLayout(.sizeThatFits)
    }
}

//----------------------------


//-----------------------------

struct photoPickImage: View {
    
    var title1, title2 : String
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 50){
            
            Image(AssetsManager.iconsName.passport.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 125, height: 125)
            
            HStack(spacing: 20) {
                
                RoundedRectangleWithTitle(title: self.title1)
                RoundedRectangleWithTitle(title: self.title2)
                
            }.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            
            
        }
    }
    
}

struct photoPickImage_Preview: PreviewProvider {
    static var previews: some View {
        photoPickImage(title1: "Passport", title2: "Billet d'avion")
            .previewLayout(.sizeThatFits)
    }
}

//----------------------------


//-----------------------------

struct RoundedRectangleWithTitle: View {
    
    var title : String
    
    var body: some View {
        
        VStack(spacing: 30) {
            
            ZStack(alignment: .center) {
                
                Rectangle()
                    .frame(height: 150)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1)
                        
                    )
                    .foregroundColor(Color(ColorManager.ConfigColorsEnum.grayAppColor3.nameId()))
                
                Text("Cliquez Ici")
                    .foregroundColor(Color.gray)
            }
            
            Text(title)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.black)
        }
    }
    
}

struct RoundedRectangleWithTitle_Preview: PreviewProvider {
    static var previews: some View {
        RoundedRectangleWithTitle(title: "Passport")
            .previewLayout(.sizeThatFits)
    }
}

//----------------------------
