//
//  RoutesUICustomViews.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 29/04/2023.
//

import SwiftUI

enum TypeRoute : String {
    
    case search = "search"
    case userRoutes = "userRoutes"
    case bookingSideCustomer = "bookingSideCustomer"
    case bookingSideAdmin = "bookingSideAdmin"
    case bookingByClientSideAdmin = "bookingByClientSideAdmin"
}

enum RoutesSteps : String {
    
    case booking = "booking"
    case inProgress = "inProgress"
    case upComing = "coming"
    case archived = "archived"
}

struct RoutesUICustomViews: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RoutesUICustomViews_Previews: PreviewProvider {
    static var previews: some View {
        RoutesUICustomViews()
    }
}

struct RoutesIconAndTextUIView: View {
    @State var departure : String
    @State var arrival : String
    var typeRoute = TypeRoute.search.rawValue
    var heightRouteIcon = 50.0
    var widthtRouteIcon = 10.0
    
    init(departure: String, arrival: String, typeRoute: String = TypeRoute.search.rawValue) {
        self.departure = departure
        self.arrival = arrival
        self.typeRoute = typeRoute
        if typeRoute == TypeRoute.search.rawValue {
            self.heightRouteIcon = 83
            self.widthtRouteIcon = 12
        }else {
            self.heightRouteIcon = 50
            self.widthtRouteIcon = 10
        }
    }
    
    var body: some View {
        
        HStack{
            
            VStack(alignment: .leading){
                Text(departure)
                    .font(.system(size: 12, weight: .bold))
                
                if typeRoute == TypeRoute.search.rawValue {
                    Spacer()
                    Text("07h31")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color.gray)
                }
                
                Spacer()
                Text(arrival)
                    .font(.system(size: 12, weight: .bold))
            }.frame(height: self.heightRouteIcon)
            
            Image(AssetsManager.iconsName.trajet.value())
                .resizable()
                .frame(width: widthtRouteIcon,height: heightRouteIcon)
                .padding(.leading, 10)
            
            VStack(alignment: .leading){
                Text("Paris")
                    .font(.system(size: 12, weight: .bold))
                
                if typeRoute == TypeRoute.search.rawValue {
                    Spacer()
                    Text("12,55kg")
                        .font(.system(size: 12, weight: .bold))
                }
                
                Spacer()
                Text("Yaoundé")
                    .font(.system(size: 12, weight: .bold))
            }
            .frame(height: self.heightRouteIcon)
            .padding(.leading, 10)
        }
    }
}

struct RoutesIconAndTextUIView_Previews: PreviewProvider {
    static var previews: some View {
        RoutesIconAndTextUIView(departure: "06h30", arrival: "14h01")
            .previewLayout(.sizeThatFits)
    }
}


