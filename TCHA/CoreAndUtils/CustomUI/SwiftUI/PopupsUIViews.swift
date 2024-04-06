//
//  PopupsUIViews.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 28/04/2023.
//

import SwiftUI

struct PopupsFiltersUIViews: View {
    @Binding var inHubValue : Bool
    @Binding var particularValue : Bool
    @Binding var confirmedValue : Bool
    @State var resultsNumbers = 0
    //for slider
    var maxPrice = 5000.0
    @Binding var priceValue : Double
    @State private var isEditing = false
   
    var body: some View {
        
        VStack(alignment: .leading, spacing: 30){
            
            ZStack{
                Color(ColorManager.ConfigColorsEnum.primaryColor.nameId())
                Text("Filtres")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
            }.frame(height: 70)
            
            VStack(alignment: .leading, spacing: 18) {
                
                Text("Mode de retrait")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                
                Toggle("En HUB", isOn: $inHubValue)
                    .font(.custom("custom", size: 18))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .animation(.easeInOut)
                Toggle("Entre particuilers", isOn: $particularValue)
                    .font(.custom("custom", size: 18))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .animation(.easeInOut)
                
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
            VStack(alignment: .leading, spacing: 18) {
                
                Text("Type de voyageurs")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                
                Toggle("Confirmés", isOn: $confirmedValue)
                    .font(.custom("custom", size: 18))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .animation(.easeInOut)
                
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text("Prix")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                
                HStack{
                    Text(priceValue.stringValueWithoutMultipleDecimal())
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                    Text("\(maxPrice.stringValueWithoutMultipleDecimal() )+")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                }
                
                Slider(
                    value: $priceValue,
                            in: 0...maxPrice,
                            onEditingChanged: { editing in
                                isEditing = editing
                            }
                        ).accentColor(.green) // Changer la couleur de la barre en vert
                    .labelsHidden() // Masquer les labels de la valeur
                    .padding() // Ajouter du padding pour l'esthétique
                
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
            ZStack(alignment: .center){
                
                ZStack(){
                    Color(.gray)
                    Text("\(resultsNumbers) résultats")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                }.cornerRadius(15)
                .fixedSize(horizontal: true, vertical: false)
                .frame(height: 50)
                
            }.frame(maxWidth: .infinity)
            
            HStack(spacing : 30) {
                
                Button("RESET") {
                    inHubValue = false
                    particularValue = false
                    confirmedValue = false
                    priceValue = 0.0
                    
                }.padding(EdgeInsets(top: 8, leading: 25, bottom: 8, trailing: 25))
                    .foregroundColor(.black)
                    .font(Font.system(size: 25, weight: .bold))
                    .background(Color(ColorManager.ConfigColorsEnum.grayAppColor.nameId()))
                    .cornerRadius(25)
                
                Button("FILTRER") {
                    
                }.padding(EdgeInsets(top: 8, leading: 25, bottom: 8, trailing: 25))
                    .foregroundColor(.white)
                    .font(Font.system(size: 25, weight: .bold))
                    .background(Color(ColorManager.ConfigColorsEnum.primaryColor.nameId()))
                    .cornerRadius(25)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 20)
            
        }
        
    }
}

struct PopupsFiltersUIViews_Previews: PreviewProvider {
    static var previews: some View {
        let active = State<Bool>(initialValue: true)
        let particularValue = State<Bool>(initialValue: false)
        let confirmedValue = State<Bool>(initialValue: true)
        let priceValue = State<Double>(initialValue: 3000.0)
        
        PopupsFiltersUIViews(inHubValue: active.projectedValue,particularValue: particularValue.projectedValue, confirmedValue: confirmedValue.projectedValue, priceValue: priceValue.projectedValue ).previewLayout(.sizeThatFits)
    }
}

struct ProgressDialog: View {
    var title : String
    var message: String
    var positiveButtonText: String = "OK"
    var negativeButtonText: String = "Annuler"
    @State var activePositiveButton: Bool
    @State var activeNegativeButton: Bool
    @State var activeIcon: Bool
    @State var activeMessage: Bool
    @State var activeProgressView: Bool
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
        
        VStack{
            
            HStack {
                Text(title)
                    .fontWeight(.bold)
                Spacer()
            }.padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
            HStack(spacing: 30){
                progressCircle()
                iconAndText()
            }.padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
            
                buttonView()
        }
    }
    
    @ViewBuilder
    func buttonView() -> some View {
        HStack(spacing: 25){
            Spacer()
            if activeNegativeButton {
                Button(action: {}, label: {
                    Text(negativeButtonText)
                        .font(.system(size: 18, weight: .regular))
                    
                        .foregroundColor(.red)
                })
            }
            if activePositiveButton{
                Button(action: {}, label: {
                    Text(positiveButtonText)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(.primary))
                })
            }
        }.padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
    }
    
    @ViewBuilder
    func iconAndText() -> some View{
        if activeIcon{
            Image(.check)
                .resizable()
                .frame(width: 55, height: 55)
        }
        if activeMessage {
            Text(message)
                .font(.system(size: 12, weight: .regular))
        }
    }
    
    @ViewBuilder
    func progressCircle() -> some View {
        if activeProgressView{
            ZStack {
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(Color(.primary), style: StrokeStyle(lineWidth: 8.0, lineCap: .round))
                    .frame(width: 50, height: 50)
                    .rotationEffect(.degrees(-100))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: true))
                    .onAppear() {
                        self.progress = 1.0
                    }
            }.rotationEffect(.degrees(progress * 360)) // Rotation basée sur la progression
                .animation(Animation.linear(duration: 3.0).repeatForever(autoreverses: true)) // Animation de rotation
        }
    }
}

struct ProgressDialog_Previews: PreviewProvider {
    static var previews: some View {
        ProgressDialog(title: "Enregistrement", message: "Veuillez patienter pendant que nous enregistrons vos données", activePositiveButton: false, activeNegativeButton: false, activeIcon: false, activeMessage: true, activeProgressView: true).previewLayout(.sizeThatFits)
    }
}

