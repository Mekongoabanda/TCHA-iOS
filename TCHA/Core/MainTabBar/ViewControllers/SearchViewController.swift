//
//  SearchViewController.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 31/01/2023.
//

import UIKit
import SwiftUI

class SearchViewController: UIViewController {
    
    var imageBackGround = UIImageView()
    var roundedFormView =  AuthRoundedFormView()
    var formManager = FormManager()
    var buttonTextValue = "search".localized(tableName: "MainPage")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.miseEnPlaceDuClavier()
        self.formManager.viewController = self
        setupUI()
        makeConstraint()
    }

    
    func setupUI(){
        self.view.backgroundColor = .white
        imageBackGround.image = AssetsManager.tchaCoverIcon
        imageBackGround.sizeToFit()
        //On génère notre vu de formulaire en lui passant les données demandées
        self.roundedFormView.setup(textFieldsWithIconsList: formManager.generateSearchFormTextFieldsList(), textButton: buttonTextValue, buttonTextColor: ColorManager.whiteColor, buttonBackgroundColor: ColorManager.primaryColor, buttonTextSize: 16, buttonFont: UIFont.boldSystemFont(ofSize: 16), radiusView: 20, shadowColor: .black, viewController: self, snackbarViewModelType: .info, context: ViewControllerIdentifier.searchViewController.rawValue)
        
    }

    func  makeConstraint(){
        
        imageBackGround.addTo(self.view) { maker in
            maker.leading.trailing.top.equalToSuperview()
            maker.height.equalTo((self.view.frame.height / 2))
        }
        
        self.roundedFormView.addTo(self.view) { maker in
            maker.centerY.centerX.equalToSuperview()
            maker.width.equalToSuperview().multipliedBy(0.85)
        }
        
    }

}

struct SearchView: UIViewControllerRepresentable {
    typealias UIViewControllerType = SearchViewController
    
    func makeUIViewController(context: Context) ->SearchViewController {
        return SearchViewController()
    }
    
    func updateUIViewController(_ uiViewController: SearchViewController, context: Context) {
        // Mettez à jour les propriétés ou la configuration de votre view controller si nécessaire
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
