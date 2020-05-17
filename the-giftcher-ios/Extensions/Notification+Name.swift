//
//  Notification+Name.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 15/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//
import Foundation

extension Notification.Name {
    static let didEliminateFriend = Notification.Name("didEliminateFriend")
    static let didAcceptedRequest = Notification.Name("didAcceptedRequest")
    static let didEditWishRequest = Notification.Name("didEditWishRequest")
    static let didEditProfile = Notification.Name("didEditProfile")
}
