//
//  InputUpdatePassword.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 02/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import Foundation
class InputUpdatePassword: Mappable {
    var oldPassword: String = ""
    var newPassword: String = ""
    
    
    init(oldPassword: String?, newPassword: String?) {
        self.oldPassword = oldPassword ?? ""
        self.newPassword = newPassword ?? ""
    }
    
    var params: [String: Any] {
        return ["oldPassword": oldPassword,
                "newPassword": newPassword]
    }
}
