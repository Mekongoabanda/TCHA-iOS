//
//  StorageManager.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 13/11/2023.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class StorageManager {
    let storage = Storage.storage()
    var storageRef : StorageReference
    
    init() {
        // Create a storage reference from our storage service
        storageRef = storage.reference()
        
    }
    
    func uploadFile(ref: String, data: Data, completion: @escaping(URL? ,Error?) -> Void){
        let dataRef = storageRef.child(ref)
        
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = dataRef.putData(data, metadata: nil) { (metadata, error) in
          if let err = error{
            // Uh-oh, an error occurred!
            completion(nil, err)
          }else {
              // Metadata contains file metadata such as size, content-type.
              let size = metadata?.size
              // You can also access to download URL after upload.
                dataRef.downloadURL { (url, error) in
                    completion(url, error)
              }
          }
          
        }
    }
}
      
