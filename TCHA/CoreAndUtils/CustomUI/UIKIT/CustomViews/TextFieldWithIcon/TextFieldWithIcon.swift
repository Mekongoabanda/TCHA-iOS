//
//  TextFieldWithIcon.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 13/10/2022.
//

// Icon + Image

import Foundation
import UIKit

class TextFieldWithIcon : UIView {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var horizontalStackView: UIStackView!
    var placeHolder : String?
    var imageIcon : UIImage?
    var contentType : UITextContentType?
    var id : String = ""
    
    init(frame: CGRect, placeHolder : String, imageIcon : UIImage, contentType : UITextContentType?, id : String) {
        super.init(frame: frame)
        self.placeHolder = placeHolder
        self.imageIcon = imageIcon
        self.contentType = contentType
        self.id = id
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        //On lie notre vue à notre fichier swift
        let bundle = Bundle.init(for: TextFieldWithIcon.self)
        connectCustomView(bundle: bundle, nibName: "TextFieldWithIcon")
        
        self.backgroundColor = .clear
        self.icon.image = self.imageIcon
        self.textField.placeholder = self.placeHolder
        self.textField.textContentType = self.contentType
        
    }
    
    func toggleError(isCorrect : Bool = true){
        
        if isCorrect {
            self.icon.changeColorImage(by: .gray)
            self.textField.textColor = .black
        }else {
            
            self.icon.changeColorImage(by: ColorManager.redBlood)
            self.textField.textColor = ColorManager.redBlood
        }
    }
}
