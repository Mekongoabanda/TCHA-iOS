//
//  StringExtension.swift
//  WeMoney
//
//  Created by Yannick Edouard MEKONGO ABANDA on 07/10/2022.
//

import Foundation
import UIKit

extension String {
    var bool: Bool? {
        switch self.lowercased() {
        case "true":
            return true
        case "false":
            return false
        default:
            return nil
        }
    }
    
    func isEmptyOrContainsOnlySpaces() -> Bool{
        return self.replacingOccurrences(of: "\\s", with: "", options: .regularExpression).isEmpty
    }
    
    public func checkIfEMailWithCorrectFormat()->Bool{
        // here, `try!` will always succeed because the pattern is valid
                let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
                return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    public func checkIfCorrectFrenchPhoneNumberFormat()->Bool{
        let phoneRegEx = "^(?:(?:\\+|00)33|0)\\s*[1-9](?:[\\s.-]*\\d{2}){4}$"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: self)
    }
    
    public func checkIfDateStringIsCorrect(format : String) -> Bool{
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = format
        let someDate = self

        if dateFormatterGet.date(from: someDate) != nil {
            return true
        } else {
            return false
        }
    }
    
    public func checkIfCorrectInternationalPhoneNumberFormat()->Bool{
        let phoneRegEx = "^\\+(?:[0-9] ?){6,14}[0-9]$"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: self)
    }
    
    public func checkIfCorrectInternationalPhoneNumberFormatWithoutPlus()->Bool{
        let phoneRegEx = "^00(?:[0-9] ?){6,14}[0-9]$"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: self)
    }

    
    
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    
    func containsIgnoreCase(_ compare:String) -> Bool
    {
        return self.uppercased().contains(compare.uppercased())
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard
            let data = self.data(using: .utf8)
            else { return nil }
        do {
            return try NSAttributedString(data: data, options: [
                NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil)
        } catch let error as NSError {
            return  nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func localized(tableName: String) -> String {
        if !getCustomString().isEmpty {
            return getCustomString()
        }
        return NSLocalizedString(self, tableName: tableName, bundle: Bundle.main, value: "", comment: "")
    }
    
    private func getCustomString() -> String {
        var value : String = ""
        
        if let filePath = Bundle.main.path(forResource: "customStrings", ofType: "plist"){
            let plist = NSDictionary(contentsOfFile:filePath)
            if let valueSafe = plist?.object(forKey: self) as? String {
                value = valueSafe
            }
        }
        return value
    }
    
    
    func localizedWithParam(tableName: String, _ param: String) -> String {
        
        return String.localizedStringWithFormat(NSLocalizedString(self, tableName: tableName, bundle: Bundle.main, value: "", comment: ""), param)
    }
    
    
    var isBackspace: Bool {
        let char = self.cString(using: String.Encoding.utf8)!
        return strcmp(char, "\\b") == -92
    }
    
    
    
    func transformingFromHex() -> String? {
        return "&#x\(self.uppercased());".applyingTransform(.toXMLHex, reverse: true)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    
    // Returns true if the String starts with a substring matching to the prefix-parameter.
    // If isCaseSensitive-parameter is true, the function returns false,
    // if you search "sA" from "San Antonio", but if the isCaseSensitive-parameter is false,
    // the function returns true, if you search "sA" from "San Antonio"
    
    func hasPrefixCheck(prefix: String, isCaseSensitive: Bool) -> Bool {
        
        if isCaseSensitive == true {
            return self.hasPrefix(prefix)
        } else {
            var thePrefix: String = prefix, theString: String = self
            
            while thePrefix.count != 0 {
                if theString.count == 0 { return false }
                if theString.lowercased().first != thePrefix.lowercased().first { return false }
                theString = String(theString.dropFirst())
                thePrefix = String(thePrefix.dropFirst())
            }; return true
        }
    }
    
    //compare String with
    func containWithEscapedAndCaseIrrelevent(_ otherString : String) -> Bool {
        return  self.toNoSmartQuotes().containsIgnoreCase(otherString.toNoSmartQuotes())
    }
    
    //Compare two String without accent or case
    func toNoSmartQuotes() -> String {
        let userInput: String = self
        return userInput.folding(options: .diacriticInsensitive, locale: .current)
    }
    
    //separate String by character in Strings
    func stringsSeparateBy(_ sequence : Character) -> [String] {
        let subStrings = self.split(separator: sequence)
        return subStrings.map { (subString) -> String in
            return String(subString)
        }
    }
    
    //Test if the string containt one of the String in parameter
    func containOneOf(_ otherStrings : [String]) -> Bool {
        for otherString in otherStrings {
            if self.containWithEscapedAndCaseIrrelevent(otherString) {
                return true
            }
        }
        return false
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func replaceFirstOccurenceOf(charToReplace: String, replacingChar: String) -> String {
        
        if charToReplace.count == 1 {
            let subSequence = self.split(separator: Character(charToReplace), maxSplits: 1, omittingEmptySubsequences: false)
            
            return subSequence.joined(separator: replacingChar)
        }
        return self
    }
    

    func containsNumber() -> Bool{
        
        let numberRegEx  = ".*[0-9]+.*"
        let testCase = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let containsNumber = testCase.evaluate(with: self)
        
        return containsNumber
    }
    
    func containsCharacters() -> Bool{
        
        let alphaRegEx  = ".*[a-z A-Z]+.*"
        let testCase = NSPredicate(format:"SELF MATCHES %@", alphaRegEx)
        let containsNumber = testCase.evaluate(with: self)
        
        return containsNumber
    }
    

    
    func deletePrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    func regex(pattern: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
            let nsstr = self as NSString
            let all = NSRange(location: 0, length: nsstr.length)
            var matches : [String] = [String]()
            regex.enumerateMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: all) {
                (result : NSTextCheckingResult?, _, _) in
                if let r = result {
                    let result = nsstr.substring(with: r.range) as String
                    matches.append(result)
                }
            }
            return matches
        } catch {
            return [String]()
        }
    }
    
    func toBase64() -> String{
        return Data(self.utf8).base64EncodedString()
    }

    subscript(_ i: Int) -> String {
        let idx1 = index(startIndex, offsetBy: i)
        let idx2 = index(idx1, offsetBy: 1)
        return String(self[idx1..<idx2])
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }
    
    subscript (r: CountableClosedRange<Int>) -> String {
        let startIndex =  self.index(self.startIndex, offsetBy: r.lowerBound)
        let endIndex = self.index(startIndex, offsetBy: r.upperBound - r.lowerBound)
        return String(self[startIndex...endIndex])
    }
    
    func stringByAddingPercentEncodingForRFC3986() -> String? {
      let unreserved = "-._~/?"
      let allowed = NSMutableCharacterSet.alphanumeric()
      allowed.addCharacters(in: unreserved)
      return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
    }
    
    func getDateAndTime() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self) // replace Date String
    }
    
    
    
    /// transform "tableId@objectId" to (tableId, objectId) or nil if self is not splitable
    func toSplittedDocumentId() -> (tableId: String, objectId: String)?{
        let splittedIds = self.components(separatedBy: "@")
        if splittedIds.count > 1{
            return (tableId: splittedIds[0], objectId: splittedIds[1])
        }else{
            return nil
        }
    }
    
}

extension Locale {
    static var preferredLanguage: String {
        get {
            return self.preferredLanguages.first ?? "en"
        }
        set {
            UserDefaults.standard.set([newValue], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
        }
    }
}
