//
//  UIViewExtension.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 13/10/2022.
//

import Foundation
import UIKit

extension UIView {
    
    func connectCustomView(bundle : Bundle, nibName : String) {
        
        if let viewToAdd = bundle.loadNibNamed(nibName, owner: self, options: nil), let contentView = viewToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
    //ombre pour UIView
    func setShadow(shadowColor : UIColor, shadowOpacity : Float, shadowOffset : CGSize, shadowRadius : CGFloat){
        
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        
    }
    
    //radius for kind of corner:
    // - corners : [.layerMinXMaxYCorner, .layerMaxXMaxYCorner] -> bottomLeft and bottomRight
    // - corners : [.layerMinXMinYCorner, .layerMaxXMinYCorner] -> topLeft and topRight
    func roundCornersWithBorder(_ corners: CACornerMask, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        self.layer.maskedCorners = corners
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
    }
    
    func circleView(borderWith : CGFloat, borderColor : UIColor){
        self.clipsToBounds = true
        self.layer.borderWidth = borderWith
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = self.layer.bounds.width / 2
        
    }
}

