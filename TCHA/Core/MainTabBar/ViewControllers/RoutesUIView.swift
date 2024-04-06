//
//  RoutesUIView.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 29/01/2023.
//

import SwiftUI

// TODO : MAKE A CUSTOM ROUNDED BUTTON TO REDUCE A CODE

struct RoutesUIView: View {
    
    @State var anyRoutes = true
    @State var typeRoute = TypeRoute.bookingSideCustomer.rawValue
    
    var body: some View {
        ZStack{
            
            VStack {
                
                ScrollView(.horizontal){
                    
                    
                    HStack(spacing : 15) {
                        
                        Button("Réservations") {
                            
                            
                        }.padding(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
                            .foregroundColor(.white)
                            .font(Font.system(size: 18, weight: .bold))
                            .background(Color(ColorManager.ConfigColorsEnum.primaryColor.nameId()))
                            .cornerRadius(25)
                        
                        Button("En cours") {
                            
                            
                        }.padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                            .foregroundColor(.black)
                            .font(Font.system(size: 18, weight: .bold))
                            .background(Color(ColorManager.ConfigColorsEnum.grayAppColor2.nameId()))
                            .cornerRadius(25)
                        
                        Button("A venir") {
                            
                            
                        }.padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                            .foregroundColor(.black)
                            .font(Font.system(size: 18, weight: .bold))
                            .background(Color(ColorManager.ConfigColorsEnum.grayAppColor2.nameId()))
                            .cornerRadius(25)
                        
                        Button("Archivés") {
                            
                            
                        }.padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                            .foregroundColor(.black)
                            .font(Font.system(size: 18, weight: .bold))
                            .background(Color(ColorManager.ConfigColorsEnum.grayAppColor2.nameId()))
                            .cornerRadius(25)
                    }
                }.padding(EdgeInsets(top: 20, leading: 10, bottom: 30, trailing: 10))
                
                Spacer()
                
            }
            
            if anyRoutes {
                
                Text("AUCUN TRAJET EN COURS")
                    .bold()
                    .padding(.top, 40)
                    .font(Font.system(size: 25))
                
                Spacer()
            }
            
        }
    }
}

struct RoutesUIView_Previews: PreviewProvider {
    static var previews: some View {
        RoutesUIView()
    }
}
