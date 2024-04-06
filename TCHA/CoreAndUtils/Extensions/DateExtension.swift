//
//  DateExtension.swift
//  WeMoney
//
//  Created by Yannick Edouard MEKONGO ABANDA on 07/10/2022.
//

import Foundation

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: startOfDay)
        return Calendar.current.date(from: components)!
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth)!
    }
    
    func addSecondsToDate(seconds: Int) -> Date{
        return Calendar.current.date(byAdding: .second, value: seconds, to: self) ?? self
    }
    
    func addMinutesToDate(minutes: Int) -> Date{
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self) ?? self
    }
    
    func addHoursToDate(hours: Int) -> Date{
        return Calendar.current.date(byAdding: .hour, value: hours, to: self) ?? self
    }
    
    func addDaysToDate(days: Int) -> Date{
        return Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
    }
    
    func addYearsToDate(years: Int) -> Date{
        return Calendar.current.date(byAdding: .year, value: years, to: self) ?? self
    }
    
    func getNextDay() -> Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }
    
    func getPreviousDay() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)
    }
    func getPreviousXDays(x:Int) -> Date?{
        return Calendar.current.date(byAdding: .day, value: -x, to: self)
    }
    
    func getNextMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)
    }
    
    func getPreviousMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }
    
    func getPreviousXMonth(x:Int) -> Date?{
        return Calendar.current.date(byAdding: .month, value: -x, to: self)
    }
    
    func getNextYear() -> Date? {
        return Calendar.current.date(byAdding: .year, value: 1, to: self)
    }
    
    func getPreviousYear() -> Date? {
        return Calendar.current.date(byAdding: .year, value: -1, to: self)
    }
    
    func setTimeComponents(hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        
        let calendar = Calendar.current
        var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        component.hour = hours
        component.minute = minutes
        component.second = seconds
        return Calendar.current.date(from: component) ?? self
        
        
        //        if let date = Calendar.current.date(bySettingHour: hours, minute: minutes, second: seconds, of: self){
        //            return date
        //        }
        //        return self
    }
    
    func setDateDay(day: Int) -> Date {
        let calendar = Calendar.current
        var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        component.day = day
        return Calendar.current.date(from: component) ?? self
        
//        if let date = Calendar.current.date(bySetting: .day, value: day, of: self){
//            return date
//        }
//        return self
    }
    
    func setDateMonth(month: Int) -> Date {
        
        let calendar = Calendar.current
        var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        component.month = month
        return Calendar.current.date(from: component) ?? self
        
//        if let date = Calendar.current.date(bySetting: .month, value: month, of: self){
//            return date
//        }
//        return self
    }
    
    var startOfWeek: Date? {
        let calendar = Calendar.current
        let components: DateComponents? = calendar.dateComponents([.weekday, .year, .month, .day], from: self)
        var modifiedComponent = components
        modifiedComponent?.day = (components?.day ?? 0) - ((components?.weekday ?? 0) - 2)
        modifiedComponent?.weekday = 2
        
        return calendar.date(from: modifiedComponent!)
    }
    
    var endOfWeek: Date? {
        let calendar = Calendar.current
        let components: DateComponents? = calendar.dateComponents([.weekday, .year, .month, .day], from: self)
        var modifiedComponent = components
        modifiedComponent?.day = (components?.day ?? 0) + (8 - (components?.weekday ?? 0))
        modifiedComponent?.weekday = 8
        //           modifiedComponent?.hour = 23
        //           modifiedComponent?.minute = 59
        //           modifiedComponent?.second = 59
        
        return calendar.date(from: modifiedComponent!)
        
    }
    
    var weekDayIndex : Int{
        return Calendar.current.component(.weekday, from: self)
    }
    
    var numberOfDaysByMonth : Int {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: self)!
        let numDays = range.count
        return numDays
    }
    
    //    func getWeekLowedBound(){
    //        var calendar = Calendar.current
    //        calendar.firstWeekday = 2
    //        let today = calendar.startOfDay(for: self)
    //        let dayOfWeek = calendar.component(.weekday, from: today)
    //        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: today)!
    //
    //        let firstDayInWeek  = weekdays.lowerBound
    //
    //    }
    
    
    func getYearNumber() -> Int?{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: self)
        return components.year
    }
    
    func getMonthNumber(offset : Int) -> Int?{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: self)
        if let month = components.month {
            return month + offset
        }
        return nil
    }
    
    func getMonthNumberOnly() -> Int?{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: self)
        if let month = components.month {
            return month
        }
        return nil
    }
    
    func getDayNumber() -> Int?{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self)
        return components.day
    }
    
    func getMinNumber() -> Int?{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: self)
        return components.minute
    }
    
    func getHourNumber() -> Int?{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: self)
        return components.hour
    }
    
    func getSecNumber() -> Int?{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.second], from: self)
        return components.second
    }
    
    func getStringDateWithPlaceHolder(placeHolder : String = "") -> String{
        let birthDateFixed = self
        if let day = birthDateFixed.getDayNumber(), let month = birthDateFixed.getMonthNumberOnly(), let year = birthDateFixed.getYearNumber() {
            let birthDate = DateHelper.generateDate(day: day, month: month, year: year)
            let age = DateHelper.getAgeFromBirthDate(birthDate: birthDate)
            let dateString = DateHelper.getStringDateWithFormat(date: birthDate, format: DatePickerFormat.day.rawValue)
            return dateString
        }
        return placeHolder
    }
    
    static let formatterDateAndTime: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "MM-dd-yyyy HH:mm"
      return formatter
    }()
    
}
