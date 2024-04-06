//
//  RoundedFormManager.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 16/10/2022.
//

import UIKit
import Foundation
import SnapKit

//Sert à générer et à gérer les formulaires des vues d'authentification

enum GeneralFieldsNumber : Int, CaseIterable {
    case nom = 0
    case prenom = 1
    case birthdate = 2
    case mail = 3
    case phoneNumber = 4
    case password = 5
    case departure = 6
    case destination = 7
    case departure_date = 8
    case weight = 9
    
    func value() -> Int {self.rawValue}
}

class FormManager {
    
    var textFieldsWithIconsList : [TextFieldWithIcon] = []
    var viewController : UIViewController = UIViewController()
    
    //On enregistre dans une liste les champs requis pour notre formulaire
    //On parcours l'Enum du formulaire et pour chaque champs à construire on lui donne :
    //- Un tag égale à la valeur de l'enum parcouru actuellement (sur son textfield)
    // - Une target (action)
    
    func generateSignUpTextFieldsList() -> [TextFieldWithIcon] {
        
        //On parcours notre enum pour savoir quels champs construire
        for field in GeneralFieldsNumber.allCases {
            
            switch(field.value()) {
                
            case GeneralFieldsNumber.nom.value() :
                let textFieldWithIcon = TextFieldWithIcon(frame: .zero, placeHolder: "name".localized(tableName: "Authentification"), imageIcon: AssetsManager.name ?? UIImage(), contentType: .name, id: UserDefaultHelper.USER_FAMILY_NAME_KEY)
                textFieldWithIcon.textField.tag = field.value()
                textFieldWithIcon.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                textFieldsWithIconsList.append(textFieldWithIcon)
                break
                
            case GeneralFieldsNumber.prenom.value() :
                let textFieldWithIcon = TextFieldWithIcon(frame: .zero, placeHolder: "firstname".localized(tableName: "Authentification"), imageIcon: AssetsManager.name ?? UIImage(), contentType: .givenName, id: UserDefaultHelper.USER_FIRST_NAME_KEY)
                textFieldWithIcon.textField.tag = field.value()
                textFieldWithIcon.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                textFieldsWithIconsList.append(textFieldWithIcon)
                break
                
            case GeneralFieldsNumber.birthdate.value() :
                
                var textFieldWithIcon = TextFieldWithIcon(frame: .zero)
                if #available(iOS 15.0, *) {
                    textFieldWithIcon = TextFieldWithIcon(frame: .zero, placeHolder: "birthdate".localized(tableName: "Authentification"), imageIcon: AssetsManager.birthday_cake ?? UIImage(), contentType: .dateTime, id: UserDefaultHelper.USER_BIRTHDATE_KEY)
                } else {
                    // Fallback on earlier versions
                    textFieldWithIcon = TextFieldWithIcon(frame: .zero, placeHolder: "birthdate".localized(tableName: "Authentification"), imageIcon: AssetsManager.birthday_cake ?? UIImage(), contentType: nil, id: UserDefaultHelper.USER_BIRTHDATE_KEY)
                }
                textFieldWithIcon.textField.tag = field.value()
                textFieldWithIcon.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                textFieldsWithIconsList.append(textFieldWithIcon)
                break
                
            case GeneralFieldsNumber.mail.value() :
                let textFieldWithIcon = TextFieldWithIcon(frame: .zero, placeHolder: "mail".localized(tableName: "Authentification"), imageIcon: AssetsManager.arrobaIcon ?? UIImage(), contentType: .emailAddress, id: UserDefaultHelper.USER_EMAIL_KEY)
                textFieldWithIcon.textField.tag = field.value()
                textFieldWithIcon.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                textFieldsWithIconsList.append(textFieldWithIcon)
                break
                
            case GeneralFieldsNumber.phoneNumber.value() :
                let textFieldWithIcon = TextFieldWithIcon(frame: .zero, placeHolder: "phoneNumber".localized(tableName: "Authentification"), imageIcon: AssetsManager.phone_call ?? UIImage(), contentType: .telephoneNumber, id: UserDefaultHelper.USER_MOBILE_PHONE_KEY)
                textFieldWithIcon.textField.tag = field.value()
                textFieldWithIcon.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                textFieldsWithIconsList.append(textFieldWithIcon)
                break
                
            case GeneralFieldsNumber.password.value() :
                let textFieldWithIcon = TextFieldWithIcon(frame: .zero, placeHolder: "passsword".localized(tableName: "Authentification"), imageIcon: AssetsManager.password_ic ?? UIImage(), contentType: .password, id: UserDefaultHelper.USER_PASSWORD_KEY)
                textFieldWithIcon.textField.tag = field.value()
                textFieldWithIcon.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                textFieldsWithIconsList.append(textFieldWithIcon)
                break
                
            default:
                break
            }
            
        }
        
