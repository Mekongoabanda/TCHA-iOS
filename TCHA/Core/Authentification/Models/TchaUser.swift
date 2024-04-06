//
//  TchaUser.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 26/10/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

public class TchaUser: User {
    
    var firstName: String
    var lastName: String
    var birthdate: Date
    var userCertified: Bool
    
    func initialize(firstName: String, lastName: String, birthdate: Date, userCertified: Bool, displayName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthdate = birthdate
        self.userCertified = userCertified
    }
    
}
