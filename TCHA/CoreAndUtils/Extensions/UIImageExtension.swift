//
//  UIImageExtension.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 16/10/2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    func changeColorImage(by : UIColor){
        
        let origImage = self.image
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        self.image = tintedImage
        self.tintColor = by
    }
    
}

extension UIImage {
    
    func resizeImageTo(size: CGSize) -> UIImage? {
            
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            self.draw(in: CGRect(origin: CGPoint.zero, size: size))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return resizedImage
        }
}
