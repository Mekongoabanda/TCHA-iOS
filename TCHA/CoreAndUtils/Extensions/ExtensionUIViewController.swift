//
//  ExtensionUIViewController.swift
//  WeMoney
//
//  Created by Yannick Edouard MEKONGO ABANDA on 16/04/2021.
//

//---------------------------- CE SWIFT FILE s'est pour gérer le comportement de l'écran lorsque le clavier s'affiche (peut-être ça servira à d'autre choses supplémentaires dans le futur)

import UIKit
import Foundation
import SnapKit
import SwiftUI

//On crée une extension de type UIVIEWCONTROLLER
extension UIViewController {

    func miseEnPlaceDuClavier(){
        
        //Ajouter un observateur Lorsque le clavier s'affiche
        NotificationCenter.default.addObserver(self, selector: #selector(clavierSorti), name: UIResponder.keyboardWillShowNotification, object: nil)
        //Ajouter un observateur Lorsque le clavier rentre/disparais
        NotificationCenter.default.addObserver(self, selector: #selector(clavierRentre), name: UIResponder.keyboardWillHideNotification, object: nil)
    
    view.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(rangerClavier)))
    }
    
    //Du coup lorsque notre clavier sort
    @objc func clavierSorti(notification: Notification){
        
        //On récupère d'abord la taille de notre clavier
        if let rectDeMonClavier = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, view.frame.minY == 0 {
            
            UIView.animate(withDuration: 0.25, animations: {
                self.view.frame.origin.y -= rectDeMonClavier.height
            })
        }
    }
    
    //Du coup lorsque notre clavier rentre
    @objc func clavierRentre(notification: Notification){
        
        //On lance cette animation de la vue
        UIView.animate(withDuration: 0.25) {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    @objc func rangerClavier(){
        view.endEditing(true)
    }
    
    func onBackPressed(completion: @escaping() -> Void){
        
        //Faire rentrer le clavier avant de faire un back
        view.endEditing(true)
        //Pour faire un retour en arrière, équivalent du OnBackPressed() sous Android natif
        self.dismiss(animated: true) {
            completion()
        }
    }
    
    
    func startViewController(storyBoardDestinationName : String, viewControllerDestinationID : String, completion: @escaping() -> Void){
        
        // On crée une variable qui contient le storyboard laquelle on veut se rendre
        let storyboard = UIStoryboard(name: storyBoardDestinationName, bundle: nil)
        //On récupère le ViewController dans lequel on veut aller, par son identifiant
        let vc = storyboard.instantiateViewController(identifier: viewControllerDestinationID)
        // le type d'animation
        vc.modalPresentationStyle = .overFullScreen
        //On lance
        self.present(vc, animated: true) {
            completion()
        }
    }
    
    func startSwiftUIViewFromVC(vcDestionation : UIViewController, completion: @escaping() -> Void){
        // le type d'animation
        vcDestionation.modalPresentationStyle = .overFullScreen
        //On lance
        self.present(vcDestionation, animated: true) {
            completion()
        }
    }
    
    func showLoader() {
        
        let loaderBackground = UIView()
        loaderBackground.backgroundColor = UIColor(resource: .black).withAlphaComponent(0.3)
        let loader = UIActivityIndicatorView(style: .large)
        loader.tag = 9991
        loader.startAnimating()
        //personalize loader appareance
        loader.color = UIColor(resource: .primary)
        loader.circleView(borderWith: 2, borderColor: UIColor(resource: .primary).withAlphaComponent(0.1))
        
        loaderBackground.tag = 999 // Ajoutez un tag pour pouvoir le récupérer ultérieurement si nécessaire
        loaderBackground.addTo(view) { maker in
            maker.top.bottom.leading.trailing.equalToSuperview()
        }
        loader.addTo(loaderBackground) { maker in
            maker.centerX.centerY.equalToSuperview()
        }
        
    }
    
    func showSnackBarMessage(error : Bool, message : String, completion: @escaping(Bool) -> Void) {
        var snackbar : SnackbarView?
        let frame = CGRect(x: 0, y: 0, width: (self.view.frame.size.width )/1.5, height: 60)
       
        //Si on a une erreur sur le champs
        if error {
            var snackbarViewModelType : SnackbarViewType = SnackbarViewType.infoError
            let viewModel = SnackbarViewModel(type: snackbarViewModelType, text: message, image: AssetsManager.close_btn)
            snackbar = SnackbarView(frame: frame, viewModel: viewModel, viewController: self)
            snackbar?.showSnackBar(completion: {
                completion(true)
            })
            
        }else {
            var snackbarViewModelType : SnackbarViewType = SnackbarViewType.info
            let viewModel = SnackbarViewModel(type: snackbarViewModelType, text: message, image: AssetsManager.close_btn)
            snackbar = SnackbarView(frame: frame, viewModel: viewModel, viewController: self)
            snackbar?.showSnackBar(completion: {
                completion(true)
            })
        }
        
    }
    
    func dismissLoader() {
        if let loaderView = view.viewWithTag(999) as? UIActivityIndicatorView {
            loaderView.stopAnimating()
            loaderView.removeFromSuperview()
        }
        
        self.view.subviews.forEach { subview in
            if let loaderBackground = subview as? UIView, loaderBackground.tag == 999 {
                
                loaderBackground.subviews.forEach { subSubView in
                    if let loader = subSubView as? UIActivityIndicatorView, loader.tag == 9991{
                        loader.stopAnimating()
                        loader.removeFromSuperview()
                        loaderBackground.removeFromSuperview()
                    }
                }
            }
        }
    }
}
