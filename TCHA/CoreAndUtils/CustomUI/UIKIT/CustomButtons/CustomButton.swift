//
//  CustomButton.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 29/11/2022.
//

import Foundation
import UIKit

class CustomButton : UIButton {
    
    init(frame: CGRect, title : String , textColor : UIColor, isBold : Bool, textSize : CGFloat, cornerRadius : CGFloat, clipsToBounds: Bool, backgroundColor : UIColor, layoutMarginsTop : CGFloat, layoutMarginsbottom : CGFloat, layoutMarginsLeft : CGFloat, layoutMarginsRight : CGFloat) {
        super.init(frame: frame)
        
        self.titleLabel?.text = title
        self.titleLabel?.tintColor = textColor
        //Si le texte doit être en gras
        if isBold {
            
            self.titleLabel?.font = UIFont.boldSystemFont(ofSize: textSize)
        }else {
            self.titleLabel?.font = UIFont.systemFont(ofSize: textSize)
        }
        
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        
        self.layoutMargins = UIEdgeInsets(top: layoutMarginsTop, left: layoutMarginsLeft, bottom: layoutMarginsbottom, right: layoutMarginsRight)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupMainButton(cornerRadius : CGFloat? = nil, padding : UIEdgeInsets? = nil, font : CGFloat? = nil) {
        
        self.setTitle("nextButton".localized(tableName: "Authentification").uppercased(), for: .normal)
        self.setTitleColor(ColorManager.whiteColor, for: .normal)
        
        if let _font = font {
            self.titleLabel?.font = UIFont.boldSystemFont(ofSize: _font)
        }else {
            self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        }
        
        if let _cornerRadius = cornerRadius {
            self.layer.cornerRadius = _cornerRadius
        }else{
            self.layer.cornerRadius = 5
        }
        
        self.backgroundColor = ColorManager.primaryColor
        if let edgeInset = padding {
            self.contentEdgeInsets = edgeInset
        }else {
            self.contentEdgeInsets = UIEdgeInsets(top: 15, left: 35, bottom: 15, right: 35)
        }
        
        
    }
    
    func setupPreviousButton(cornerRadius : CGFloat? = nil, padding : UIEdgeInsets? = nil, font : CGFloat? = nil) {
        
        self.setTitle("previous".localized(tableName: "MainPage").uppercased(), for: .normal)
        self.setTitleColor(ColorManager.blackColor, for: .normal)
        
        if let _font = font {
            self.titleLabel?.font = UIFont.boldSystemFont(ofSize: _font)
        }else {
            self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        }
        
        
        if let _cornerRadius = cornerRadius {
            self.layer.cornerRadius = _cornerRadius
        }else{
            self.layer.cornerRadius = 5
        }
        
        self.backgroundColor = ColorManager.grayAppColor
        
        if let edgeInset = padding {
            self.contentEdgeInsets = edgeInset
        }else {
            self.contentEdgeInsets = UIEdgeInsets(top: 15, left: 35, bottom: 15, right: 35)
        }
        
    }
    
    
}
