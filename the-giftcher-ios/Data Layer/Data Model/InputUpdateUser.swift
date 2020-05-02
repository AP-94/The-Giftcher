//
//  InputUpdateUser.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 02/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import Foundation

class InputUpdateUser: Mappable {
    var name: String = ""
    var username: String = ""
    var lastName: String = ""
    var birthday: String = ""
    
    
    init(name: String?, username: String?, lastName: String?, birthday: String?) {
        self.name = name ?? ""
        self.username = username ?? ""
        self.lastName = lastName ?? ""
        self.birthday = birthday ?? ""
    }
    
    var params: [String: Any] {
        return ["username":username,
                "name": name,
                "lastName": lastName,
                "birthday": birthday]
    }
}
