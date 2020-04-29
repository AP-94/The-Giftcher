//
//  InputLogin.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 29/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import Foundation

class InputLogin: Mappable {
    var email: String = ""
    var pass: String = ""
    
    init(email: String?, pass: String?) {
        self.email = email ?? ""
        self.pass = pass ?? ""
    }
    
    var params: [String: Any] {
        return ["email":email, "password": pass]
    }
}
