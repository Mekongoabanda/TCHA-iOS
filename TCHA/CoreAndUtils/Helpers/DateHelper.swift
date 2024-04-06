//
//  DateHelper.swift
//  WeMoney
//
//  Created by Yannick Edouard MEKONGO ABANDA on 07/10/2022.
//

import Foundation

enum DateEnum {
    case TODAY
    case YESTERDAY
    case THISWEEK
    case OLDER
}

class DateHelper {
    
    static func relativePast(for date : Date) -> String {
        
        let calendar = Calendar.current
        let currentDate = Date()
        
        if calendar.component(.year, from: date) == calendar.component(.year, from: currentDate)
            && calendar.component(.month, from: date) == calendar.component(.month, from: currentDate)
            && calendar.component(.day, from: date) == (calendar.component(.day, from: currentDate) - 1) {
            return "Hier"
        }
        
        if calendar.component(.year, from: date) == calendar.component(.year, from: currentDate)
            && calendar.component(.month, from: date) == calendar.component(.month, from: currentDate)
            && calendar.component(.day, from: date) == calendar.component(.day, from: currentDate){
            return formatShortHour(date: date)
        }
        
        return formatShortDate(date: date)
    }
    
    static func relativePastDateHour(for date : Date) -> String {
        
        let calendar = Calendar.current
        let currentDate = Date()
        
        if calendar.component(.year, from: date) == calendar.component(.year, from: currentDate)
            && calendar.component(.month, from: date) == calendar.component(.month, from: currentDate)
            && calendar.component(.day, from: date) == (calendar.component(.day, from: currentDate) - 1) {
            return "Hier à \(formatShortHour(date: date))"
        }
        
        if calendar.component(.year, from: date) == calendar.component(.year, from: currentDate)
            && calendar.component(.month, from: date) == calendar.component(.month, from: currentDate)
            && calendar.component(.day, from: date) == calendar.component(.day, from: currentDate){
            return formatShortHour(date: date)
        }
        
        return formatDateHour(date: date)
    }
    
    static func ordinalShortDateFormat(for date : Date) -> String {
        
        let calendar = Calendar.current
        let currentDate = Date()
        
        if calendar.component(.year, from: date) == calendar.component(.year, from: currentDate)
            && calendar.component(.month, from: date) == calendar.component(.month, from: currentDate)
            && calendar.component(.day, from: date) == (calendar.component(.day, from: currentDate) - 1) {
            return "Hier"
        }
        
        if calendar.component(.year, from: date) == calendar.component(.year, from: currentDate)
            && calendar.component(.month, from: date) == calendar.component(.month, from: currentDate)
            && calendar.component(.day, from: date) == calendar.component(.day, from: currentDate){
            return "Aujourd'hui"
        }
        
        return formatShortDate(date: date)
    }
    
    static func ordinalShortDateHourFormat(for date : Date) -> String {
        
        let calendar = Calendar.current
        let currentDate = Date()
        
        if calendar.component(.year, from: date) == calendar.component(.year, from: currentDate)
            && calendar.component(.month, from: date) == calendar.component(.month, from: currentDate)
            && calendar.component(.day, from: date) == (calendar.component(.day, from: currentDate) - 1) {
            return "Hier à \(formatShortHour(date: date))"
        }
        
        if calendar.component(.year, from: date) == calendar.component(.year, from: currentDate)
            && calendar.component(.month, from: date) == calendar.component(.month, from: currentDate)
            && calendar.component(.day, from: date) == calendar.component(.day, from: currentDate){
            return "Aujourd'hui à \(formatShortHour(date: date))"
        }
        
        return "Le \(formatShortDate(date: date)) à \(formatShortHour(date: date))"
    }
    
    
    static func formatShortDate(date: Date) -> String {
        let formatter       = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.locale    = Locale(identifier: "FR-fr")
        return formatter.string(from: date)
    }
    
    static func formatShortHour(date: Date) -> String {
        let formatter       = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.locale    = Locale(identifier: "FR-fr")
        return formatter.string(from: date).replaceFirstOccurenceOf(charToReplace: ":", replacingChar: "h")
    }
    
