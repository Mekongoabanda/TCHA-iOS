//
//  RoundViewShadow.swift
//  WeMoney
//
//  Created by Yannick Edouard MEKONGO ABANDA on 08/04/2021.
//

//************************ Vue PERSONNALISEE : bords arrondis avec ombre **********************

//Pour info, pour mettre de l'ombre on a 04 paramètre du self.layer qui sont
//- shadowColor : couleur de l'ombre
//- shadowRadius : arrondie de l'ombre
//- shadowOffset : dimensions de l'ombre
//- shadowOpacity : l'opacité de l'ombre
import UIKit

class CustomUIView: UIView {
    
    var isRounded = false
    var isBordered: Bool? = false
    var borderedColor: UIColor?
    
    
    init(frame: CGRect, isBordered: Bool, borderedColor: UIColor, isRounded : Bool) {
        super.init(frame: frame)
        self.isBordered = isBordered
        self.borderedColor = borderedColor
        self.isRounded = isRounded
        if isRounded {
            self.updateCircleUIView(isBordered: isBordered, borderedColor: borderedColor, isRounded: isRounded)
        }else {
            
        }
       
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    //Call this function to setupImage (send as param the borderColor and if image can have border)
    func updateCircleUIView(isBordered: Bool, borderedColor: UIColor, isRounded : Bool){
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
    
    //add image in center of UIView
    func addImageInMiddle(image : UIImage){
        
        var imageView = UIImageView()
        imageView.image = image
        
        imageView.addTo(self) { maker in
            maker.center.centerY.equalToSuperview()
            maker.height.width.equalTo(self.snp.height).multipliedBy(0.7)
        }
    }

}
