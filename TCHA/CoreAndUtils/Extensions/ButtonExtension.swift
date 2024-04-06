//
//  ButtonExtension.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 16/10/2022.
//

import Foundation
import UIKit

extension UIButton {
    
    //ombre pour UIView
    func shadow(shadowColor : UIColor, shadowOpacity : Float, shadowOffset : CGSize, shadowRadius : CGFloat){
        
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
    }
    
    //radius for kind of corner:
    // - corners : [.layerMinXMaxYCorner, .layerMaxXMaxYCorner] -> bottomLeft and bottomRight
    // - corners : [.layerMinXMinYCorner, .layerMaxXMinYCorner] -> topLeft and topRight
    func customCornerRadius(_ corners: CACornerMask, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
           self.layer.maskedCorners = corners
           self.layer.cornerRadius = radius
           self.layer.borderWidth = borderWidth
           self.layer.borderColor = borderColor.cgColor
        
       }
}
