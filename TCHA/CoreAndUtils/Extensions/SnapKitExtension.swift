//
//  SnapKitExtension.swift
//  WeMoney
//
//  Created by Yannick Edouard MEKONGO ABANDA on 12/10/2022.
//

import Foundation
import UIKit
import SnapKit

protocol ConstraintTarget: ConstraintInsetTarget & ConstraintOffsetTarget { }
extension Int: ConstraintTarget {}
extension UInt: ConstraintTarget {}
extension Float: ConstraintTarget {}
extension Double: ConstraintTarget {}
extension CGFloat: ConstraintTarget {}

extension ConstraintMakerEditable {
    
    enum MarginSize {
        case xsmall
        case small
        case medium
        case big
        case custom(value: ConstraintTarget)
    }
    
    private enum MarginType {
        case offset
        case inset
    }
    
    private static let xsmallInset: ConstraintInsetTarget = 5
    private static let smallInset: ConstraintInsetTarget = 10
    private static let mediumInset: ConstraintInsetTarget = 15
    private static let bigInset: ConstraintInsetTarget = 20
    
    private static let xsmallOffset: ConstraintOffsetTarget = 5
    private static let smallOffset: ConstraintOffsetTarget = 10
    private static let mediumOffset: ConstraintOffsetTarget = 15
    private static let bigOffset: ConstraintOffsetTarget = 20
    
    
    
    /*
                   Top
                 _______
                |       |
     leading    |       |    trailing
                |_______|

                 Bottom
     */

    
    @discardableResult
    func with(trailingMargin: ConstraintMakerEditable.MarginSize) -> ConstraintMakerEditable {
        return self.withMargin(type: .inset, size: trailingMargin)
    }
    
    @discardableResult
    func with(leadingMargin: ConstraintMakerEditable.MarginSize) -> ConstraintMakerEditable {
        return self.withMargin(type: .offset, size: leadingMargin)
    }
    
    @discardableResult
    func with(topMargin: ConstraintMakerEditable.MarginSize) -> ConstraintMakerEditable {
        return self.withMargin(type: .offset, size: topMargin)
    }
    
    @discardableResult
    func with(bottomMargin: ConstraintMakerEditable.MarginSize) -> ConstraintMakerEditable {
        return self.withMargin(type: .inset, size: bottomMargin)
    }
    
    @discardableResult
    private func withMargin(type: ConstraintMakerEditable.MarginType, size: ConstraintMakerEditable.MarginSize) -> ConstraintMakerEditable {
        
        switch type {
        case .offset:
            switch size {
            case .big:
                self.offset(ConstraintMakerEditable.bigOffset)
                break
            case .medium:
                self.offset(ConstraintMakerEditable.mediumOffset)
                break
            case .small:
                self.offset(ConstraintMakerEditable.smallOffset)
                break
            case .xsmall:
                self.offset(ConstraintMakerEditable.xsmallOffset)
                break
            case .custom(value: let value):
                self.offset(value)
                break
            }
            break
        case .inset:
            switch size {
            case .big:
                self.inset(ConstraintMakerEditable.bigInset)
                break
            case .medium:
                self.inset(ConstraintMakerEditable.mediumInset)
                break
            case .small:
                self.inset(ConstraintMakerEditable.smallInset)
                break
            case .xsmall:
                self.inset(ConstraintMakerEditable.xsmallInset)
                break
            case .custom(value: let value):
                self.inset(value)
                break
            }
            break
        }
        return self
    }


}


extension UIView {
    
    /// Call this function to add your view object into a view hierarchy and make its constraint through thanks to Snapkit
    /// - Parameters:
    ///   - superView: the parent view where self will be added
    ///   - maker: the closure to call to make DSL snapkit constraints job
    func addTo(_ superView: UIView, maker: ((ConstraintMaker) -> Void)) {
        superView.addSubview(self)
        self.snp.makeConstraints(maker)
    }
    
}

