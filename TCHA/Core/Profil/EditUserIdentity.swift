//
//  EditUserIdentity.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 28/10/2023.
//

import SwiftUI

enum UserIdentity {
    
    enum OfficialDocument {
        static let passport :String = "Passport"
        static let cni :String = "Carte nationale d'identité"
        static let titreSejour :String = "Titre de séjour"
    }
}

struct EditUserIdentity: View {
    let headeText : String = "almostFinish".localized(tableName: "Authentification")
    @State private var profileImage = UIImage()
    @State private var profileImageUrlL: URL?
    var userName : String = ""
    @State var identityDocPlaceHolder : [String] = ["Numéro de passport"]
    var inputTypeIdentity: [InputTypeTcha] = [.text]
    @State var identityDocValues : [String] = [""]
    @State var selectedDocType : String = UserIdentity.OfficialDocument.passport
    @State var alphaNextButton = 0.4
    @State var alphaDocImage = 0.0
    @State private var showSheet = false
    @State private var showFilePickerDoc = false
    @State private var documentImage = UIImage()
    @State private var docImageUrlL: URL?
    // Use the StorageManager to upload the image
    var storageManager = StorageManager()
    @State var currentFieldSelected : Int? = nil
    
    var body: some View {
        
        VStack{
            ScrollView(.vertical) {
                VStack {
                    
                    HStack {
                        VStack {
                            Image(systemName: "arrowshape.turn.up.backward.fill")
                                .resizable()
                                .frame(width: 29, height: 29)
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Text(headeText)
                            .font(.system(size: 12))
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 40))
                        Spacer()
                        
                    }.padding(EdgeInsets(top: 6, leading: 6, bottom: 0, trailing: 0))
                    
                    Button {
                        showSheet = true
                    } label: {
                        ZStack{
                            Image(uiImage: self.profileImage)
                                .resizable()
                                .cornerRadius(50)
                                .frame(width: 100, height: 100)
                                .background(Color.black.opacity(0.2))
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                        }
                        
                    }.padding(.top, 40)
                    
                    Text("userName")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.top, 16)
                    
                    HStack {
                        Text("Type de document 👉:  ")
                            .font(.system(size: 14, weight: .bold))
                            .padding(.top, 16)
                        Menu(selectedDocType) {
                            Button(UserIdentity.OfficialDocument.passport, action: passwordSelected)
                            Button(UserIdentity.OfficialDocument.cni, action: cniSelected)
                            Button(UserIdentity.OfficialDocument.titreSejour, action: sejourSelected)
                            
                        }.font(.system(size: 16, weight: .semibold))
                        
                    }.padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                    
                    HStack{
                        Image(.passport)
                            .resizable()
                            .frame(width: 46, height: 46)
                        ManageFormUIView(fieldsCount: identityDocPlaceHolder.count, placeHolderList: $identityDocPlaceHolder, value: $identityDocValues, inputTypeList: inputTypeIdentity, currentFieldSelected: $currentFieldSelected)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }.padding(EdgeInsets(top: 15, leading: 9, bottom: 0, trailing: 0))
                    
                    VStack {
                        Button(action: {
                            showFilePickerDoc = true
                        }, label: {
                            
                            ZStack(alignment: .center) {
                                ZStack(alignment: .center) {
                                    
                                    Rectangle()
                                        .frame(width: 170, height: 150)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color.gray, lineWidth: 1)
                                            
                                        )
                                        .foregroundColor(Color(ColorManager.ConfigColorsEnum.grayAppColor3.nameId()))
                                    Text("Cliquez ici")
                                        .foregroundColor(Color.gray)
                                }
                                Image(uiImage: documentImage)
                                    .resizable()
                                    .frame(width: 170, height: 150)
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(15.0)
                                    .opacity(1)
                                
                            }
                            
                        })
                        Text("Preuve de: \(selectedDocType)")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color.black)
                            .padding(.top, 5)
                        
                        
                    }.padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                    
                }
            }
            
            Spacer()
            
            VStack {
                Button("Suivant") {
                    launchUploads()
                }.padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                    .foregroundColor(.white)
                    .font(Font.system(size: 25, weight: .bold))
                    .background(Color(ColorManager.ConfigColorsEnum.primaryColor.nameId()))
                    .cornerRadius(8)
                    .opacity(alphaNextButton)
            }
        }.sheet(isPresented: $showSheet) {
            // Pick an image from the photo library:
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$profileImage)
        }
        .sheet(isPresented: $showFilePickerDoc) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$documentImage)
        }
    }
    
    func passwordSelected(){
        selectedDocType = UserIdentity.OfficialDocument.passport
        identityDocPlaceHolder = ["Numéro de passport"]
    }
    
    func cniSelected(){
        selectedDocType = UserIdentity.OfficialDocument.cni
        identityDocPlaceHolder = ["Numéro d'identité"]
    }
    func sejourSelected(){
        selectedDocType = UserIdentity.OfficialDocument.titreSejour
        identityDocPlaceHolder = ["Numéro du titre"]
    }
    
    func uploadDatasToStorage(image: UIImage, storagePath: String, completion: @escaping(URL?, Error?) -> Void) {
        let imageData = image.jpegData(compressionQuality: 0.8)!
        
        // Specify the desired path in Firebase Storage
        //storagePath =
        
        storageManager.uploadFile(ref: storagePath, data: imageData) { (url, error) in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion(url, error)
            } else if let url = url {
                // Handle the uploaded image URL
                print("Image uploaded successfully. URL: \(url)")
                completion(url, error)
            }
        }
    }
    
    func launchUploads(){
        uploadDatasToStorage(image: profileImage, storagePath: "profile images/\(UUID().uuidString).jpg") { url, error in
            
            if let err = error {
                
            }else {
                uploadDatasToStorage(image: documentImage, storagePath: "documentImage/\(UUID().uuidString).jpg") { url, error in
                    
                }
            }
        }
    }
}

#Preview {
    EditUserIdentity()
}
