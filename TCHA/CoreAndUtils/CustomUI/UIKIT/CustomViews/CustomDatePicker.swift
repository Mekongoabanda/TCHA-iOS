//
//  CustomDatePicker.swift
//  WeMoney
//
//  Created by Yannick Edouard MEKONGO ABANDA on 09/10/2022.
//

import Foundation
import UIKit
import SnapKit

enum DatePickerFormat: String {
    case month = "MMMM yyyy"
    case day = "dd/MM/yyyy"
    case hourAndDay = "dd/MM/yyyy HH:mm"
}

protocol DatePickerDelegate: AnyObject{
    func chooseNewDate(textField : UITextField, currentDate: Date)
    func dateChanged(currentDate: Date)
}

/// The format a date can use in the form-generated date picker
enum DateType {
    /// complete format
    case hhmmddMMMMYYYY
    /// in-day format
    case hhmm
    // in-year format
    case ddMMMMYYYY
    
    var format: String {
        switch self {
        case .hhmm:
            return "HH:mm"
        case .ddMMMMYYYY:
            return "dd/MM/yyyy"
        case .hhmmddMMMMYYYY:
            return "dd/MM/yyyy HH:mm"
        }
    }
    
    
    func stringFromDate(_ date: Date) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = self.format
        return dateFormatter.string(from: date)
    }
    
    
}

class CustomDatePicker: UIDatePicker{
    
    var dateTF = UITextField()
    var parentView : UIView?
    var selectedDate : Date?
    var type: DateType = .ddMMMMYYYY
    var isShown = false
    let toolbar = UIToolbar()
    
    init(viewController: UIViewController, textField : UITextField, frame: CGRect){
        super.init(frame: frame)
        
        self.dateTF = textField
        self.dateTF.isUserInteractionEnabled = true
        self.parentView = viewController.view
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapDateTextfield))
        gesture.numberOfTapsRequired = 1
        dateTF.addGestureRecognizer(gesture)
        
        self.timeZone = TimeZone.current
        self.backgroundColor = ColorManager.whiteColor
        //Set Mode for Picker
        self.datePickerMode = .date
        
        if #available(iOS 14.0, *) {
            self.preferredDatePickerStyle = .wheels
            self.backgroundColor = ColorManager.whiteColor
        }
        self.maximumDate = Date()
        self.date = Date()
        
        toolbar.sizeToFit()
        //        datePicker.addTarget(self, action: #selector(pickerValueChanged), for: .valueChanged)
        let cancelButton = UIBarButtonItem(title: "Annuler", style: .plain, target: self, action: #selector(cancelDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem:.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Valider", style: .plain, target: self, action: #selector(datePickerDone))
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolbar.tintColor = ColorManager.primaryColor
        toolbar.backgroundColor = ColorManager.whiteColor
        
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: -DatePicker
    func showDatePicker(){
        
        if let parentView = self.parentView {
            
            if self.isShown == false {
                
                self.addTo(parentView, maker: { make in
                    make.bottom.equalTo(parentView.safeAreaLayoutGuide.snp.bottom)
                    make.leading.trailing.equalToSuperview()
                    
                })
            }
        }
        
        dateTF.inputAccessoryView = toolbar
        dateTF.inputView = self
        dateTF.becomeFirstResponder()
        isShown = true
    }
    
    public func setDate(date: Date){
        
        dateTF.text = type.stringFromDate(date)
        selectedDate = date
    }
    
    public func toggleShowing(){
        
        isShown = !isShown
    }
    
    
    @objc func cancelDatePicker(){
        
        self.removeFromSuperview()
        dateTF.resignFirstResponder()
    }
    
    @objc func datePickerDone(){
        
        setDate(date: self.date)
        self.removeFromSuperview()
        dateTF.resignFirstResponder()
    }
    
    //    @objc func textFieldValueChanged(_ sender: UITextField) {
    //
    //        setDate(date: sender.date)
    //
    //    }
    //
    //    @objc func pickerValueChanged(sender: UIDatePicker) {
    //
    //        setDate(date: sender.date)
    //
    //    }
    
    @objc func didTapDateTextfield(_ textField: UITextField) {
        
        if isShown {
            cancelDatePicker()
            toggleShowing()
        }else {
            showDatePicker()
            toggleShowing()
        }
        
    }
    
}

