//
//  DataMapper.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 29/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import NotificationBannerSwift

class DataMapper {
    typealias DataMapperCompletion = (_ success: Bool?,_ result: Any?, _ error: Error?) -> Void
    
    let locale = "es"
    let timestamp = NSDate().timeIntervalSince1970
    let session = Session.current
    var connection: RestManager = Connection()
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    
    func checkHttpStatus(httpCode: Int) -> Bool{
        
        switch httpCode {
        case 200..<299:
            return true
        case 401:
            print("problema de autorizacion, password o user incorrecto")
            let banner = NotificationBanner(title: "Error", subtitle: "Usuario o contreseña incorrecta", style: .danger)
            banner.show()
            return false
        case 403:
            Session.clean()
            print("Aquí deberiamos enviar al usuario a log in")
            return false
        case 404:
            let banner = NotificationBanner(title: "Not Found", subtitle: "Error al intentar ejecutar la acción", style: .warning)
            banner.show()
            print("Not Found")
            return false
        case 406:
            let banner = NotificationBanner(title: "Not Found", subtitle: "Ningún usuario registrado con ese email", style: .warning)
            banner.show()
            print("Not Found")
            return false
        case 409:
            let banner = NotificationBanner(title: "Error", subtitle: "Error inesperado, vuelve a intentarlo", style: .warning)
            banner.show()
            print("Error de usuario existente")
            return false
        case 460...499:
            let banner = NotificationBanner(title: "Error", subtitle: "Error inesperado, vuelve a intentarlo", style: .warning)
            banner.show()
            print("error interno sin especificar")
            return false
        case 500...503:
            let banner = NotificationBanner(title: "Error", subtitle: "No hay conexión con el servidor", style: .warning)
            banner.show()
            print("network down")
            return false
        case 0:
            let banner = NotificationBanner(title: "Error", subtitle: "No hay conexión con el servidor", style: .warning)
            banner.show()
            print("no hay conexión")
            return false
        default:
            let banner = NotificationBanner(title: "Error", subtitle: "Error de conexión", style: .warning)
            banner.show()
            print("Error de conexión")
            return false
        }
    }
    
    //MARK:: USERS REQUESTS --------------------------------------------------------------
    
