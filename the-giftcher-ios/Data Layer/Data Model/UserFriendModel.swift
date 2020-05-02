//
//  UserFriendModel.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 02/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import Foundation

class UserFriendModel: Mappable {
    var id: Int?
    var friendId: Int?
    var username: String?
    var name: String?
    var lastName: String?
    var mail: String?
    var birthday: String?
    var imageName: String?
    var imagePath: String?
}
