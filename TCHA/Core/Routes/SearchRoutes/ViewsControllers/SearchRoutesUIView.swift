//
//  SearchRoutesUIView.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 29/04/2023.
//

import SwiftUI

struct SearchRoutesUIView: View {
    @State var hub = true
    @State var particular = false
    @State var confirmed = true
    @State var priceValue = 2000.0
    @State var isShowingDialog = false
    @State var largeImageUrl : String = ""
    @State var largeImageSize: CGFloat = 0.0
    @State var smallImageUrl : String = ""
    @State var smallImageSize: CGFloat = 0.0
    @State var borderWith : CGFloat = 0.0
    @State var borderColor : String = ""
    @State var name : String = ""
    @State var userCertified: Bool = true
    @State var rightTopLabel1 : String = ""
    @State var rightTopLabel2 : String = ""
    @State var routeModelList : [RouteModel] = []
    var typeRoute : String = TypeRoute.search.rawValue
    @State var arrivalName = "Paris"
    @State var departureName = "Yaoundé"
    @State var arrivalDate = Calendar.current.date(bySettingHour: 11, minute: 30, second: 0, of: Date()) ?? Date()
    @State var departureDate = Calendar.current.date(bySettingHour: 18, minute: 30, second: 0, of: Date()) ?? Date()
    @State var travelTime = 7.0
    
    
    var body: some View {
        
        VStack(spacing: 15) {
            HStack(spacing: 25){
                
                Image(AssetsManager.iconsName.search.value())
                
                VStack(alignment: .leading, spacing: 5){
                    Text("Yaoundé - Paris")
                        .font(.system(size: 12))
                        .foregroundColor(Color(ColorManager.ConfigColorsEnum.blackColor.nameId()))
                    
                    Text("26-30 aug -> 32kg")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 12, weight: .bold))
                    
                }
                
                Spacer()
                
                Button {
                    isShowingDialog = true
                }label: {
                    ZStack{
                        
                        Circle()
                            .frame(width: 35, height: 35)
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .foregroundColor(.white)
                        
                        Image(AssetsManager.iconsName.settings_sliders.value())
                            .renderingMode(.template)
                            .accentColor(Color(ColorManager.ConfigColorsEnum.primaryColor.nameId()))
                        
                    }
                }.sheet(isPresented: $isShowingDialog) {
                    PopupsFiltersUIViews(inHubValue: $hub, particularValue: $particular, confirmedValue: $confirmed, priceValue: $priceValue)
                }
                
            }.padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
            
            List(0 ..< 7) { item in
                
                RoundedRoutesView(largeImageUrl: $largeImageUrl, largeImageSize: $largeImageSize, smallImageUrl: $smallImageUrl, smallImageSize: $smallImageSize, borderWith: $borderWith, borderColor: $borderColor, name: $name, arrivalName: $arrivalName, departureName: $departureName, userCertified: $userCertified, rightTopLabel1: $rightTopLabel1, rightTopLabel2: $rightTopLabel2, arrivalDate: $arrivalDate, departureDate: $departureDate, travelTime: $travelTime, typeRoute: typeRoute)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
                
            }.listStyle(PlainListStyle())
            