struct RoundedRoutesView: View {
    //user
    @Binding var largeImageUrl : String
    @Binding var largeImageSize: CGFloat
    @Binding var smallImageUrl : String
    @Binding var smallImageSize: CGFloat
    @Binding var borderWith : CGFloat
    @Binding var borderColor : String
    @Binding var name : String
    //travelInfos
    @Binding var arrivalName : String
    @Binding var departureName : String
    @Binding var userCertified: Bool
    @Binding var rightTopLabel1 : String
    @Binding var rightTopLabel2 : String
    @Binding var arrivalDate : Date
    @Binding var departureDate : Date
    @Binding var travelTime : Double
    @State var typeRoute : String
    @State var customertDualImageList : [DualUIImage] = []
    @State var totalReservation : Int = 10 //ste To 0, i put 10 just for test
    @State var packageDescription : String = "hdehdeudhehdeh ded hedhe dh eydbeyd ey hb cdyhcs d bcshk dbcs hhdehdeudhe hdeh ded hedhe dh eydbeyd ey hb cdyhcs d bcshk dbcs h bcshk dbcs hhdehdeudhe hdeh ded hedhe dh eydbeyd ey hb cdyhcs d bcshk dbcs h"
    @State var receiverName : String = "TestName"
    @State var receiverIsCertified : Bool = false
    @State var receiverImageUrl : String = AssetsManager.iconsName.gaby.value()
    @State var currentTab : String = RoutesSteps.inProgress.rawValue
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 18){
            
            HStack(alignment: .top) { //----- STEP 1
                
                RoutesIconAndTextUIView(departure: departureName, arrival: arrivalName, typeRoute: typeRoute)
                Spacer()
                
                VStack(spacing: 10) {
                    Text("\(rightTopLabel1) £")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(ColorManager.ConfigColorsEnum.primaryColor.nameId()))
                    
                    Text("\(rightTopLabel2)£/kg")
                        .font(.system(size: 12, weight: .bold))
                    
                }.padding(.trailing, 10)
                
            }
            
            HStack (spacing : 5){ // ---- STEP 2
                
                if typeRoute == TypeRoute.bookingSideAdmin.rawValue && currentTab == RoutesSteps.booking.rawValue {
                    
                    let customertDualImageListt = dualImageList()
                    HorizontalImageOverlayListView(dualImageList: customertDualImageListt, totalNumber: totalReservation)
                    
                }else {
                    
                    if userCertified {
                        DualUIImage(largeImageUrl: self.largeImageUrl, largeImageSize: self.largeImageSize, smallImageUrl: self.smallImageUrl, smallImageSize: self.smallImageSize, borderWith: self.borderWith, borderColor: self.borderColor)
                    }else {
                        DualUIImage(largeImageUrl: self.largeImageUrl, largeImageSize: self.largeImageSize, smallImageUrl: smallImageUrl, smallImageSize: 0, borderWith: 0, borderColor: borderColor)
                    }
                    Text(name)
                        .font(.system(size: 12, weight: .bold))
                }
                Spacer()
                
                Text("Départ: \(departureDate.getStringDateWithPlaceHolder())")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(Color(ColorManager.ConfigColorsEnum.grayAppColor.nameId()))
                
            }.padding(.top, 10)
            
            //------ STEP 3
            if typeRoute == TypeRoute.bookingSideAdmin.rawValue && currentTab == RoutesSteps.booking.rawValue {
                
                HStack(spacing : 10) {
                    
                    Text("Kilos Réservés").font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(ColorManager.ConfigColorsEnum.blackColor.nameId()))
                    Text("50 Kilos").font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(ColorManager.ConfigColorsEnum.primaryColor.nameId()))
                }.padding(.top, 10)
                HStack(spacing : 10) {
                    
                    Text("Kilos Restants").font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(ColorManager.ConfigColorsEnum.blackColor.nameId()))
                    Text("11 kilos").font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(ColorManager.ConfigColorsEnum.primaryColor.nameId()))
                }
                HStack(spacing : 10) {
                    
                    Text("Gains Possible").font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(ColorManager.ConfigColorsEnum.blackColor.nameId()))
                    Text("267 $").font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(ColorManager.ConfigColorsEnum.primaryColor.nameId()))
                }
                
                HStack(alignment: .center, spacing : 60) {
                    Spacer()
                    Button(action: {
                        // Action à exécuter lorsque le bouton est pressé
                    }) {
                        Image(systemName: "info.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color(ColorManager.ConfigColorsEnum.grayAppColor.nameId()), radius: 4, x: 2, y: 2)
                        
                    }.modifier(BouncingAnimationModifier(scale: 1.3))
                    
                    Button(action: {
                        // Action à exécuter lorsque le bouton est pressé
                    }) {
                        Image("close")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color(ColorManager.ConfigColorsEnum.grayAppColor.nameId()), radius: 4, x: 2, y: 2)
                    }
                    
                    Spacer()
                }.padding(.top, 20)
                
            }else if typeRoute == TypeRoute.bookingByClientSideAdmin.rawValue || typeRoute == TypeRoute.bookingSideCustomer.rawValue {
                
                HStack {
                    Image(systemName: "info.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.gray)
                    DualImageWithTitleMessageTime(largeImageUrl: "", largeImageSize: 0, smallImageUrl: "", smallImageSize: 0, borderWith: 0, borderColor: "", message: packageDescription, name: "Informations sur le/les colis :", time: "", userCertified: false, titleTextSize: 12, messageTextSize: 12, largeImageOpacity : 1)
                        .padding(.trailing, 25)
                }
                
                DualImageWithTitleMessageTime(largeImageUrl: receiverImageUrl, largeImageSize: 35, smallImageUrl: "", smallImageSize: 0, borderWith: 0, borderColor: "", message: "Après que ses documents soient validés auprès du livreur.", name: "\(receiverName) se chargera de récupérer votre colis", time: "", userCertified: receiverIsCertified, titleTextSize: 12, messageTextSize: 12)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 25))
                
                HStack(spacing : 10) {
                    
                    Text("Prix total").font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(ColorManager.ConfigColorsEnum.blackColor.nameId()))
                    Text("122,5 $").font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(ColorManager.ConfigColorsEnum.primaryColor.nameId()))
                }
                HStack(spacing : 10) {
                    
                    Text("Nombre de kilos sur ce trajet:").font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(ColorManager.ConfigColorsEnum.blackColor.nameId()))
                    Text("12,2 kg").font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(ColorManager.ConfigColorsEnum.primaryColor.nameId()))
                }
                
                setupBottomButtonsView().padding(.top, 20)
                
            }else if typeRoute == TypeRoute.bookingSideAdmin.rawValue && currentTab == RoutesSteps.inProgress.rawValue {
                
                HStack(alignment: .center) {
                    Spacer()
                    TimeLineUIViews().padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                    Spacer()
                }
                
                Text("Votre colis se trouve actuellement à Etape 2, hdehdeudhehdeh ded hedhe dh eydbeyd ey hb cdyhcs d bcshk dbcs hhdehdeudhe hdeh ded hedhe dh eydbeyd ey hb cdyhcs d bcshk dbcs h bcshk dbcs hhdehdeudhe hdeh ded hedhe dh eydbeyd ey hb cdyhcs d bcshk dbcs h").font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color(ColorManager.ConfigColorsEnum.blackColor.nameId()))
                
                DualImageWithTitleMessageTime(largeImageUrl: receiverImageUrl, largeImageSize: 35, smallImageUrl: "", smallImageSize: 0, borderWith: 0, borderColor: "", message: "Après que ses documents soient validés auprès du livreur.", name: "\(receiverName) se chargera de récupérer votre colis", time: "", userCertified: receiverIsCertified, titleTextSize: 12, messageTextSize: 12)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 25))
                
                HStack(spacing : 10) {
                    
                    Text("Prix total").font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(ColorManager.ConfigColorsEnum.blackColor.nameId()))
                    Text("122,5 $").font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(ColorManager.ConfigColorsEnum.primaryColor.nameId()))
                }
                HStack(spacing : 10) {
                    
                    Text("Nombre de kilos sur ce trajet:").font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(ColorManager.ConfigColorsEnum.blackColor.nameId()))
                    Text("12,2 kg").font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(ColorManager.ConfigColorsEnum.primaryColor.nameId()))
                }
            }
            
        }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
    }
    
    @ViewBuilder
    func setupBottomButtonsView()-> some View{
        
        HStack(spacing: 62){
            Spacer()
            Button {
                
            } label: {
                Image("close")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color(ColorManager.ConfigColorsEnum.grayAppColor.nameId()), radius: 4, x: 2, y: 2)
            }
            if typeRoute == TypeRoute.bookingByClientSideAdmin.rawValue {
                Button {
                    
                } label: {
                    Image("check")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color(ColorManager.ConfigColorsEnum.grayAppColor.nameId()), radius: 4, x: 2, y: 2)
                }
            }
            

            Spacer()
            
        }
        
    }
    
    func dualImageList() -> [DualUIImage] {
        
        var dual1 = duo()
        
        var dual2 = DualUIImage(largeImageUrl : AssetsManager.iconsName.ac_senior.value(), largeImageSize: 35, smallImageUrl : "", smallImageSize: 14,  borderWith: 0, borderColor : ColorManager.ConfigColorsEnum.primaryColor.nameId())
        
        var dual3 = DualUIImage(largeImageUrl : AssetsManager.iconsName.edith.value(), largeImageSize: 35, smallImageUrl : AssetsManager.iconsName.accept.value(), smallImageSize: 14,  borderWith: 3, borderColor : ColorManager.ConfigColorsEnum.primaryColor.nameId())
        
        var dual4 = DualUIImage(largeImageUrl : AssetsManager.iconsName.frederic_bis.value(), largeImageSize: 35, smallImageUrl : AssetsManager.iconsName.accept.value(), smallImageSize: 14,  borderWith: 3, borderColor : ColorManager.ConfigColorsEnum.primaryColor.nameId())
        
        var dual5 = DualUIImage(largeImageUrl : AssetsManager.iconsName.nadine.value(), largeImageSize: 35, smallImageUrl : "", smallImageSize: 14,  borderWith: 0, borderColor : ColorManager.ConfigColorsEnum.primaryColor.nameId())
        
        return [dual1, dual2, dual3, dual4, dual5]
    }
    
    /// TEST : WE CAN LOAD FIREBASE DATA AND AFTER RETURN THE CUSTOM IMAGE
    func duo() -> DualUIImage {
        return DualUIImage(largeImageUrl : AssetsManager.iconsName.woman1.value(), largeImageSize: 35, smallImageUrl : AssetsManager.iconsName.accept.value(), smallImageSize: 14,  borderWith: 3, borderColor : ColorManager.ConfigColorsEnum.primaryColor.nameId())
    }
    
}

