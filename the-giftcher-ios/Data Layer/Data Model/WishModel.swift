//
//  Wish.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 01/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import Foundation

class WishModel: Mappable {
    var id: Int?
    var userId: Int?
    var name: String?
    var description: String?
    var price: Float?
    var shop: String?
    var imageName: String?
    var imagePath: String?
    var reserved: Bool?
    var location: String?
    var onlineShop: String?
    var category: Int?
    var date: Date?
}

