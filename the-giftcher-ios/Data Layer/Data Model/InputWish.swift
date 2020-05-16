//
//  InputWish.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 01/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import Foundation

class InputWish: Mappable {
    var name: String = ""
    var description: String = ""
    var price: Float?
    var shop: String = ""
    var imageName: String = ""
    var imagePath: String = ""
    var reserved: Bool = false
    var location: String = ""
    var onlineShop: String?
    var category: Int?
    
    
    init(name: String?, description: String?, price: Float?, shop: String?, imageName: String?, imagePath: String?, reserved: Bool?, location: String?, onlineShop: String?, category: Int?) {
        self.name = name ?? ""
        self.description = description ?? ""
        self.price = price
        self.shop = shop ?? ""
        self.imageName = imageName ?? ""
        self.imagePath = imagePath ?? ""
        self.reserved = reserved ?? false
        self.location = location ?? ""
        self.onlineShop = onlineShop ?? ""
        self.category = category
        
    }
    
    var params: [String: Any] {
        return ["name": name,
                "description": description,
                "price": price ?? 0,
                "shop": shop,
                "imageName": imageName,
                "imagePath": imagePath,
                "reserved": reserved,
                "location": location,
                "online_shop": onlineShop ?? "",
                "category": category ?? ""]
    }
}
