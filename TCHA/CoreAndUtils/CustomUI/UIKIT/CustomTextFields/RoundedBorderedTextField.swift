//
//  RoundedBorderedTextField.swift
//  WeMoney
//
//  Created by Yannick Edouard MEKONGO ABANDA on 09/10/2022.
//

import Foundation

import UIKit

class RoundedBorderedTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 10)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 10)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func setup(buttonIsRound : Bool, borderWith : CGFloat, borderColor : UIColor, backgroundColor: UIColor, textColor : UIColor, masksToBounds : Bool){
        if buttonIsRound == true {
            self.layer.cornerRadius = self.bounds.height / 2
        }
        else{
            self.layer.cornerRadius = self.bounds.height / 10
        }
        
        self.layer.borderWidth = 1.0
        if isEnabled == true {
            self.layer.borderColor = borderColor.cgColor
            self.textColor = textColor
        }
        else{
            self.layer.borderColor = borderColor.cgColor
            self.textColor = textColor
        }
        self.backgroundColor = backgroundColor
        self.layer.masksToBounds = true
    }
    
}

class TextFieldWithoutCaret: RoundedBorderedTextField{
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
}
