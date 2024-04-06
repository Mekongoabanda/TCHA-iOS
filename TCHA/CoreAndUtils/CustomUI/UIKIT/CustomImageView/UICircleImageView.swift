//
//  UICircleImageView.swift
//  WeMoney
//
//  Created by Yannick Edouard MEKONGO ABANDA on 11/10/2022.
//

//CIRCLE IMAGE VIEW
import UIKit

class UICircleImageView: UIImageView {
    
    var isBordered: Bool? = false
    var borderedColor: UIColor?
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
    }
    
    //Call this function to setupImage (send as param the borderColor and if image can have border)
    func setupUI(isBordered: Bool, borderedColor: UIColor){
        layoutSubviews()
        self.isBordered = isBordered
        self.borderedColor = borderedColor
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.masksToBounds = true
        if self.isBordered == true, let _borderedColor = self.borderedColor {
            self.layer.borderColor = _borderedColor.cgColor
            self.layer.borderWidth = 1.5
            
            let borderLayer = CALayer()
            borderLayer.frame = self.bounds
            borderLayer.borderColor = _borderedColor.cgColor
            borderLayer.borderWidth = 3.0
            borderLayer.cornerRadius = self.bounds.width / 2
            self.layer.insertSublayer(borderLayer, above: self.layer)
        }else{
            self.layer.borderWidth = 0
            self.layer.sublayers?.removeAll()
        }
        
    }
}
