//
//  ViewController.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 09/10/2022.
//

import UIKit
import Foundation
import SnapKit
import SwiftUI

class MainViewController: UIViewController {
    
    @IBOutlet weak var textFieldViewAndIcon: TextFieldWithIcon!
    @IBOutlet weak var authRoundedFormView: AuthRoundedFormView!
    var authentificationFormManager = FormManager()
    var createAccountLabel = UILabel()
    @IBOutlet weak var signinLabel: UILabel!
    var imageTcha = UIImageView()
    var signupTextValue = "signup".localized(tableName: "Authentification")
    var context = ViewControllerIdentifier.signUp.rawValue
    var authManager: AuthManager = AuthManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.miseEnPlaceDuClavier()
        self.authentificationFormManager.viewController = self
        //On génère notre vu de formulaire en lui passant les données demandées
        self.authRoundedFormView.setup(textFieldsWithIconsList: authentificationFormManager.generateSignUpTextFieldsList(), textButton: signupTextValue, buttonTextColor: ColorManager.whiteColor, buttonBackgroundColor: ColorManager.primaryColor, buttonTextSize: 16, buttonFont: UIFont.boldSystemFont(ofSize: 16), radiusView: 20, shadowColor: .black, viewController: self, snackbarViewModelType: .info, context: self.context)
        self.signinLabel.text = signupTextValue
        
        setupCreateAccountLabel()
        setupTchaLogo()
        
        setupConstraints()
        
    }
    
    func setupConstraints(){
        
        self.authRoundedFormView.addTo(self.view) { maker in
            maker.centerY.centerX.equalToSuperview()
            maker.width.equalToSuperview().multipliedBy(0.85)
        }
        
        self.createAccountLabel.addTo(self.view) { maker in
            maker.top.equalTo(self.authRoundedFormView.snp.bottom).with(topMargin: .custom(value: 40))
            maker.centerX.equalToSuperview()
            maker.width.equalToSuperview().multipliedBy(0.7)
        }
        
        self.imageTcha.addTo(self.view) { maker in
            maker.top.equalTo(self.createAccountLabel.snp.bottom).with(topMargin: .small)
            maker.centerX.equalToSuperview()
            maker.width.height.equalTo(self.view.snp.width).multipliedBy(0.3)
        }
    }
    
    func setupCreateAccountLabel(){
        
        self.createAccountLabel.text = "haveExistingAccount".localized(tableName: "Authentification")
        self.createAccountLabel.numberOfLines = 2
        self.createAccountLabel.textAlignment = .center
        self.createAccountLabel.underline()
        self.createAccountLabel.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onClickSignInTextValue(_:)))
        gesture.numberOfTapsRequired = 1
        self.createAccountLabel.addGestureRecognizer(gesture)
        self.createAccountLabel.textColor = ColorManager.blackColor
    }
    
    func setupTchaLogo(){
        self.imageTcha.image = AssetsManager.logo_tcha_horizontal
        self.imageTcha.contentMode = .scaleAspectFit
    }
    
    @objc func onClickSignInTextValue(_ textField : UITextField) {
        //On lance notre vue de connexion
        self.startViewController(storyBoardDestinationName: StoryBoardIdentifiers.mainAuth.rawValue, viewControllerDestinationID: ViewControllerIdentifier.signIn.rawValue) {
        }
    }
    
}

struct MainView: UIViewControllerRepresentable {
    typealias UIViewControllerType = MainViewController
    
    func makeUIViewController(context: Context) -> MainViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "signup") as? MainViewController {
            return vc
        } else {
            return MainViewController()
        }
        
    }
    
    func updateUIViewController(_ uiViewController: MainViewController, context: Context) {
        // Mettez à jour les propriétés ou la configuration de votre view controller si nécessaire
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

