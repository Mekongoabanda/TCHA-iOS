//
//  SignInViewController.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 29/10/2022.
//

import UIKit
import SwiftUI

class SignInViewController: UIViewController {
    
    var authentificationFormManager = FormManager()
    @IBOutlet weak var backButton: UIImageView!
    var createAccountLabel = UILabel()
    var resetPasswordLabel = UILabel()
    var imageTcha = UIImageView()
    @IBOutlet weak var authRoundedFormView: AuthRoundedFormView!
    var signupTextValue = "signin".localized(tableName: "Authentification")
    @IBOutlet weak var signinLabel: UILabel!
    var context = ViewControllerIdentifier.signIn.rawValue
    var authManager : AuthManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.miseEnPlaceDuClavier()
        self.authentificationFormManager.viewController = self
        //On génère notre vu de formulaire en lui passant les données demandées
        self.authRoundedFormView.setup(textFieldsWithIconsList: authentificationFormManager.generateSignInTextFieldsList(), textButton: signupTextValue, buttonTextColor: ColorManager.whiteColor, buttonBackgroundColor: ColorManager.primaryColor, buttonTextSize: 16, buttonFont: UIFont.boldSystemFont(ofSize: 16), radiusView: 20, shadowColor: .black, viewController: self, snackbarViewModelType: .info, context: self.context)
        self.signinLabel.text = signupTextValue
        
        setupCreateAccountLabel()
        setupResetPasswordLabel()
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
        
        self.resetPasswordLabel.addTo(self.view) { maker in
            maker.top.equalTo(self.createAccountLabel.snp.bottom).with(topMargin: .custom(value: 20))
            maker.centerX.equalToSuperview()
            maker.width.equalToSuperview().multipliedBy(0.7)
        }
        
        self.imageTcha.addTo(self.view) { maker in
            maker.top.equalTo(self.resetPasswordLabel.snp.bottom).with(topMargin: .small)
            maker.centerX.equalToSuperview()
            maker.width.height.equalTo(self.view.snp.width).multipliedBy(0.3)
        }
    }
    
    func setupCreateAccountLabel(){
        
        self.createAccountLabel.text = "noExistingAccount".localized(tableName: "Authentification")
        self.createAccountLabel.numberOfLines = 2
        self.createAccountLabel.textAlignment = .center
        self.createAccountLabel.underline()
        self.createAccountLabel.isUserInteractionEnabled = true
        self.createAccountLabel.textColor = ColorManager.blackColor
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(backPressed))
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(backPressed))
        gesture.numberOfTapsRequired = 1
        gesture2.numberOfTapsRequired = 1
        self.createAccountLabel.addGestureRecognizer(gesture)
        self.backButton.addGestureRecognizer(gesture2)
    }
    
    func setupResetPasswordLabel(){
        
        self.resetPasswordLabel.text = "resetPassword".localized(tableName: "Authentification")
        self.resetPasswordLabel.numberOfLines = 2
        self.resetPasswordLabel.textAlignment = .center
        self.resetPasswordLabel.underline()
        self.resetPasswordLabel.isUserInteractionEnabled = true
        self.resetPasswordLabel.textColor = ColorManager.blackColor
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onClickOnResetEmail))
        gesture.numberOfTapsRequired = 1
        self.resetPasswordLabel.addGestureRecognizer(gesture)
    }
    
    func setupTchaLogo(){
        self.imageTcha.image = AssetsManager.logo_tcha_horizontal
        self.imageTcha.contentMode = .scaleAspectFit
    }
    
    
    @objc func backPressed() {
        
        self.onBackPressed {
            
        }
        
    }
    
    @objc func onClickOnResetEmail() {
        showLoader()
        //Check if email field is filled
        if let form = authRoundedFormView {
            
            for mField in form.textFieldsWithIconsList {
                
                if mField.id == UserDefaultHelper.USER_EMAIL_KEY, let email = mField.textField.text {
                    authManager.sendPasswordReset(email: email) { error in
                        
                        if let err = error {
                            self.showSnackBarMessage(error: true, message: err.localizedDescription) { isShowned in
                                self.dismissLoader()
                            }
                        }else {
                            self.showSnackBarMessage(error: true, message: "Nous avons envoyé un mail de changement de mot de passe à \(email)") { isShowned in
                                self.dismissLoader()
                            }
                        }
                        
                    }
                }else {
                    dismissLoader()
                }
            }
        }
    }
    
}

struct SignInView: UIViewControllerRepresentable {
    typealias UIViewControllerType = SignInViewController
    
    func makeUIViewController(context: Context) -> SignInViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.signIn.rawValue) as? SignInViewController {
            return vc
        } else {
            return SignInViewController()
        }
        
    }
    
    func updateUIViewController(_ uiViewController: SignInViewController, context: Context) {
        // Mettez à jour les propriétés ou la configuration de votre view controller si nécessaire
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