            Spacer()
        }
        
    }
    
    func generateFalseDatas() -> [RouteModel] {
        
        let userIds = ["user1", "user2", "user3", "user4", "user5"]
        let statuses = ["En attente", "En cours", "Terminé"]
        let arrivalNames = ["Paris", "Lyon", "Marseille", "Bordeaux", "Toulouse"]
        let departureNames = ["Nice", "Strasbourg", "Nantes", "Rennes", "Lille"]
        
        var routeModels = [RouteModel]()
        
        for _ in 1...10 {
            let randomIndex = Int(arc4random_uniform(UInt32(userIds.count)))
            let userId = userIds[randomIndex]
            let status = statuses[Int(arc4random_uniform(UInt32(statuses.count)))]
            let arrivalName = arrivalNames[Int(arc4random_uniform(UInt32(arrivalNames.count)))]
            let departureName = departureNames[Int(arc4random_uniform(UInt32(departureNames.count)))]
            let price = Double(arc4random_uniform(100))
            let nbKilo = Double(arc4random_uniform(100))
            let priceByKilo = price / nbKilo
            let arrivalDate = Date()
            let departureDate = Date()
            let travelTime = Double(arc4random_uniform(10))
            let views = Int64(arc4random_uniform(1000))
            
            let routeModel = RouteModel(userId: userId,
                                        status: status,
                                        arrivalName: arrivalName,
                                        departureName: departureName,
                                        price: price,
                                        nbKilo: nbKilo,
                                        priceByKilo: priceByKilo,
                                        arrivalDate: arrivalDate,
                                        departureDate: departureDate,
                                        travelTime: travelTime,
                                        views: views)
            
            routeModels.append(routeModel)
        }
        
        return routeModels
        
    }
    
}

struct SearchRoutesUIView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRoutesUIView(largeImageUrl: AssetsManager.iconsName.man2.value(), largeImageSize: 35, smallImageUrl: AssetsManager.iconsName.accept.value(), smallImageSize: 14, borderWith: 3, borderColor: ColorManager.ConfigColorsEnum.primaryColor.nameId(), name: "Edouard Test", userCertified: true, rightTopLabel1: "122.5", rightTopLabel2: "12.25", typeRoute: TypeRoute.search.rawValue)
    }
}

struct BookRouteUIView: View {
    
    @State var largeImageUrl : String = ""
    @State var largeImageSize: CGFloat = 0.0
    @State var smallImageUrl : String = ""
    @State var smallImageSize: CGFloat = 0.0
    @State var borderWith : CGFloat = 0.0
    @State var borderColor : String = ""
    @State var name : String = ""
    @State var userCertified: Bool = true
    @State var rightTopLabel1 : String = ""
    @State var rightTopLabel2 : String = ""
    var typeRoute : String = TypeRoute.search.rawValue
    @State var arrivalName = "Paris"
    @State var departureName = "Yaoundé"
    @State var arrivalDate = Calendar.current.date(bySettingHour: 11, minute: 30, second: 0, of: Date()) ?? Date()
    @State var departureDate = Calendar.current.date(bySettingHour: 18, minute: 30, second: 0, of: Date()) ?? Date()
    @State var travelTime = 7.0
    @State var bookingInfosPlaceHolderList : [String] = ["Nom complet du récepteur", "Numéro de CNI/passport", "Contact","Quel type de colis voulez-vous envoyer ? /n Exemple : Je transporte de la viande de bœuf bien emballé dans du papier aluminium et plastique"]
    @State var bookingInfosValues = ["", "", "",""]
    var inputTypeBooking : [InputTypeTcha] = [.text, .number, .number, .text]
    @State var numberOfKilos : Double = 0
    @State var unitKilosPrice : Double = 3.25
    @State var totalForKilos : Double = 0
    @State var total : Double = 0
    @State var serviceFees : Double = 0
    var fees : Double = 0.1
    @State var currentFieldSelected : Int? = nil
    
