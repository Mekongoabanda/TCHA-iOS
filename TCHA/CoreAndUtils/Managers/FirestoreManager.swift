//
//  FirestoreManager.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 27/10/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FirestoreManager {
    
    let db = Firestore.firestore()
    var userCollectionRef: CollectionReference?
    var mAuth = Auth.auth()
    var currentUser : TchaUser? = nil
    
    init(currentUser: TchaUser? = nil) {
        self.currentUser = currentUser
        userCollectionRef = db.collection("Users")
    }
    
    func addDocument(collectionRef: CollectionReference?, datas: [String: Any], completion: @escaping (Error?)-> Void) {
        
        var docRef = collectionRef?.addDocument(data: datas, completion: { error in
            completion(error)
        })
    }
    
    
    func addUserDocument(datas: [String: Any], completion: @escaping (Error?)-> Void) {
        
        self.addDocument(collectionRef: userCollectionRef, datas: datas) { error in
            if let err = error{
                completion(err)
            }else {
                completion(error)
            }
        }
        
    }
    
    func readUserDocument(datas: [String: Any], completion: @escaping (QuerySnapshot?, Error?)-> Void) {
        
        self.userCollectionRef?.getDocuments(completion: { (querySnapshot, error) in
            if let e = error {
                completion(nil, e)
            }else {
                for document in querySnapshot!.documents {
                            print("\(document.documentID) => \(document.data())")
                        }
            }
        })
        
    }
}
