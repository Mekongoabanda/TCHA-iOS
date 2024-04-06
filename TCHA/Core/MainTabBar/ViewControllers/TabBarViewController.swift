//
//  TabBarViewController.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 28/01/2023.
//

import UIKit
import Foundation
import SwiftUI

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var titleAndImageList : [(title : String, icon : UIImage?)] = []
    var viewControllerList : [UIViewController] = []
    var barTinColor : UIColor = ColorManager.primaryColor.withAlphaComponent(1)
    var borderColor : CGColor = ColorManager.whiteColor.cgColor
    var borderWitdh : CGFloat = 0.0
    var backgroundColor : UIColor = ColorManager.whiteColor
    var iconSize : CGSize = CGSize(width: 22, height: 22)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleAndImageList = setupTitleAndIcons()
        self.viewControllerList = fillViewControllerlist()
        self.createSimpleTabBarWithTextAndIcon(titleAndImageList: titleAndImageList, viewControllerList: viewControllerList, barTinColor: barTinColor, borderColor: borderColor, borderWitdh: borderWitdh, backgroundColor: backgroundColor, iconSize: iconSize)

        
        self.changeRadiusOnTabBar(enabledRadius: true, cornerRadius: 30)
        self.tabBar.layer.borderWidth = 2
        tabBar.layer.borderColor = ColorManager.grayAppColor.cgColor
        
    }
    
    
    func setupTitleAndIcons() -> [(title : String, icon : UIImage?)] {
        
        return [(title : "search".localized(tableName: "MainPage"), icon : AssetsManager.search),
                (title : "publier".localized(tableName: "MainPage"), icon : AssetsManager.paper_plane),
                (title : "routes".localized(tableName: "MainPage"), icon : AssetsManager.split),
                (title : "chat".localized(tableName: "MainPage"), icon : AssetsManager.chat),
                (title : "profile".localized(tableName: "MainPage"), icon : AssetsManager.tchaCoverIcon)]
        
    }
    
    func fillViewControllerlist() -> [UIViewController] {
        
        return [SearchViewController(), UIHostingController(rootView: ShareUIView()),UIHostingController(rootView: RoutesUIView()),UIHostingController(rootView: ChatUIView()) ,UIHostingController(rootView: ProfilUIView())]
    }


}

struct TabBarView: UIViewControllerRepresentable {
    typealias UIViewControllerType = TabBarViewController
    
    func makeUIViewController(context: Context) ->TabBarViewController {
        return TabBarViewController()
    }
    
    func updateUIViewController(_ uiViewController: TabBarViewController, context: Context) {
        // Mettez à jour les propriétés ou la configuration de votre view controller si nécessaire
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
