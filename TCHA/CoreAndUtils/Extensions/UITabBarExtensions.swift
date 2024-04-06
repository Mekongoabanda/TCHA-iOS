//
//  UITabBarExtensions.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 28/01/2023.
//

import Foundation
import UIKit
import SnapKit
import AVFoundation

extension UITabBarController {
    
    //Prends une liste de tuples dont un tuple représente un titre et son icon
    //List de vues dont chaque vue est sera liée à un onglet
    func createSimpleTabBarWithTextAndIcon(titleAndImageList : [(title : String, icon : UIImage?)], viewControllerList : [UIViewController], barTinColor : UIColor, borderColor : CGColor, borderWitdh : CGFloat, backgroundColor :UIColor, iconSize : CGSize) {
        
        var tabViewControllers : [UIViewController]  = []
        //Link each tab with icon, image and theses correspondant views
        
        for i in 0...(titleAndImageList.count-1) {
            
            let title = titleAndImageList[i].title
            let icon = titleAndImageList[i].icon?.resizeImageTo(size: iconSize)
            let tabX = viewControllerList[i]
            
            let tabItem = UITabBarItem(title: title, image: icon, selectedImage: icon)
            
            tabX.tabBarItem = tabItem
            
            tabViewControllers.append(tabX)
            
        }
        
        self.viewControllers = tabViewControllers
        
        tabBar.tintColor = barTinColor
        tabBar.layer.borderColor = borderColor
        tabBar.layer.borderWidth = borderWitdh
        tabBar.backgroundColor = backgroundColor
    }
    
    func changeRadiusOnTabBar(enabledRadius : Bool, cornerRadius : CGFloat){
        
        if enabledRadius {
            self.tabBar.layer.masksToBounds = enabledRadius
            self.tabBar.isTranslucent = enabledRadius
            self.tabBar.layer.cornerRadius = cornerRadius
            self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }else {
            
            self.tabBar.layer.masksToBounds = enabledRadius
            self.tabBar.isTranslucent = enabledRadius
            self.tabBar.layer.cornerRadius = cornerRadius
            self.tabBar.layer.maskedCorners = []
        }
    }
    
}