struct RoundedRoutesView_Previews: PreviewProvider {
    static var previews: some View {
        
        let largeImageUrl = State<String>(initialValue: AssetsManager.iconsName.edu.value())
        let largeImageSize = State<CGFloat>(initialValue: 35)
        let smallImageUrl = State<String>(initialValue: AssetsManager.iconsName.accept.value())
        let smallImageSize = State<CGFloat>(initialValue: 14)
        let borderWith = State<CGFloat>(initialValue: 3)
        let borderColor = State<String>(initialValue: ColorManager.ConfigColorsEnum.primaryColor.nameId())
        let name = State<String>(initialValue: "Edouard Test")
        let arrivalName = State<String>(initialValue: "Paris")
        let departureName = State<String>(initialValue: "Yaoundé")
        let userCertified = State<Bool>(initialValue: true)
        let rightTopLabel1 = State<String>(initialValue: "122.5")
        let rightTopLabel2 = State<String>(initialValue: "12.25")
        let arrivalDate = State<Date>(initialValue: Calendar.current.date(bySettingHour: 11, minute: 30, second: 0, of: Date()) ?? Date())
        let departureDate = State<Date>(initialValue: Calendar.current.date(bySettingHour: 18, minute: 30, second: 0, of: Date()) ?? Date())
        let travelTime = State<Double>(initialValue: 7)
        
        RoundedRoutesView(largeImageUrl: largeImageUrl.projectedValue, largeImageSize: largeImageSize.projectedValue, smallImageUrl: smallImageUrl.projectedValue, smallImageSize: smallImageSize.projectedValue, borderWith: borderWith.projectedValue, borderColor: borderColor.projectedValue, name: name.projectedValue, arrivalName: arrivalName.projectedValue, departureName: departureName.projectedValue, userCertified: userCertified.projectedValue, rightTopLabel1: rightTopLabel1.projectedValue, rightTopLabel2: rightTopLabel2.projectedValue, arrivalDate: arrivalDate.projectedValue, departureDate: departureDate.projectedValue, travelTime: travelTime.projectedValue, typeRoute: TypeRoute.bookingSideAdmin.rawValue)
            .previewLayout(.sizeThatFits)
    }
    
    
}

