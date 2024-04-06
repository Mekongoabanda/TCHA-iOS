//
//  AssetsManager.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 12/10/2022.
//

import Foundation
import UIKit

class AssetsManager {
    
    enum iconsName : String {
        
        case accept = "accept"
        case arroba = "arroba"
        case arrow_right_round = "arrow_right_round"
        case birthday_cake = "birthday_cake"
        case calendar = "calendar"
        case chat = "chat"
        case close_btn = "close_btn"
        case credit_card = "credit_card"
        case creditcard_colored = "creditcard_colored"
        case crying_smiley = "crying_smiley"
        case emoji = "emoji"
        case gear = "gear"
        case information = "information"
        case maps_icon = "maps_icon"
        case name = "name"
        case paper_plane = "paper_plane"
        case phone_call = "phone_call"
        case search = "search"
        case sendbis = "sendbis"
        case settings_sliders = "settings_sliders"
        case split = "split"
        case trajet = "trajet"
        case view = "view"
        case weight = "weight"
        case logo_tcha_vertical = "logo_tcha_vertical"
        case logo_tcha_horizontal = "logo_tcha_horizontal"
        case tcha_cover = "tcha_cover"
        case hide = "hide"
        case show = "show"
        case password_ic = "password_ic"
        case agreement = "agreement"
        case earth_product_icon = "earth_product_icon"
        case man1 = "man1"
        case man2 = "man2"
        case woman1 = "woman1"
        case woman2 = "woman2"
        case woman3 = "woman3"
        case picarb = "picarb"
        case passport = "passport"
        case logout = "logout"
        case ac_bb = "ac_bb"
        case ac_senior = "ac_senior"
        case denise = "denise"
        case edith = "edith"
        case edu = "edu"
        case frederic = "frederic"
        case frederic_bis = "frederic_bis"
        case fustel = "fustel"
        case gaby = "gaby"
        case nadine = "nadine"
        
        func value() -> String { return self.rawValue}
       
    }
    
    //get UIMAGE of icon asset
    static var acceptIcon = UIImage(named: iconsName.accept.value())
    
    static var tchaCoverIcon = UIImage(named: iconsName.tcha_cover.value())
    static var arrobaIcon = UIImage(named: iconsName.arroba.value())
    static var arrow_right_round = UIImage(named: iconsName.arrow_right_round.value())
    static var birthday_cake = UIImage(named: iconsName.birthday_cake.value())
    static var calendar = UIImage(named: iconsName.calendar.value())
    static var chat = UIImage(named: iconsName.chat.value())
    static var close_btn = UIImage(named: iconsName.close_btn.value())
    static var credit_card = UIImage(named: iconsName.credit_card.value())
    static var creditcard_colored = UIImage(named: iconsName.creditcard_colored.value())
    static var crying_smiley = UIImage(named: iconsName.crying_smiley.value())
    static var emoji = UIImage(named: iconsName.emoji.value())
    static var gear = UIImage(named: iconsName.gear.value())
    static var information = UIImage(named: iconsName.information.value())
    static var maps_icon = UIImage(named: iconsName.maps_icon.value())
    static var name = UIImage(named: iconsName.name.value())
    static var paper_plane = UIImage(named: iconsName.paper_plane.value())
    static var phone_call = UIImage(named: iconsName.phone_call.value())
    static var search = UIImage(named: iconsName.search.value())
    static var sendbis = UIImage(named: iconsName.sendbis.value())
    static var settings_sliders = UIImage(named: iconsName.settings_sliders.value())
    static var split = UIImage(named: iconsName.split.value())
    static var trajet = UIImage(named: iconsName.trajet.value())
    static var view = UIImage(named: iconsName.view.value())
    static var weight = UIImage(named: iconsName.weight.value())
    static var logo_tcha_vertical = UIImage(named: iconsName.logo_tcha_vertical.value())
    static var logo_tcha_horizontal = UIImage(named: iconsName.logo_tcha_horizontal.value())
    static var hide = UIImage(named: iconsName.hide.value())
    static var show = UIImage(named: iconsName.show.value())
    static var password_ic = UIImage(named: iconsName.password_ic.value())
    static var agreement = UIImage(named: iconsName.agreement.value())
    static var earth_product_icon = UIImage(named: iconsName.earth_product_icon.value())
    static var man1 = UIImage(named: iconsName.man1.value())
    static var man2 = UIImage(named: iconsName.man2.value())
    static var woman1 = UIImage(named: iconsName.woman1.value())
    static var woman2 = UIImage(named: iconsName.woman2.value())
    static var woman3 = UIImage(named: iconsName.woman3.value())
    static var picarb = UIImage(named: iconsName.picarb.value())
    static var passport = UIImage(named: iconsName.passport.value())
    
}