    var body: some View {
        
        ScrollView() {
            VStack(alignment: .leading, spacing: 15) {
                
                RoundedRoutesView(largeImageUrl: $largeImageUrl, largeImageSize: $largeImageSize, smallImageUrl: $smallImageUrl, smallImageSize: $smallImageSize, borderWith: $borderWith, borderColor: $borderColor, name: $name, arrivalName: $arrivalName, departureName: $departureName, userCertified: $userCertified, rightTopLabel1: $rightTopLabel1, rightTopLabel2: State<String>(initialValue: "\(unitKilosPrice)").projectedValue, arrivalDate: $arrivalDate, departureDate: $departureDate, travelTime: $travelTime, typeRoute: typeRoute)
                
                Text("Qui récupère le colis ?")
                    .font(.system(size: 12, weight: .bold))
                    .padding(.leading)
                
                setupBookingForm().padding(.top, 10)
                setupPricesViews().padding()
                
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        ZStack{
                            Text("Réserver")
                                .font(.system(size: 16, weight: .bold))
                                .padding(EdgeInsets(top: 12, leading: 30, bottom: 12, trailing: 30))
                        }.foregroundColor(.white)
                            .background(Color("primaryColor"))
                            .cornerRadius(20)
                    }
                    Spacer()
                }
                
            }
        }
    }
    
    @ViewBuilder
    func setupBookingForm()->some View {
        
        ManageFormUIView(fieldsCount: 4, placeHolderList: $bookingInfosPlaceHolderList, value: $bookingInfosValues, textSize:14, inputTypeList: inputTypeBooking, currentFieldSelected: $currentFieldSelected)
        
        HStack(spacing: 18) {
            Text("Kilos souhaités")
                .font(.system(size: 12, weight: .bold))
                .padding(.leading)
            
            Button(action: {
                numberOfKilos = (numberOfKilos <= 0) ? 0 : (numberOfKilos - 1)
                totalForKilos = (unitKilosPrice * numberOfKilos)
                serviceFees = totalForKilos * fees
                total = totalForKilos + serviceFees
            }) {
                Image(systemName: "minus.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.red)
                    .padding(.all, 4)
                    .background(Color.white)
                    .cornerRadius(4)
                    .shadow(color: .gray, radius: 4, x: 0, y: 0)
            }
            
            Text("\(numberOfKilos.stringValueWithoutMultipleDecimal()) Kg")
                .font(.system(size: 18, weight: .bold))
            
            
            Button(action: {
                numberOfKilos += 1
                totalForKilos = (unitKilosPrice * numberOfKilos)
                serviceFees = totalForKilos * fees
                total = totalForKilos + serviceFees
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(Color("primaryColor"))
                    .padding(.all, 4)
                    .background(Color.white)
                    .cornerRadius(4)
                    .shadow(color: .gray, radius: 4, x: 0, y: 0)
            }
        }
        
    }
    
    @ViewBuilder
    func setupPricesViews()->some View {
        
        VStack(alignment: .leading, spacing: 20){
            Text("DETAILS")
                .font(.system(size: 12, weight: .bold))
            HStack{
                Text("Total pour \(numberOfKilos.stringValueWithoutMultipleDecimal()) kg")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.gray)
                Spacer()
                Divider()
                Text("\(totalForKilos.stringValueWithoutMultipleDecimal(minimumFractionDigits: 2, maximumFractionDigits: 2)) £")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(Color("primaryColor"))
            }
            HStack{
                Text("Frais de services (10%)")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.gray)
                Spacer()
                Divider()
                Text("\(serviceFees.stringValueWithoutMultipleDecimal(minimumFractionDigits: 2, maximumFractionDigits: 2)) £")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(Color("primaryColor"))
                
            }
            Divider()
            
            HStack{
                Text("TOTAL")
                    .font(.system(size: 12, weight: .bold))
                Spacer()
                Divider()
                Text("\(total.stringValueWithoutMultipleDecimal(minimumFractionDigits: 2, maximumFractionDigits: 2)) £")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(Color("primaryColor"))
                
            }
        }
        
    }
    
}

struct BookRouteUIView_Previews: PreviewProvider {
    static var previews: some View {
        BookRouteUIView(largeImageUrl: AssetsManager.iconsName.man2.value(), largeImageSize: 35, smallImageUrl: AssetsManager.iconsName.accept.value(), smallImageSize: 14, borderWith: 3, borderColor: ColorManager.ConfigColorsEnum.primaryColor.nameId(), name: "Edouard Test", userCertified: true, rightTopLabel1: "122.5", rightTopLabel2: "12.25", typeRoute: TypeRoute.search.rawValue).previewLayout(.sizeThatFits)
    }
}
