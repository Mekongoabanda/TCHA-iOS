//
//  PickersUIviews.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 19/03/2024.
//

import SwiftUI

struct PickersUIviews: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    PickersUIviews()
}

class DatePickerViewModel: ObservableObject {
    @Published var title : String = "Title of picker"
    @Published var limitDate: PartialRangeFrom<Date> = Date()...
    @Published var inputType: InputTypeTcha = .date
    @Published var showPicker: Bool = false
    @Published var date : Date = Date()
    
    init(title: String, limitDate: PartialRangeFrom<Date>, inputType: InputTypeTcha, showPicker: Bool, date : Date){
        
        self.title = title
        self.limitDate = limitDate
        self.inputType = inputType
        self.showPicker = showPicker
        self.date = date
    }
    
    func modifyAllValues(title: String, limitDate: PartialRangeFrom<Date>, inputType: InputTypeTcha, showPicker: Bool){
        
        self.title = title
        self.limitDate = limitDate
        self.inputType = inputType
        self.showPicker = showPicker
    }
    
    func stringDate() -> String {
        
        if inputType == .date {
            return date.getStringDateWithPlaceHolder()
        }else{
            if let hour = date.getHourNumber(), let min = date.getMinNumber(){
                return "\(hour)h\(min)"
            }else{
                return ""
            }
        }
    }
    
    func toggleVisibility(){
        showPicker.toggle()
    }
    
    init(){
        
    }
}

struct DatePickerSwiftUI: View {
    @StateObject var datePickerViewModel : DatePickerViewModel
    var cancelAction: () -> Void
    var confirmAction: () -> Void
    var body: some View {
        
        VStack{
            datePickerContent()
            datePickerButtons()
        }.background(Color.white)
    }
    
    @ViewBuilder
    func datePickerContent() -> some View{
        VStack(spacing: 0) {
            Text(datePickerViewModel.title)
                .foregroundColor(Color(.primary))
            if datePickerViewModel.inputType == .date {
                DatePicker("", selection: $datePickerViewModel.date, in: datePickerViewModel.limitDate, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
            }else {
                DatePicker("", selection: $datePickerViewModel.date, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
            }
        }
    }
    
    @ViewBuilder
    func datePickerButtons() -> some View{
        HStack(spacing: 14) {
            Spacer()
            Button(action: { cancelAction() }, label: {
                Text("Annuler")
                    .padding(6)
                    .foregroundColor(.red)
            }).background(Color(.grayAppColor3))
                .cornerRadius(10.0)
            
            Button(action: { confirmAction() }, label: {
                Text("Confirmer")
                    .padding(6)
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .bold))
            }).background(Color(.primary))
                .cornerRadius(10.0)
        }.padding(.trailing, 15)
    }
}

struct DatePickerSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var datePickerViewModel : DatePickerViewModel = DatePickerViewModel(title: "Title of Picker", limitDate: Date()..., inputType: .time, showPicker: false, date: Date())
        DatePickerSwiftUI(datePickerViewModel: datePickerViewModel, cancelAction: { print("cancel") }, confirmAction: {print("confirm")})
    }
    
}
