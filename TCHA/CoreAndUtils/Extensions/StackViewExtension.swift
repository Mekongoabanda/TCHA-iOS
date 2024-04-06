//
//  StackViewExtension.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 17/10/2022.
//

import Foundation
import UIKit

extension UIStackView {
    
    func setup(axis : NSLayoutConstraint.Axis, alignment : UIStackView.Alignment, distribution : UIStackView.Distribution, spacing : CGFloat, isLayoutMarginsRelativeArrangement : Bool, layoutMarginsTop : CGFloat, layoutMarginsbottom : CGFloat, layoutMarginsLeft : CGFloat, layoutMarginsRight : CGFloat){
        
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
        self.isLayoutMarginsRelativeArrangement = isLayoutMarginsRelativeArrangement
        self.layoutMargins = UIEdgeInsets(top: layoutMarginsTop, left: layoutMarginsLeft, bottom: layoutMarginsbottom, right: layoutMarginsRight)
    }
    
}
