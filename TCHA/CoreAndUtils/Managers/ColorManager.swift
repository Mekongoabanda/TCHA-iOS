//
//  ColorManager.swift
//  WeMoney
//
//  Created by Yannick Edouard MEKONGO ABANDA on 12/10/2022.
//

import Foundation
import UIKit

class ColorManager {
    
    // MARK: - Config colors
    enum ConfigColorsEnum: String{
        case primaryColor = "#19AE5F"
        case secondaryColor = "#FFCC00"
        case whiteColor = "#FFFFFF"
        case blackColor = "#000000"
        case redBlood = "#F60000"
        case womanFashionCategory = "#F94E3C"
        case grayAppColor = "DDDDDD"
        case grayAppColor2 = "#F7F7F7"
        case grayAppColor3 = "#CCCCCC"

        //get the string value of color
        func value() -> String { return self.rawValue}
        func nameId() -> String {
            return String(describing: self)
        }
        
    }
    
    //MARK: - LOCAL COLORS
    // UIcolor of primary color
    static var primaryColor: UIColor = UIColor(hex: ConfigColorsEnum.primaryColor.value())
    static var secondaryColor: UIColor = UIColor(hex: ConfigColorsEnum.secondaryColor.value())
    static var whiteColor: UIColor = UIColor(hex: ConfigColorsEnum.whiteColor.value())
    static var redBlood: UIColor = UIColor(hex: ConfigColorsEnum.redBlood.value())
    static var womanFashionCategory: UIColor = UIColor(hex: ConfigColorsEnum.womanFashionCategory.value())
    static var blackColor: UIColor = UIColor(hex: ConfigColorsEnum.blackColor.value())
    static var grayAppColor: UIColor = UIColor(hex: ConfigColorsEnum.grayAppColor.value())
    static var grayAppColor2 : UIColor = UIColor(hex: ConfigColorsEnum.grayAppColor2.value())
    static var grayAppColor3 : UIColor = UIColor(hex: ConfigColorsEnum.grayAppColor3.value())
    


}
