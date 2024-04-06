//
//  AuthManager.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 25/10/2023.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

enum FirebaseErrorReason: String {
    case createUserError = "createUserError"
    case addUserDocError = "addUserDocError"
}

class AuthManager {
    //Definition of closure to manage auth states changes
    typealias AuthStateChangeListener = (Auth?, User?) -> Void
    typealias AuthUserSign = (AuthDataResult?, Error?) -> Void
    var handle: AuthStateDidChangeListenerHandle? = nil
    var mAuth = Auth.auth()
    var currentUser : User? = nil
    var firestoreManager: FirestoreManager?
    
    func createUserWith(email: String, password: String, datas: [String: Any], completion: @escaping AuthUserSign) {
        firestoreManager = FirestoreManager(currentUser: currentUser as? TchaUser)
        
        mAuth.createUser(withEmail: email, password: password) { authResult, error in
            
            if let authError = error{ //signUp failed ?
                completion(authResult, authError)
            }else { //signup success?
                var tempDatas = datas
                tempDatas["uid"] = authResult?.user.uid
                tempDatas["email"] = authResult?.user.email
                self.firestoreManager?.addUserDocument(datas: tempDatas, completion: { docError in
                    completion(authResult, docError)
                })
            }
            
        }
    }
    
    func deleteUser(completion: @escaping (String?) -> Void) {
        currentUser?.delete(completion: { error in
            if let error = error {
                // An error happened.
                completion(error.localizedDescription)
              } else {
                // Account deleted.
                  self.signOutUser { error in // then signout
                      if error == nil {
                          completion(error)
                      }
                  }
              }
        })
    }
    
    func SignInWith(email: String, password: String, completion: @escaping (User?, String?) -> Void) {
        mAuth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
            
            if let error = error {
                // Une erreur s'est produite lors de la création de l'utilisateur.
                print("Erreur de création d'utilisateur : \(error.localizedDescription)")
                completion(nil, error.localizedDescription)
            } else if let user = authResult?.user {
                // L'utilisateur a été créé avec succès.
                print("Utilisateur créé avec l'ID : \(user.uid)")
                print("Adresse e-mail de l'utilisateur : \(user.email ?? "Non spécifié")")
                // Vous pouvez effectuer d'autres opérations ici, comme la connexion automatique de l'utilisateur.
                completion(user, nil)
            }
            
        }
    }
    
    func signOutUser(completion: @escaping (String?) -> Void){
        do {
            try mAuth.signOut()
            completion(nil)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
            completion(signOutError.localizedDescription)
        }
    }
    
    //get current logged user : Can use it in Auth Views
    func addStateDidChangeListener(_ completion: @escaping AuthStateChangeListener) {
        handle = mAuth.addStateDidChangeListener { auth, user in
            self.currentUser = user
            completion(auth, user)
        }
    }
    
    func getCurrentUser(){
        if let _currentUser = mAuth.currentUser {
            currentUser = _currentUser
        }else {
            currentUser = nil
        }
    }
    
    func removeStateDidChangeListener() {
        mAuth.removeStateDidChangeListener(handle!)
    }
    
    func updateUsersData(displayName : String, photoUrl: URL?, completion: @escaping (Error?) -> Void){
        
        let changeRequest = mAuth.currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName
        changeRequest?.photoURL = photoUrl
        changeRequest?.commitChanges { error in
          // ...
            completion(error)
        }
    }
    
    func updateUserEmail(email: String, completion: @escaping (Error?) -> Void) {
        mAuth.currentUser?.updateEmail(to: email) { error in
          completion(error)
        }
    }
    
    func sendEmailVerification(completion: @escaping (Error?) -> Void) {
        mAuth.currentUser?.sendEmailVerification { error in
          completion(error)
        }
    }
    
    func updateUserPassword(password: String, completion: @escaping (Error?) -> Void) {
        mAuth.currentUser?.updatePassword(to: password) { error in
          completion(error)
        }
    }
    
    func sendPasswordReset(email: String, completion: @escaping (Error?) -> Void) {
        mAuth.sendPasswordReset(withEmail: email) { error in
          completion(error)
        }
    }
    
}
