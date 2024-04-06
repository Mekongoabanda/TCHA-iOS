//
//  SnackBarView.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 17/10/2022.
//

import Foundation
import UIKit

class SnackbarView : UIView {
    
    private var handler : Handler?
    let viewModel: SnackbarViewModel
    private var viewController : UIViewController
    var snackBarDuration = 4
    private let label : UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = ColorManager.whiteColor
        label.textAlignment = .center
        label.text = ""
        label.shadowColor = .black
        return label
    }()
    
    private var imageView : UIImageView = {
        
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if viewModel.image != nil {
            //image, label
            imageView.frame = CGRect(x: 0, y: 0, width: frame.height, height: frame.height)
            label.frame = CGRect(x: 0, y: 0, width: frame.size.width - imageView.frame.width, height: frame.size.height)
        }else {
            
            label.frame = bounds
        }
    }
    
    init(frame: CGRect, viewModel: SnackbarViewModel, viewController : UIViewController) {
        self.viewModel = viewModel
        self.viewController = viewController
        super.init(frame: frame)
        
        var stackView = UIStackView()
        stackView.setup(axis: .horizontal, alignment: .center, distribution: .fillProportionally, spacing: 5, isLayoutMarginsRelativeArrangement: true, layoutMarginsTop: 15, layoutMarginsbottom: 15, layoutMarginsLeft: 15, layoutMarginsRight: 15)
        
        if viewModel.image != nil {
           
            stackView.addArrangedSubview(self.imageView)
            
        }
        stackView.addArrangedSubview(self.label)
        stackView.addTo(self) { maker in
            maker.leading.trailing.bottom.top.equalToSuperview()
            
        }
        
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        configure()
    }
    
    func configure(){
        
        self.label.text = viewModel.text
        self.imageView.image = viewModel.image
        self.backgroundColor = .black.withAlphaComponent(0.7)
        
        switch viewModel.type {
            
        case .action(let handler):
            self.handler = handler
            self.isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapSnackbar))
            gesture.numberOfTapsRequired = 1
            gesture.numberOfTouchesRequired = 1
            addGestureRecognizer(gesture)
            self.backgroundColor = .black.withAlphaComponent(0.5)
            break
            
        case .info:
            break
            
        case .infoError :
            self.backgroundColor = ColorManager.redBlood.withAlphaComponent(0.5)
            break
        }
    }
    
    func showSnackBar(completion: @escaping() -> Void){
        
        let size = viewController.view.frame.size
        self.frame = .zero
        self.addTo(viewController.view) { maker in
            maker.trailing.equalToSuperview().with(trailingMargin: .custom(value: 30))
            maker.leading.equalToSuperview().with(leadingMargin: .custom(value: 30))
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(viewController.view.safeAreaLayoutGuide.snp.bottom).with(bottomMargin: .medium)
        }
        
        UIView.animate(withDuration: 90, animations: {
            
//                        self.frame = CGRect(x: (size.width-width)/2, y: size.height - 70, width: width, height: 60)
            
        }, completion: { done in
            
            if done {
                
                self.dismissSnackBar {
                    completion()
                }
            }
        })
        
    }
    
    func dismissSnackBar(completion: @escaping() -> Void) {
        
        let size = viewController.view.frame.size
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            
            UIView.animate(withDuration: 4, animations: {
//                self.frame = CGRect(x: (size.width-width)/2, y: size.height - 70, width: width, height: 60)
                
            }, completion: { finished in
                
                self.removeFromSuperview()
                completion()
            })
            
        })
        
        
        
    }
    
    @objc func didTapSnackbar(){
        
        
    }
    
}
