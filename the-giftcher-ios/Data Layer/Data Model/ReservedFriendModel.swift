//
//  ReservedFriendModel.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 05/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import Foundation

class ReservedFriendModel: Mappable {
    var friendId: Int?
    var friendName: String?
    var friendReservedWishes: [WishModel]?
}
