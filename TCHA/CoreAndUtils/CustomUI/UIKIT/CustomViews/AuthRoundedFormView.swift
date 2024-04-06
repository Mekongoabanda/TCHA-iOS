//
//  AuthRoundedFormView.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 13/10/2022.
//

//This custom UIVIEW will permit us to create dynamically our authentifaction form in App (sign in, sign up, etc)

import Foundation
import UIKit
import SnapKit

class AuthRoundedFormView : UIView {
    
    //stack will contains our TextFieldsViews
    var textFieldsStackView : UIStackView? = UIStackView()
    var textFieldsWithIconsList : [TextFieldWithIcon] = []
    var validateButton : UIButton? = UIButton()
    var formIsValide : Bool = false
    var textError : String = ""
    var viewController : UIViewController?
    var snackbar : SnackbarView?
    var snackbarViewModelType : SnackbarViewType = SnackbarViewType.info
    var datePicker = CustomDatePicker()
    var context : String?
    var authManager: AuthManager = AuthManager()

    func setup(textFieldsWithIconsList : [TextFieldWithIcon], textButton : String, buttonTextColor : UIColor, buttonBackgroundColor : UIColor, buttonTextSize : Int, buttonFont : UIFont, radiusView : CGFloat, shadowColor : UIColor, viewController : UIViewController, snackbarViewModelType : SnackbarViewType, context : String) {
        //Paramètres de la vue
        self.backgroundColor = ColorManager.whiteColor
        self.layer.cornerRadius = radiusView
        self.setShadow(shadowColor: shadowColor, shadowOpacity: 0.5, shadowOffset: .zero, shadowRadius: radiusView)
        self.context = context
        //Paramètre du bouton
        self.textFieldsWithIconsList = textFieldsWithIconsList
        self.validateButton?.backgroundColor = buttonBackgroundColor
        self.validateButton?.setTitleColor(ColorManager.whiteColor, for: .normal)
        self.validateButton?.setTitle(textButton, for: .normal)
        self.validateButton?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.validateButton?.customCornerRadius([.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: radiusView, borderColor: ColorManager.primaryColor, borderWidth: 0)
        self.validateButton?.isUserInteractionEnabled = true
        self.validateButton?.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        //StackView Attributes
        self.textFieldsStackView?.axis = .vertical
        self.textFieldsStackView?.alignment = .leading
        self.textFieldsStackView?.distribution = .equalSpacing
        self.textFieldsStackView?.spacing = 18
        self.textFieldsStackView?.isLayoutMarginsRelativeArrangement = true
        self.textFieldsStackView?.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        //snackBar et viewController
        self.viewController = viewController
        self.snackbarViewModelType = snackbarViewModelType
        
        //Pour chaque champ de texte il faut on l'ajooute dans notre stackView
        for fieldView in textFieldsWithIconsList {
            
            self.textFieldsStackView?.addArrangedSubview(fieldView)
            
        }
        
        self.setupConstraints()
        self.linkDatePickerToDateField()
        
    }
    
    //Les contraintes des élémnets de cette vue
    func setupConstraints() {
        //StackView dans la vue
        self.textFieldsStackView?.addTo(self, maker: { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalToSuperview().with(topMargin: .custom(value: 20))
        })
        
        //Si la stackvIEW existe
        if let stackView = self.textFieldsStackView {
            //le bouton en bas de la stackView
            self.validateButton?.addTo(self, maker: { maker in
                maker.top.equalTo(stackView.snp.bottom).with(topMargin: .custom(value: 20))
                maker.bottom.trailing.leading.equalToSuperview()
                
                //si notre viewController existe sa hauteur est proportionnelle à celui-ci
                if let view = viewController?.view{
                    maker.height.equalTo(60)
                }else { //sinon custom value
                    maker.height.equalToSuperview().multipliedBy(0.2)
                }
                
            })
        }
    }
    
    @objc func buttonPressed(){
        
        //Il sert à compter le nombre de champs avec des erreurs
        var errorCount = 0
        
        for textFieldWithIcon in textFieldsWithIconsList {
            
            var regex : Bool = true
            
            switch(textFieldWithIcon.textField.tag) {
                
            case GeneralFieldsNumber.nom.value() :
                
                break
                
            case GeneralFieldsNumber.prenom.value() :
                
                break
                
            case GeneralFieldsNumber.birthdate.value() :
                
                regex = textFieldWithIcon.textField.text?.checkIfDateStringIsCorrect(format: DatePickerFormat.day.rawValue) ?? false
                textFieldWithIcon.toggleError(isCorrect: regex)
                textError = "birthdateNotCorrect".localized(tableName: "Authentification")
                self.showSnackBarMessage(regex: regex, errorMessage: textError)
                break
                
            case GeneralFieldsNumber.mail.value() :
                regex = textFieldWithIcon.textField.text?.checkIfEMailWithCorrectFormat() ?? false
                textFieldWithIcon.toggleError(isCorrect: regex)
                textError = "incorrectEmail".localized(tableName: "Authentification")
                self.showSnackBarMessage(regex: regex, errorMessage: textError)
                break
                
            case GeneralFieldsNumber.phoneNumber.value() :
                regex = textFieldWithIcon.textField.text?.checkIfCorrectInternationalPhoneNumberFormat() ?? false
                textFieldWithIcon.toggleError(isCorrect: regex)
                textError = "incorrectPhoneNumber".localized(tableName: "Authentification")
                self.showSnackBarMessage(regex: regex, errorMessage: textError)
                break
                
            case GeneralFieldsNumber.password.value() :
                
                break
                
            default :
                break
            }
            
            if !regex {
                errorCount += 1
            }
        }
        
        //Si on a au moins une erreur dans le formulaire on passe le booléen à false
        if errorCount > 0 {
            
            formIsValide = false
        }else {
            formIsValide = true
            textError = ""
            //On enregistre les données dans notre UserDefault
            saveLocalDatas()
            //selon le context (la vue où l'on se trouve on effectue des routes)
            onFormValidate()
            
        }
        
        
    }
    
    //On assigne le date Picker à notre champs de date
    func linkDatePickerToDateField(){
        
        for textFieldWithIcon in textFieldsWithIconsList {
            
            switch(textFieldWithIcon.textField.tag) {
                
            case GeneralFieldsNumber.birthdate.value() :
                
                guard let vc = self.viewController else { break }
                self.datePicker = CustomDatePicker(viewController: vc, textField: textFieldWithIcon.textField, frame: CGRect(x: 10, y: 5, width: vc.view.bounds.size.width , height: 250))
                
                break
            default : break
                
            }
            
        }
    }
    
    func saveLocalDatas(){
        
        for textFieldWithIcon in textFieldsWithIconsList {
            
            let defaults = UserDefaults.standard
            
            if let value = textFieldWithIcon.textField.text, !textFieldWithIcon.id.isEmpty { //id doit être existant
                
                if textFieldWithIcon.id != UserDefaultHelper.USER_BIRTHDATE_KEY{ //On ne stock pas la date en string
                    UserDefaultHelper.setValue(value: value, for: textFieldWithIcon.id)
                }
            }
            
        }
        //Pour la date, on la récupère du datePicker
        if let date = self.datePicker.selectedDate {
            UserDefaultHelper.setValue(value: date, for: UserDefaultHelper.USER_BIRTHDATE_KEY)
        }
        
    }
    
    func showSnackBarMessage(regex : Bool, errorMessage : String) {
        
        //Si on a une erreur sur le champs
        if !regex {
            
            guard let vc = self.viewController else { return }
            formIsValide = false
            
            let viewModel = SnackbarViewModel(type: self.snackbarViewModelType, text: errorMessage, image: AssetsManager.close_btn)
            let frame = CGRect(x: 0, y: 0, width: (viewController?.view.frame.size.width ?? 0)/1.5, height: 60)
            self.snackbar = SnackbarView(frame: frame, viewModel: viewModel, viewController: vc)
            
            self.validateButton?.isUserInteractionEnabled = false
            
            self.snackbar?.showSnackBar(completion: {
                self.validateButton?.isUserInteractionEnabled = true
            })
            
        }else {
            
        }
        
    }
    
    func onFormValidate(){
        //Selon le context (viewController) on déclenche une action
        switch self.context {
            
        case ViewControllerIdentifier.signUp.rawValue :
            self.viewController?.showLoader()
            
            self.viewController?.startViewController(storyBoardDestinationName: StoryBoardIdentifiers.mainAuth.rawValue, viewControllerDestinationID: ViewControllerIdentifier.useConditions.rawValue) {
            }
            
            break
        case ViewControllerIdentifier.signIn.rawValue :
            self.viewController?.showLoader()
            authManager.SignInWith(email: UserDefaultHelper.getValue(for: UserDefaultHelper.USER_EMAIL_KEY) as! String, password: UserDefaultHelper.getValue(for: UserDefaultHelper.USER_PASSWORD_KEY) as! String) { user, errorMessage in
                
                if errorMessage == nil {
                    self.viewController?.dismissLoader()
                    self.viewController?.startViewController(storyBoardDestinationName: StoryBoardIdentifiers.mainAuth.rawValue, viewControllerDestinationID: ViewControllerIdentifier.useConditions.rawValue) {
                    }
                }else {
                    self.viewController?.dismissLoader()
                    self.showSnackBarMessage(regex: false, errorMessage: errorMessage ?? "")
                }
            }
            
            break
        default :
            break
        }
        
    }
    
    
    required init() {
        super.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