    static func formatDateHour(date: Date) -> String {
        let formatter       = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.locale    = Locale(identifier: "FR-fr")
        return formatter.string(from: date).replaceFirstOccurenceOf(charToReplace: ":", replacingChar: "h")
    }
    
    
    static func fromDateToString(date: Date) -> String{
        let formatter       = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        formatter.locale    = Locale(identifier: "FR-fr")
        return formatter.string(from: date)
    }
    
    static func getAgeFromBirthDate(birthDate: Date) -> Int{
        let calendar = Calendar.current
        let currentDate = Date()
        
        let component = calendar.dateComponents([.year], from: birthDate, to:currentDate)
        if let age = component.year {
            return age
        }else{
            let currentMonth = calendar.component(.month, from: currentDate)
            let currentDay = calendar.component(.day, from: currentDate)
            
            let birthMonth = calendar.component(.month, from: birthDate)
            let birthDay = calendar.component(.day, from: birthDate)
            
            
            var age = calendar.component(.year, from: currentDate) - calendar.component(.year, from: birthDate)
            if (currentMonth < birthMonth) || (currentMonth == birthMonth && currentDay < birthDay) {
                age -= 1
            }
            
            return age
        }
    }
    
    static func getDateFromString(dateString: String, format: String = "dd/MM/yyyy", applyZuluTimezone: Bool = false) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "FR-fr")
        if applyZuluTimezone {
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // less typo prone
        }
        return dateFormatter.date(from: dateString)
    }
    
    static func getSimpleStringFrom(date: Date, applyZuluTimezone: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "FR-fr")
        if applyZuluTimezone {
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // less typo prone
        }
        return dateFormatter.string(from: date)
    }
    
    
    static func getStringDateWithFormat(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "FR-fr")
        return dateFormatter.string(from: date)
    }
    
    static func getEnumDateFromDate(date: Date) -> DateEnum {
        
        var calendar = Calendar.current
        //Set first day of week to Monday
        calendar.firstWeekday = 2
        
        let currentDate = Date()
        
        if Calendar.current.isDateInToday(date){
            return DateEnum.TODAY
        }
        
        if Calendar.current.isDateInYesterday(date) {
            return DateEnum.YESTERDAY
        }
        
        if calendar.component(.weekOfYear, from: date) == (calendar.component(.weekOfYear, from: currentDate)) {
            return DateEnum.THISWEEK
        }
        
        return DateEnum.OLDER
        
    }
    
    static func getDaysInMonth(month: Int, year: Int) -> Int{
        
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays
    }
    
    static func generateDate(day: Int, month: Int, year: Int) -> Date {
        
        // Specify date components
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.timeZone = TimeZone.current
        
        
        // Create date from components
        let userCalendar = Calendar.current // user calendar
        guard let composedDate = userCalendar.date(from: dateComponents) else { return Date() }
        
        return composedDate
    }
    
    static func getYearFrom(date: Date) -> Int? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: date)
        let year = components.year
        
        return year
    }
    
    static func getMinuteFrom(date: Date) -> Int? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: date)
        let hour = components.minute
        
        return hour
    }
    
    static func getHourFrom(date: Date) -> Int? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: date)
        let hour = components.hour
        
        return hour
    }
    static func getDayFrom(date: Date) -> Int? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        let day = components.day
        
        return day
    }
    
    static func getMonthFrom(date: Date) -> Int? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: date)
        let month = components.month
        
        return month
    }
    
    
    static func formatDateToDate(date: Date) -> Date?{
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd/MM/yyyy HH:mm Z"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm Z"
        let dateString = dateFormatter.string(from: date)
        
        return dateFormatterGet.date(from: dateString)
    }
    
    static func formatDateToDMYHMShortYear(date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy à HH:mm"
        return dateFormatter.string(from: date)
    }
    
    static func formatDateToDMYHMSShortYear(date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy à HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    
    /**
     * convert from double to date, a value in a given period of time
     */
    static func convertDoubleToDateInPeriod(doubleVal: Double, startDate: Date, endDate:Date) -> Date{
        
        let intValue = Int(doubleVal)
        if(doubleVal == Double(intValue)){
            return startDate
        }
        
        let fVal = doubleVal - Double(intValue)
        
        let daysBetween = DateHelper.getDaysNumberBetweenDates(startDate: startDate, endDate: endDate)
        
        let dateVal = fVal * Double(daysBetween)
        let day = Int(dateVal)
        
        var hourLeft = (dateVal - Double(day))
        var hourInterval = 24
        if(daysBetween == 0){
            hourLeft = fVal
            if let startDateHours = DateHelper.getHourFrom(date: startDate), let endDateHours = DateHelper.getHourFrom(date: endDate){
                //hourInterval = endDateHours - startDateHours
                if endDateHours == 23 && startDateHours == 0{
                    hourInterval = 24
                }
                else{
                    hourInterval = endDateHours - startDateHours
                }
            }
            
        }
        
        let hourVal = hourLeft * Double(hourInterval)
        let hour : Int = Int(hourVal)
        var minute = round((hourVal-Double(hour))*60)
        if(minute > 59){
            minute = 59
        }
        
        
        //val date = OffsetDateTime.now()
        return startDate.addDaysToDate(days: day).addHoursToDate(hours: hour).addMinutesToDate(minutes: Int(minute))
    }
    
    
    /**
     * convert into Double the ratio of the date into a period
     */
    static func convertDateToDoubleInPeriod(date: Date, startDate:Date, endDate:Date, offset:Int=0) -> Double{
        
        let periodDays = DateHelper.getDaysNumberBetweenDates(startDate: startDate, endDate: endDate)
        let daysAfterStart = DateHelper.getDaysNumberBetweenDates(startDate: startDate, endDate: date)
        
        var days : Double = 0.0
        var hourInterval = 24  // by default interval is 24h
        var hourOffset = 0     // offset of hour
        
        if(daysAfterStart == 0){
            if let startDateHour = DateHelper.getHourFrom(date: startDate), let endDateHour = DateHelper.getHourFrom(date: endDate){
                if endDateHour == 23 && startDateHour == 0{
                    hourInterval = 24
                }
                else{
                    hourInterval = endDateHour - startDateHour
                }
                // calc hour between start and date
                hourOffset = startDateHour
            }
            
        }
        
        var hour : Double = 0.0
        if let dateHour = DateHelper.getHourFrom(date: date), let dateMinute = DateHelper.getMinuteFrom(date: date){
            if hourInterval == 0 {
                hourInterval = 24
            }
            hour = Double((Double(dateHour) + Double(dateMinute)/60.0 - Double(hourOffset))/Double(hourInterval))
        }
        
        if(periodDays != 0){
            days = Double(daysAfterStart)/Double(periodDays)
            hour = hour/(Double(periodDays*hourInterval))
            if days == 1 {
                hour = 0
            }
        }
        
        return days + hour + Double(offset)
    }
    
    /**
     * get the number of days between 2 dates
     */
    static func getDaysNumberBetweenDates(startDate: Date, endDate: Date) -> Int{
        let calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: startDate)
        let date2 = calendar.startOfDay(for: endDate)
        
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day ?? 0
    }
    
    /**
     * get the number of minutes between 2 dates
     */
    static func getMinutesNumberBetweenDates(startDate: Date, endDate: Date) -> Int{
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.minute], from: startDate, to: endDate)
        return components.minute ?? 0
    }
    
    /**
     * get the number of hours between 2 dates
     */
    static func geHoursNumberBetweenDates(startDate: Date, endDate: Date) -> Int{
        let calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: endDate)
        let date2 = calendar.startOfDay(for: startDate)
        
        
        let components = calendar.dateComponents([.hour], from: date1, to: date2)
        return components.hour ?? 0
    }
    
    
    /**
     * get date on string format dd/mm
     * param date : has a format  dd/mm/yyyy
     **/
    static func getDayMonthDateFrom(date: String) -> String { // format (dd/mm/yyyy)
        
        var formatedDate = ""
        let dateSubstrings = date.split(separator: "/")
        let day = String(dateSubstrings[0])
        let month = String(dateSubstrings[1])
        formatedDate.append(day)
        formatedDate.append("/")
        formatedDate.append(month)
        
        return formatedDate
    }
    
    static func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    static func isEqualDatesByDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        let order = calendar.compare(date1, to: date2, toGranularity: .day)
        switch order {
        case .orderedSame:
            return true
        default:
            return false
        }
    }
    
    static func compareByDay(_ date: Date, to: Date) -> ComparisonResult {
        let calendar = Calendar.current
        return calendar.compare(date, to: to, toGranularity: .day)
    }
}
