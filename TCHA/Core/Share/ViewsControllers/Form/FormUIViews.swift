//
//  FormUIViews.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 05/03/2023.
//

import SwiftUI

struct FormUIViews: View {
    
    @State var currentStep = 1
    @State var title = "Informations du voyage"
    @State var travelInfoPlaceHolderList : [String] = ["Ville de départ", "Ville d'arrivée", "Date de départ","Date d'arrivée", "Heure de départ", "Heure d'arrivée" ,"Compagnie de transport"]
    @State var kilosTchaPlaceHolder : [String] = ["Nombre de kilos disponibles", "Prix/Kilo","Type de colis accepté"]
    @State var documentsInformations : [String] = ["Numéro de passport","Date de fin de validité"]
    var inputTypeTravelInfos : [InputTypeTcha] = [.text, .text, .date, .date, .time, .time, .text]
    var inputTypeKilosTcha : [InputTypeTcha] = [.number, .number, .text]
    var inputTypeDocsInfos : [InputTypeTcha] = [.number, .date]
    @State var documentsInformationsValues : [String] = ["", ""]
    @State var travelInfosValues = ["", "", "","", "", "" ,""]
    @State var kilosTchaValues = ["", "", ""]
    @State var autoAcceptationValue = false
    @State var betweenParticularValue = false
    @State var inHUBValue = false
    @State var passportUrl = ""
    @State var ticketUrl = ""
    @State var activeColorStep = ColorManager.ConfigColorsEnum.primaryColor.nameId()
    @State var inActiveColorStep = ColorManager.ConfigColorsEnum.grayAppColor2.nameId()
    @StateObject var datePickerViewModel : DatePickerViewModel = DatePickerViewModel()
    @State var currentFieldSelected : Int? = nil
    
    var body: some View {
        
        ZStack {
            VStack {
                headerView()
                ScrollView{
                    Spacer()
                    formView()
                }
                Spacer()
                footerView()
            }
            datePickerView()
        }
    }
    
    @ViewBuilder
    func headerView() -> some View{
        Text(self.title.uppercased())
            .bold()
            .padding(.top, 40)
            .font(Font.system(size: 20))
        
        
        HStack {
            ForEach(1..<5) { index in
                if(currentStep == index) {
                    StepCircleButton(buttonColor: $activeColorStep, textColor: ColorManager.ConfigColorsEnum.whiteColor.nameId(), number: index)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                }else {
                    StepCircleButton(buttonColor: $inActiveColorStep, textColor: ColorManager.ConfigColorsEnum.blackColor.nameId(), number: index)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                }
            }
        }.padding(.top, 25)
    }
    @ViewBuilder
    func formView() -> some View{
        if currentStep == 1 {
            
            ManageFormUIView(fieldsCount: 7, placeHolderList: $travelInfoPlaceHolderList, value: $travelInfosValues, inputTypeList: inputTypeTravelInfos, datePickerViewModel: datePickerViewModel, currentFieldSelected: $currentFieldSelected)
        }else if currentStep == 2 {
            
            VStack {
                ManageFormUIView(fieldsCount: 3, placeHolderList: $kilosTchaPlaceHolder, value: $kilosTchaValues, inputTypeList: inputTypeKilosTcha, currentFieldSelected: $currentFieldSelected)
                
                SwitchFormView(title: "Acceptation automatique", active: $autoAcceptationValue).padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 10))
                Spacer()
            }.padding(.top, 30)
            
        }else if currentStep == 3 {
            
            VStack {
                SwitchFormView(title: "Entre particuliers", active: $betweenParticularValue)
                SwitchFormView(title: "En HUB", active: $inHUBValue).padding(.top, 20)
                Spacer()
            }.padding(EdgeInsets(top: 40, leading: 15, bottom: 0, trailing: 10))
            
            
        }else if currentStep == 4 {
            VStack {
                photoPickImage(title1: "Passport", title2: "Billet d'avion").padding(.top, 15).padding(EdgeInsets(top: 30, leading: 15, bottom: 0, trailing: 10))
                    .padding(.bottom, 30)
                ManageFormUIView(fieldsCount: 2, placeHolderList: $documentsInformations, value: $documentsInformationsValues, inputTypeList: inputTypeDocsInfos, datePickerViewModel: datePickerViewModel, currentFieldSelected: $currentFieldSelected)
                Spacer()
            }
            
        }
    }
    @ViewBuilder
    func footerView() -> some View{
        HStack(spacing : 30) {
            
            Button("Précedent") {
                print(self.travelInfosValues)
                print(self.kilosTchaValues)
                if currentStep > 1 {
                    currentStep = currentStep - 1
                    
                    if currentStep == 1 {
                        self.title = "Informations du voyage"
                    }else if currentStep == 2 {
                        self.title = "Les kilos à << TCHA >>"
                    }else if currentStep == 3 {
                        self.title = "Option de retrait"
                    }else if currentStep == 4 {
                        self.title = "Documents de voyage"
                    }
                }
                
            }.padding(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
                .foregroundColor(.black)
                .font(Font.system(size: 25, weight: .bold))
                .background(Color(ColorManager.ConfigColorsEnum.grayAppColor.nameId()))
                .cornerRadius(25)
            
            Button("Suivant") {
                print(self.travelInfosValues)
                print(self.kilosTchaValues)
                if currentStep < 4 {
                    currentStep = currentStep + 1
                    
                    if currentStep == 1 {
                        self.title = "Informations du voyage"
                    }else if currentStep == 2 {
                        self.title = "Les kilos à << TCHA >>"
                    }else if currentStep == 3 {
                        self.title = "Option de retrait"
                    }else if currentStep == 4 {
                        self.title = "Documents de voyage"
                    }
                }
            }.padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                .foregroundColor(.white)
                .font(Font.system(size: 25, weight: .bold))
                .background(Color(ColorManager.ConfigColorsEnum.primaryColor.nameId()))
                .cornerRadius(25)
        }
    }
    @ViewBuilder
    func datePickerView()-> some View{
        VStack(){
            Spacer()
            if datePickerViewModel.showPicker {
                DatePickerSwiftUI(
                    datePickerViewModel: datePickerViewModel,
                    cancelAction: {datePickerViewModel.toggleVisibility()},
                    confirmAction: {
                        if let fieldIndex = currentFieldSelected{
                            switch (currentStep){
                            case 1 : travelInfosValues[fieldIndex] = datePickerViewModel.stringDate()
                                break
                            case 4: documentsInformationsValues[fieldIndex] = datePickerViewModel.stringDate()
                                break
                            default: break
                            }
                        }
                        datePickerViewModel.toggleVisibility()
                        
                    })
            }
        }
    }
    
}