        return textFieldsWithIconsList
        
    }
    
    func generateSignInTextFieldsList() -> [TextFieldWithIcon] {
        
        //On parcours notre enum pour savoir quels champs construire
        for field in GeneralFieldsNumber.allCases {
            
            switch(field.value()) {
  
            case GeneralFieldsNumber.mail.value() :
                let textFieldWithIcon = TextFieldWithIcon(frame: .zero, placeHolder: "mail".localized(tableName: "Authentification"), imageIcon: AssetsManager.arrobaIcon ?? UIImage(), contentType: .emailAddress, id: UserDefaultHelper.USER_EMAIL_KEY)
                textFieldWithIcon.textField.tag = field.value()
                textFieldWithIcon.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                textFieldsWithIconsList.append(textFieldWithIcon)
                break
                
            case GeneralFieldsNumber.password.value() :
                let textFieldWithIcon = TextFieldWithIcon(frame: .zero, placeHolder: "passsword".localized(tableName: "Authentification"), imageIcon: AssetsManager.password_ic ?? UIImage(), contentType: .password, id: UserDefaultHelper.USER_PASSWORD_KEY)
                textFieldWithIcon.textField.tag = field.value()
                textFieldWithIcon.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                textFieldsWithIconsList.append(textFieldWithIcon)
                break
                
            default:
                break
            }
            
        }
        
        return textFieldsWithIconsList
        
    }
    
    func generateSearchFormTextFieldsList() -> [TextFieldWithIcon] {
        
        //On parcours notre enum pour savoir quels champs construire
        for field in GeneralFieldsNumber.allCases {
            
            switch(field.value()) {
                
            case GeneralFieldsNumber.departure.value() :
                let textFieldWithIcon = TextFieldWithIcon(frame: .zero, placeHolder: "departure".localized(tableName: "MainPage"), imageIcon: AssetsManager.maps_icon ?? UIImage(), contentType: .countryName, id: "")
                textFieldWithIcon.textField.tag = field.value()
                textFieldWithIcon.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                textFieldsWithIconsList.append(textFieldWithIcon)
                break
                
            case GeneralFieldsNumber.destination.value() :
                let textFieldWithIcon = TextFieldWithIcon(frame: .zero, placeHolder: "destination".localized(tableName: "MainPage"), imageIcon: AssetsManager.maps_icon ?? UIImage(), contentType: .countryName, id: "")
                textFieldWithIcon.textField.tag = field.value()
                textFieldWithIcon.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                textFieldsWithIconsList.append(textFieldWithIcon)
                break
                
            case GeneralFieldsNumber.departure_date.value() :
                
                var textFieldWithIcon = TextFieldWithIcon(frame: .zero)
                if #available(iOS 15.0, *) {
                    textFieldWithIcon = TextFieldWithIcon(frame: .zero, placeHolder: "departure_date".localized(tableName: "MainPage"), imageIcon: AssetsManager.calendar ?? UIImage(), contentType: .dateTime, id: "")
                } else {
                    // Fallback on earlier versions
                    textFieldWithIcon = TextFieldWithIcon(frame: .zero, placeHolder: "departure_date".localized(tableName: "MainPage"), imageIcon: AssetsManager.calendar ?? UIImage(), contentType: nil, id: "")
                }
                textFieldWithIcon.textField.tag = field.value()
                textFieldWithIcon.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                textFieldsWithIconsList.append(textFieldWithIcon)
                break
                
            case GeneralFieldsNumber.weight.value() :
                let textFieldWithIcon = TextFieldWithIcon(frame: .zero, placeHolder: "weight".localized(tableName: "MainPage"), imageIcon: AssetsManager.weight ?? UIImage(), contentType: .telephoneNumber, id: "")
                textFieldWithIcon.textField.tag = field.value()
                textFieldWithIcon.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                textFieldsWithIconsList.append(textFieldWithIcon)
                break
                
                
            default:
                break
            }
            
        }
        
        return textFieldsWithIconsList
        
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {

        switch(textField.tag) {
            
        case GeneralFieldsNumber.nom.value() :
            
            break
            
        case GeneralFieldsNumber.prenom.value() :
            break
            
        case GeneralFieldsNumber.birthdate.value() :
            //the date cannot be editable
            textField.text?.removeAll()
            break
            
        case GeneralFieldsNumber.mail.value() :
            break
            
        case GeneralFieldsNumber.phoneNumber.value() :
            break
            
        case GeneralFieldsNumber.password.value() :
            break
            
        default :
            break
        }
        
        
    }
    
}
