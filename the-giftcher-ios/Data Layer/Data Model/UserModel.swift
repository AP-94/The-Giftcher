//
//  UserModel.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 29/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import Foundation

class UserModel: Mappable {
    var id: Int?
    var username: String?
    var name: String?
    var lastName: String?
    var mail: String?
    var password: String?
    var birthday: String?
    var imageName: String?
    var imagePath: String?
    var token: String?
}
