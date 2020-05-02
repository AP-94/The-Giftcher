//
//  String+Utils.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 29/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import Foundation

extension String {
    
    var isNumeric: Bool {
        return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    var isValidPhone: Bool {
        let phoneRegEx = "^(?:(\\+))*[0-9]{6,14}$"
        return NSPredicate(format:"SELF MATCHES %@", phoneRegEx).evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let passwordRegEx = "((?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#!$%]).{8,20})"
        return NSPredicate(format:"SELF MATCHES %@", passwordRegEx).evaluate(with: self)
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: self)
    }

    var isValidUrl: Bool {
        let emailRegEx = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: self)
    }

    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func toDouble() -> Double? {
        if self.contains("."){
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "en_GB")
            formatter.numberStyle = .decimal
            let number = formatter.number(from: self)
            return number as? Double ?? 0.0
        }else{
            return NumberFormatter().number(from: self)?.doubleValue
        }
        
    }
    
    func toInt() -> Int? {
        return NumberFormatter().number(from: self)?.intValue
    }

    
}