    func loginRequest(fake: String? = nil, inputLogin: InputLogin , completion: @escaping DataMapperCompletion) {
        
        var url = "/user/login"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.postWithoutToken(url, params: inputLogin.params, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let result = UserModel(jsonData: try? json.rawData())
                completion(true, result, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    func registerRequest(fake: String? = nil, inputRegister: InputRegister , completion: @escaping DataMapperCompletion) {
        
        var url = "/user/register"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.postWithoutToken(url, params: inputRegister.params, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let result = UserModel(jsonData: try? json.rawData())
                completion(true, result, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    func getAllUsersRequest(fake: String? = nil, completion: @escaping DataMapperCompletion) {
        
        var url = "/user/get_users"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.getWithoutParams(url, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let array = json.arrayValue.compactMap {
                    return UserModel(jsonData: try? $0.rawData())
                }
                completion(true, array, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    func getUserByIdRequest(fake: String? = nil, id: Int?, completion: @escaping DataMapperCompletion) {
        
        var url = "/user/\(String(describing: id))"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.getWithoutParams(url, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let user = UserModel(jsonData: try? json.rawData())
                completion(true, user, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    func addProfileImageRequest(fake: String? = nil, inputProfileImage: InputProfileImage , completion: @escaping DataMapperCompletion) {
        
        var url = "/user/google_cloud_image"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        //Invesitgar como enviar imagen swift, con este imageUploadRequest tenemos que enviar paramentros e Data, buscar más informacion de como
        //convertir una imagen en swift en estos 2 aspectos
        /*connection.imageUploadRequest(url, encode: JSONEncoding.default) {
         httpStatus, json, responseHeaders, error in
         
         if self.checkHttpStatus(httpCode: httpStatus), let json = json {
         let result = UserModel(jsonData: try? json.rawData())
         completion(true, result, nil)
         } else {
         completion(false ,nil, error)
         }
         }*/
    }
    
    func forgotPasswordRequest(fake: String? = nil, email: String? , completion: @escaping DataMapperCompletion) {
        
        var url = "/user/reset_password?userMail=\(email!)"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        let parameters: Parameters = [
            "userMail": email!]
        
        connection.postWithoutToken(url, params: parameters ,encode: URLEncoding.queryString) {
            httpStatus, json, responseHeaders, error in
            if self.checkHttpStatus(httpCode: httpStatus), let json = json{
                let result = SingletonModel(jsonData: try? json.rawData())
                completion(true, result, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    func updateUserRequest(fake: String? = nil, inputUpdateUser: InputUpdateUser , completion: @escaping DataMapperCompletion) {
        
        var url = "/user/update"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.put(url, params: inputUpdateUser.params, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let updatedUser = UserModel(jsonData: try? json.rawData())
                completion(true, updatedUser, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    func updateUserPasswordRequest(fake: String? = nil, inputUpdatePassword: InputUpdatePassword , completion: @escaping DataMapperCompletion) {
        
        var url = "/user/update_password"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.put(url, params: inputUpdatePassword.params, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let updatedUserPassword = UserModel(jsonData: try? json.rawData())
                completion(true, updatedUserPassword, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    func deleteUserRequest(fake: String? = nil, completion: @escaping DataMapperCompletion) {
        
        var url = "/user/delete_account"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.delete(url, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let result = SingletonModel(jsonData: try? json.rawData())
                completion(true, result, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    //MARK:: WISH REQUESTS --------------------------------------------------------------
    
    func oneWishRequest(fake: String? = nil, id: Int? , completion: @escaping DataMapperCompletion) {
        
        var url = "/wishes/\(String(describing: id!))"
        
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.getWithoutParams(url, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let result = WishModel(jsonData: try? json.rawData())
                completion(true, result, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    func getAllWishesRequest(fake: String? = nil, completion: @escaping DataMapperCompletion) {
        
        var url = "/wishes/all_wishes"
        
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.getWithoutParams(url, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let result = json.arrayValue.compactMap {
                    return WishModel(jsonData: try? $0.rawData())
                }
                completion(true, result, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    func getAllWishesByCategoryIdRequest(fake: String? = nil, categoryId: Int?, completion: @escaping DataMapperCompletion) {
        
        var url = "/wishes/categories/\(String(describing: categoryId))"
        
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.getWithoutParams(url, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let array = json.arrayValue.compactMap {
                    return WishModel(jsonData: try? $0.rawData())
                }
                completion(true, array, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    func getAllWishesOfUserRequest(fake: String? = nil, completion: @escaping DataMapperCompletion) {
        
        var url = "/wishes/"
        
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.getWithoutParams(url, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let array = json.arrayValue.compactMap {
                    return WishModel(jsonData: try? $0.rawData())
                }
                completion(true, array, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    func wishModifyRequest(fake: String? = nil, idWish: Int?, inputWish: InputWish , completion: @escaping DataMapperCompletion) {
        
        var url = "/wishes/\(String(describing: idWish!))"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.put(url, params: inputWish.params, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let result = WishModel(jsonData: try? json.rawData())
                completion(true, result, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    func wishPostRequest(fake: String? = nil, inputWish: InputWish , completion: @escaping DataMapperCompletion) {
        
        var url = "/wishes/"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.post(url, params: inputWish.params, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let result = WishModel(jsonData: try? json.rawData())
                completion(true, result, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    func copyWishFromUserRequest(fake: String? = nil, userId: Int?, idWish: Int?, completion: @escaping DataMapperCompletion) {
        
        var url = "/wishes/copy/userId/\(String(describing: userId.unsafelyUnwrapped))/id/\(String(describing: idWish.unsafelyUnwrapped))"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.postWithoutParams(url, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let result = WishModel(jsonData: try? json.rawData())
                completion(true, result, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    func addWishImageRequest(fake: String? = nil, wishId: String?, inputWishImage: InputWishImage , completion: @escaping DataMapperCompletion) {
        
        var url = "/wishes/google_cloud_wish_image/\(String(describing: wishId))"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        //Invesitgar como enviar imagen swift, con este imageUploadRequest tenemos que enviar paramentros e Data, buscar más informacion de como
        //convertir una imagen en swift en estos 2 aspectos
        /*connection.imageUploadRequest(url, encode: JSONEncoding.default) {
         httpStatus, json, responseHeaders, error in
         
         if self.checkHttpStatus(httpCode: httpStatus), let json = json {
         let result = UserModel(jsonData: try? json.rawData())
         completion(true, result, nil)
         } else {
         completion(false ,nil, error)
         }
         }*/
    }
    
    func getFriendWishesRequest(fake: String? = nil, userId: Int?, completion: @escaping DataMapperCompletion) {
        
        var url = "/wishes/userId/\(String(describing: userId!))"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.getWithoutParams(url, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let array = json.arrayValue.compactMap {
                    return WishModel(jsonData: try? $0.rawData())
                }
                completion(true, array, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    func deleteWishByIdRequest(fake: String? = nil, wishId: Int?, completion: @escaping DataMapperCompletion) {
        
        var url = "/wishes/\(String(describing: wishId!))"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.delete(url, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let result = SingletonModel(jsonData: try? json.rawData())
                completion(true, result, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    
    //MARK:: FRIENDS REQUESTS --------------------------------------------------------------
    
    func getAllFriendsOfUserRequest(fake: String? = nil, completion: @escaping DataMapperCompletion) {
        
        var url = "/friends"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.getWithoutParams(url, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let result = FriendsModel(jsonData: try? json.rawData())
                completion(true, result, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    
    func getFriendsRequests(fake: String? = nil, completion: @escaping DataMapperCompletion) {
        
        var url = "/friends/requests"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.getWithoutParams(url, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let array = json.arrayValue.compactMap {
                    return FriendRequestModel(jsonData: try? $0.rawData())
                }
                completion(true, array, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    func confirmFriendRequest(fake: String? = nil, idFriendRequest: Int?, completion: @escaping DataMapperCompletion) {
        
        var url = "/friends/\(String(describing: idFriendRequest!))"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.putWithoutParams(url, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let result = SingletonModel(jsonData: try? json.rawData())
                completion(true, result, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    func friendPostRequest(fake: String? = nil, inputFriendRequest: InputFriendRequest, completion: @escaping DataMapperCompletion) {
        
        var url = "/friends"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.post(url, params: inputFriendRequest.params, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let result = SingletonModel(jsonData: try? json.rawData())
                completion(true, result, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    func deleteFriendRequestRequest(fake: String? = nil, friendRequestId: Int?, completion: @escaping DataMapperCompletion) {
        
        var url = "/friends/requests/\(String(describing: friendRequestId))"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.delete(url, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let result = SingletonModel(jsonData: try? json.rawData())
                completion(true, result, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    func deleteFriendRequest(fake: String? = nil, friendshipId: Int?, completion: @escaping DataMapperCompletion) {
        
        var url = "/friends/requests/\(String(describing: friendshipId!))"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.delete(url, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let result = SingletonModel(jsonData: try? json.rawData())
                completion(true, result, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    //MARK:: RESERVED WISH REQUESTS --------------------------------------------------------------
    
    func getReservedWishesRequest(fake: String? = nil, completion: @escaping DataMapperCompletion) {
        
        var url = "/reserved_wishes"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.getWithoutParams(url, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let result = ReservedWishesModel(jsonData: try? json.rawData())
                completion(true, result, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    func reservedWishesPostRequest(fake: String? = nil, inputReservedWish: InputReservedWish, completion: @escaping DataMapperCompletion) {
        
        var url = "/reserved_wishes"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.post(url, params: inputReservedWish.params, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let result = SingletonModel(jsonData: try? json.rawData())
                completion(true, result, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
    
    func deleteReservedWish(fake: String? = nil, id: Int?, completion: @escaping DataMapperCompletion) {
        
        var url = "/reserved_wishes/\(String(describing: id))"
        if fake != nil  {
            url = fake!
            connection = MockConnection()
        }else{
            connection = Connection()
        }
        
        connection.delete(url, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let result = SingletonModel(jsonData: try? json.rawData())
                completion(true, result, nil)
            } else {
                completion(false ,nil, error)
            }
        }
    }
}
