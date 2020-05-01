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
              return false
          case 403:
              Session.clean()
              print("Aquí deberiamos enviar al usuario a log in")
              return false
          case 404:
              print("Not Found")
              return false
          case 409:
              print("Error de usuario existente")
              return false
          case 460...499:
              print("error interno sin especificar")
              return false
          case 500...503:
              print("network down")
              return false
          case 0:
              print("no hay conexión")
              return false
          default:
              print("Error de conexión")
              return false
          }
      }
    
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
}
