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
    var image_names: String = ""
    var image_paths: String = ""
    var reserved: Bool = false
    var location: String = ""
    var online_shop: String?
    var category: Int?
    
    
    init(name: String?, description: String?, price: Float?, shop: String?, image_names: String?, image_paths: String?, reserved: Bool?, location: String?, online_shop: String?, category: Int?) {
        self.name = name ?? ""
        self.description = description ?? ""
        self.price = price
        self.shop = shop ?? ""
        self.image_names = image_names ?? ""
        self.image_paths = image_paths ?? ""
        self.reserved = reserved ?? false
        self.location = location ?? ""
        self.online_shop = online_shop ?? ""
        self.category = category
        
    }
    
    var params: [String: Any] {
        return ["name": name,
                "description": description,
                "price": price,
                "shop": shop,
                "image_names": image_names,
                "image_paths": image_paths,
                "reserved": reserved,
                "location": location,
                "online_shop": online_shop,
                "category": category]
    }
}
