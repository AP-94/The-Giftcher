//
//  InputFriendRequest.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 04/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import Foundation
class InputFriendRequest: Mappable {
    var friendRequestId: Int?
    
    init(friendRequestId: Int?) {
        self.friendRequestId = friendRequestId
    }
    
    var params: [String: Any] {
        return ["friendRequestId": friendRequestId!]
    }
}
