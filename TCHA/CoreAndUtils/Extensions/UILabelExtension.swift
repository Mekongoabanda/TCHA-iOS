//
//  UILabelExtension.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 16/10/2022.
//

import Foundation
import UIKit

extension UILabel {
    
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
    
    func setup(fontSize : CGFloat, isBold : Bool, textColor : UIColor, text : String){
        
        self.text = text
        self.textColor = textColor
        if isBold {
            self.font = UIFont.boldSystemFont(ofSize: fontSize)
        }else{
            self.font = UIFont.systemFont(ofSize: fontSize)
        }
        
        
    }
    
}
