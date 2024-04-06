//
//  UserDefaultHelper.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 09/11/2022.
//

import Foundation

class UserDefaultHelper {
    
    
    //Auth datas
    static let USER_FAMILY_NAME_KEY = "userFamilyName"
    static let USER_FIRST_NAME_KEY = "userFirstName"
    static let USER_BIRTHDATE_KEY = "userBirthdate"
    static let USER_EMAIL_KEY = "userEmail"
    static let USER_MOBILE_PHONE_KEY = "userMobilePhone"
    static let USER_PASSWORD_KEY = "userPassword"
    
    static func setValue( value:Any, for key :String){
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    static func getValue(for key : String) -> Any {
        let defaults = UserDefaults.standard
        return defaults.value(forKey: key) as Any
    }
    
    static func removeValue(for key : String) {
        let defaults = UserDefaults.standard
        return defaults.removeObject(forKey: key)
    }
    
}
