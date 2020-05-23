//
//  InputReservedWish.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 05/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import Foundation
class InputReservedWish: Mappable {
    var friendId: Int?
    var wishId: Int?
    
    init(friendId: Int?, wishId: Int?) {
        self.friendId = friendId
        self.wishId = wishId
    }
    
    var params: [String: Any] {
        return ["friendId": friendId,
                "wishId": wishId]
    }
}
