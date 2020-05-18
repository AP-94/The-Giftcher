//
//  Session.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 29/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import Foundation

class Session: Codable {
    
    static var current = Session()
    private static let kArchiveKey = "AE4545"
    
    var id: Int?
    var token: String?
    var userName: String?
    var userModel: UserModel?
    var userCategories: [Int?] = []
    
    private init() {

        if let data = UserDefaults.standard.object(forKey: Session.kArchiveKey) as? Data {
            if let savedSession = try? PropertyListDecoder().decode(Session.self, from: data) {
                token = savedSession.token
                userName = savedSession.userName
                id = savedSession.id
                userModel = savedSession.userModel
                userCategories = savedSession.userCategories
            }
        }
    }
    
    static func isValid() -> Bool {
        guard current.token != "" && current.token != nil   else {  return false }
        guard current.userName != "" && current.userName != nil   else {  return false }
        guard current.id != nil   else {  return false }
        
        return true
    }
    
    static func clean(){
        let saveUserCategories = current.userCategories
        UserDefaults.standard.removeObject(forKey: kArchiveKey)
        current = Session()
        current.userCategories = saveUserCategories
        
    }
    
    static func save() {
        if let data = try? PropertyListEncoder().encode(current) {
            UserDefaults.standard.set(data, forKey: kArchiveKey)
        }
    }
}

