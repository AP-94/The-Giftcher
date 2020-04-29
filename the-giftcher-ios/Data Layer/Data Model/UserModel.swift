//
//  UserModel.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 29/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import Foundation

class UserModel: Mappable {
    var id: String = ""
    var username: String? = ""
    var name: String? = ""
    var last_name: String? = ""
    var birthday: Date?
    var image_name: String? = ""
    var image_path: String? = ""
    var token: String? = ""
}
