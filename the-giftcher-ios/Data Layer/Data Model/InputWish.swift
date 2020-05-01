//
//  InputWish.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 01/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import Foundation

class InputWish: Mappable {
    var name: String = ""
    var username: String = ""
    var lastName: String = ""
    var mail: String = ""
    var password: String = ""
    var birthday: String = ""
    
    
    init(name: String?, username: String?, lastName: String?, mail: String?, password: String?, birthday: String?) {
        self.name = name ?? ""
        self.username = username ?? ""
        self.lastName = lastName ?? ""
        self.mail = mail ?? ""
        self.password = password ?? ""
        self.birthday = birthday ?? ""
    }
    
    var params: [String: Any] {
        return ["username":username,
                "password": password,
                "name": name,
                "lastName": lastName,
                "mail": mail,
                "birthday": birthday]
    }
}
