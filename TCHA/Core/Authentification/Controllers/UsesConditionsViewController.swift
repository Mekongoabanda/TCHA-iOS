//
//  UsesConditionsViewController.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 29/11/2022.
//

import UIKit
import SwiftUI

class UsesConditionsViewController: UIViewController {
    
    var context  : String = ViewControllerIdentifier.useConditions.rawValue
    @IBOutlet var backButton: UIImageView!
    var nextButton: CustomButton = CustomButton()
    var mainView = UIView()
    @IBOutlet var separatorView: UIImageView!
    @IBOutlet var informationsLabel: UILabel!
    @IBOutlet var isAgreeLabel: UILabel!
    @IBOutlet var readConditionsLabel: UILabel!
    @IBOutlet var circleView: UICircleImageView!
    @IBOutlet var shadowView: UIView!
    var verticalStackView = UIStackView()
    var horizontalStackView = UIStackView()
    var horizontalSwitchView = UIStackView()
    @IBOutlet var logoImage: UIImageView!
    @IBOutlet var switchButton: UISwitch!
    var authManager : AuthManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupView()
        makeConstraints()
        
    }
    
    
    func setupView(){
        
        self.view.backgroundColor = ColorManager.whiteColor
        self.nextButton = CustomButton(frame: .zero)
        self.nextButton.setupMainButton()
        //Click on back button
        let gesture = UITapGestureRecognizer(target: self, action: #selector(backPressed))
        gesture.numberOfTapsRequired = 1
        self.backButton.addGestureRecognizer(gesture)
        //click on next button
        let gestureNextButton = UITapGestureRecognizer(target: self, action: #selector(nextButtonPressed))
        gestureNextButton.numberOfTapsRequired = 1
        self.nextButton.addGestureRecognizer(gestureNextButton)
        
        setupShadowView()
        setupStackViews()
        setupCircleViews()
    }

    
    
    func setupCircleViews(){
        
        self.circleView.circleView(borderWith: 2, borderColor: ColorManager.grayAppColor)
        
    }
    
    func setupShadowView(){
        self.shadowView.clipsToBounds  = true
        self.shadowView.backgroundColor = ColorManager.grayAppColor2
        self.shadowView.layer.cornerRadius = 15
        self.shadowView.setShadow(shadowColor: .black, shadowOpacity: 0.5, shadowOffset: .zero, shadowRadius: 15)
       
    }
    
    func setupStackViews(){

        //vertical
        self.verticalStackView.setup(axis: .vertical, alignment: .center, distribution: .equalSpacing, spacing: 22, isLayoutMarginsRelativeArrangement: true, layoutMarginsTop: 30, layoutMarginsbottom: 10, layoutMarginsLeft: 10, layoutMarginsRight: 10)
        
        //horizontal
        self.horizontalStackView.setup(axis: .horizontal, alignment: .center, distribution: .fill, spacing: 15, isLayoutMarginsRelativeArrangement: true, layoutMarginsTop: 0, layoutMarginsbottom: 0, layoutMarginsLeft: 0, layoutMarginsRight: 0)
        
        //Switch stack view
        
        //add elements
        setupStacksElements()
    }
    
    func setupStacksElements(){
        
        self.readConditionsLabel.setup(fontSize: 15, isBold: true, textColor: ColorManager.blackColor, text: "readUsesConditions".localized(tableName: "Authentification"))
        self.isAgreeLabel.numberOfLines = 3
        self.separatorView.backgroundColor = ColorManager.grayAppColor
        
        logoImage.image = AssetsManager.logo_tcha_vertical
        logoImage.sizeToFit()
        
        self.horizontalStackView.addArrangedSubview(isAgreeLabel)
        self.horizontalStackView.addArrangedSubview(switchButton)
        self.verticalStackView.addArrangedSubview(self.readConditionsLabel)
        self.verticalStackView.addArrangedSubview(self.horizontalStackView)
        self.verticalStackView.addArrangedSubview(self.separatorView)
        self.verticalStackView.addArrangedSubview(self.informationsLabel)
        self.verticalStackView.addArrangedSubview(self.logoImage)
    }
    
    func makeConstraints() {
        
        self.shadowView.snp.updateConstraints { make in
            make.top.equalTo(self.circleView.snp.centerY)
            make.trailing.equalToSuperview().with(trailingMargin: .custom(value: 15))
            make.leading.equalToSuperview().with(leadingMargin: .custom(value: 15))
            make.height.equalTo(420)
           
        }
        
        
        self.nextButton.addTo(self.view) { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).with(bottomMargin: .custom(value: 42))
            
            
        }
        
        self.verticalStackView.addTo(self.shadowView) { maker in
            maker.top.equalToSuperview().with(topMargin: .custom(value: 30))
            maker.leading.equalToSuperview().with(leadingMargin: .small)
            maker.trailing.equalToSuperview().with(trailingMargin: .small)
            
        }
        
        self.isAgreeLabel.snp.updateConstraints { make in
            make.height.equalTo(53)
            make.width.equalTo(250)
        }
        
        self.logoImage.snp.updateConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        
        
    }
    
    
    @objc func backPressed() {
        
        self.onBackPressed {
            
        }
        
    }
    
    @objc func nextButtonPressed(){
        showLoader()
        let datas : [String: Any] = [
            "firstName": UserDefaultHelper.getValue(for: UserDefaultHelper.USER_FIRST_NAME_KEY),
            "lastName": UserDefaultHelper.getValue(for: UserDefaultHelper.USER_FAMILY_NAME_KEY),
            "birthdate": UserDefaultHelper.getValue(for: UserDefaultHelper.USER_BIRTHDATE_KEY),
            "userCertified": false,
        ]
        
        if switchButton.isOn {
            authManager.createUserWith(email: UserDefaultHelper.getValue(for: UserDefaultHelper.USER_EMAIL_KEY) as! String, password: UserDefaultHelper.getValue(for: UserDefaultHelper.USER_PASSWORD_KEY) as! String, datas: datas) { authDataResult, error in
                
                if let err = error {
                    self.dismissLoader()
                    self.showSnackBarMessage(error: true, message: "\(err.localizedDescription)") { isShowned in
                        
                    }
                }else {
                    self.dismissLoader()
                    self.startSwiftUIViewFromVC(vcDestionation: UIHostingController(rootView: EditUserIdentity(userName: authDataResult?.user.displayName ?? ""))) {
                        
                    }
                }
            }
        }else {
            self.dismissLoader()
            self.showSnackBarMessage(error: true, message: "Vous devez Accepter nos conditions d'utilisation !") { isShowned in
            }
        }
        
    }
}

struct UsesConditionsView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UsesConditionsViewController
    
    func makeUIViewController(context: Context) ->UsesConditionsViewController {
        return UsesConditionsViewController()
    }
    
    func updateUIViewController(_ uiViewController: UsesConditionsViewController, context: Context) {
        // Mettez à jour les propriétés ou la configuration de votre view controller si nécessaire
    }
}

struct UsesConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        UsesConditionsView()
    }
}
