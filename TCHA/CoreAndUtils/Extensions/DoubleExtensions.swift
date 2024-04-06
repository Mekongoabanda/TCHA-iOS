//
//  DoubleExtensions.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 30/04/2023.
//

import Foundation

extension Double {
    
    func stringValueWithoutMultipleDecimal(minimumFractionDigits : Int = 0, maximumFractionDigits : Int = 0, groupingSeparator : String = ".") -> String{
        
         let numberFormatter: NumberFormatter = {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.minimumFractionDigits = minimumFractionDigits
                formatter.maximumFractionDigits = maximumFractionDigits
                formatter.groupingSeparator = groupingSeparator
                return formatter
            }()
        
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
        
    }
}
