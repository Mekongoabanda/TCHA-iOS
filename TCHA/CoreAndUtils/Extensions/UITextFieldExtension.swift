//
//  UITextFieldExtension.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 19/10/2022.
//

import Foundation
import UIKit

extension UITextField {
    
    func setPadding(left: CGFloat, right: CGFloat? = nil) {
            setLeftPadding(left)
            if let rightPadding = right {
                setRightPadding(rightPadding)
            }
        }

        private func setLeftPadding(_ padding: CGFloat) {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }

        private func setRightPadding(_ padding: CGFloat) {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    
    func createCustomTextFields(cornerRadius : CGFloat ,clipsToBounds : Bool, backgroundColor : UIColor, placeholder : String = "" ,textColor : UIColor ,font : UIFont, borderWith : CGFloat = 0, borderColor : CGColor ,paddingLeft : CGFloat = 0, paddingRight : CGFloat = 0){
        
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWith
        self.font = font
        self.textColor = textColor
        self.placeholder = placeholder
        self.backgroundColor = backgroundColor
        self.clipsToBounds = clipsToBounds
        self.layer.cornerRadius = cornerRadius
        self.setPadding(left: paddingLeft, right: paddingRight)
        
    }
    
}