struct RoundedRoutesViewList: View {
    @State var typeRoute : String
    var body: some View {
        
           Text("test list routes")
       
    }
    
    
}
struct RoundedRoutesViewList_Previews: PreviewProvider {
    static var previews: some View {
        
        RoundedRoutesViewList(typeRoute: TypeRoute.bookingSideCustomer.rawValue)
            .previewLayout(.sizeThatFits)
    }
    
    
}

//TimeLine whith Editable step
struct TimeLineUIViews: View {
    
    var circleSize : CGFloat = 22
    var rectangleSize : CGSize = CGSize(width: 80, height: 10)
    var stepNumber : Int = 4
    @State var stepNameList : [String] = ["Prise en charge", "Départ", "Arrivée", "Remise"]
    @State var stepsColorList : [Color] = [Color(ColorManager.primaryColor), Color(ColorManager.grayAppColor3), Color(ColorManager.grayAppColor3), Color(ColorManager.grayAppColor3)]
    @State var RectangleColorList : [Color] = [Color(ColorManager.grayAppColor3), Color(ColorManager.grayAppColor3), Color(ColorManager.grayAppColor3), Color(ColorManager.grayAppColor3)]
    @State var activeBounceOnStep : [Bool] = [true, false, false, false]
    @State var currentPhase : Int = 0
    
    
    var body: some View {
        
        ScrollView(.horizontal) {
       
            HStack{
                
                ForEach(0..<stepNameList.count) { i in
                    
                    VStack(alignment: .leading) {
                        
                        Text(stepNameList[i])
                            .font(.system(size: 10))
                        
                        HStack{
                            
                            if activeBounceOnStep[i] == true { //Si un cercle est activé à son index équivalent on active son anim
                                Circle()
                                    .frame(width: circleSize, height: circleSize)
                                    .foregroundColor(stepsColorList[i])
                                    .modifier(BouncingAnimationModifier(scale: 1.5))
                                    .zIndex(1)
                            }else {
                                Circle()
                                    .frame(width: circleSize, height: circleSize)
                                    .foregroundColor(stepsColorList[i])
                                    .zIndex(1)
                            }
                            //don't create rectangle after the last circle
                            if i != stepNameList.count-1 {
                                Rectangle().frame(width: rectangleSize.width, height: rectangleSize.height)
                                    .foregroundColor(RectangleColorList[i])
                                    .padding(EdgeInsets(top: 0, leading: -10, bottom: 0, trailing: -10))
                                    .zIndex(0)
                            }
                        }
                    }
                }
   
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 18, trailing: 0))
        }
    }
}

struct TimeLineUIViews_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineUIViews()
            .previewLayout(.sizeThatFits)
    }
}


struct PackageReceiverPopup: View {
    
    var body: some View {
        
        VStack{
            
            DualUIImage(largeImageUrl: "edu", largeImageSize: 40, smallImageUrl: "accept", smallImageSize: 15, borderWith: 2, borderColor: "primaryColor")
            
            HStack{
                
                VStack(alignment: .leading, spacing: 5){
                    Text("Nom personne").font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color(ColorManager.ConfigColorsEnum.blackColor.nameId()))
                    Text("Contact personne").font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color(ColorManager.ConfigColorsEnum.blackColor.nameId()))
                    Text("Numéro de CNI").font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color(ColorManager.ConfigColorsEnum.blackColor.nameId()))
                }
                Spacer()
                Image("cni_test")
                    .resizable()
                    .frame(width: 134, height: 67)
                    .cornerRadius(10.0)
                    .shadow(radius: 10)
                
            }.padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
        
        }.frame(width: 300, height: 150)
    }
}

struct PackageReceiverPopup_Previews: PreviewProvider {
    static var previews: some View {
        PackageReceiverPopup()
            .previewLayout(.sizeThatFits)
    }
}