struct FormUIViews_Previews: PreviewProvider {
    static var previews: some View {
        FormUIViews()
    }
}

//--------------------------------------------------

struct ManageFormUIView: View {
    
    var fieldsCount : Int
    @Binding var placeHolderList : [String]
    @Binding var value : [String]
    var textSize : CGFloat = 18
    var inputTypeList: [InputTypeTcha]
    @StateObject var datePickerViewModel : DatePickerViewModel = DatePickerViewModel()
    @Binding var currentFieldSelected : Int?
    
    @ViewBuilder
    var body: some View {
        
        VStack {
            
            ForEach(0..<fieldsCount) { index in
                
                FieldForm(placeHolder: placeHolderList[index], value: $value[index], textSize: textSize, title: placeHolderList[index], inputType: inputTypeList[index])
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 10, trailing: 15))
                    .onTapGesture {
                        if inputTypeList[index] == .date || inputTypeList[index] == .time {
                            self.datePickerViewModel.modifyAllValues(title: placeHolderList[index], limitDate: Date()..., inputType: inputTypeList[index], showPicker: true)
                            currentFieldSelected = index
                            
                        }
                    }
            }
            
            
        }
    }
}


struct ManageFormUIView_Previews: PreviewProvider {
    static var previews: some View {
        let placeHolder = State<[String]>(initialValue: ["Ville de départ", "Ville d'arrivée", "Date de départ","Date d'arrivée", "Heure de départ", "Heure d'arrivée" ,"Compagnie de transport"])
        let value = State<[String]>(initialValue: ["", "", "","", "", "" ,""])
        let currentFieldSelected = State<Int?>(initialValue: nil).projectedValue
        
        ManageFormUIView(fieldsCount: placeHolder.projectedValue.count, placeHolderList: placeHolder.projectedValue, value: value.projectedValue, inputTypeList: [.text, .text, .date, .date, .time, .time, .text], currentFieldSelected: currentFieldSelected)
    }
}


//--------------------------------------------------
