//
//  MockConnection.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 29/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class MockConnection: RestManager {
    
    var httpHeaders: HTTPHeaders?
    
    func connect(to url: String, method: HTTPMethod, params: [String : Any]?, encode :ParameterEncoding,  completion: @escaping ConnectionCompletion) {
        
    }
    
    func getWithoutParams(_ endpoint: String, encode: ParameterEncoding, completion: @escaping ConnectionCompletion) {
           processFakeNoParams(endpoint, completion: completion)
       }
    
    func postForgotPassword(_ endpoint: String, encode: ParameterEncoding, completion: @escaping ConnectionCompletion) {
        processFakeNoParams(endpoint, completion: completion)
    }
    
    func post(_ endpoint: String, params: [String : Any]?, encode :ParameterEncoding = URLEncoding.default,  completion: @escaping ConnectionCompletion) {
        processFake(endpoint, params: params, completion:  completion)
    }
    
    func get(_ endpoint: String, params: [String : Any]?, encode :ParameterEncoding = URLEncoding.default,  completion: @escaping ConnectionCompletion) {
        processFake(endpoint, params: params, completion:  completion)
    }
    
    func getPdf(_ endpoint: String, params: [String : Any]?, completion: @escaping ConnectionPdf) {
        processFakePdfData(endpoint, params: params, completion:  completion)
    }
    
    func put(_ endpoint: String, params: [String : Any]?, encode :ParameterEncoding = URLEncoding.default,  completion: @escaping ConnectionCompletion) {
        completion(200, nil, [:], nil)
    }
    
    func imageUploadRequest(_ endpoint: String,_ imaeg: UIImage, params: [String : Any]?, completion: @escaping ConnectionCompletion) {
        processFake(endpoint, params: params, completion:  completion)
    }
    
    func delete(_ endpoint: String, encode :ParameterEncoding = URLEncoding.default,  completion: @escaping ConnectionCompletion) {
        completion(200, nil, [:], nil)
    }
    
    func putWithoutParams(_ endpoint: String, encode: ParameterEncoding, completion: @escaping ConnectionCompletion) {
        processFake(endpoint, params: [:], completion:  completion)
    }
    
    func postWithoutParams(_ endpoint: String, encode: ParameterEncoding, completion: @escaping ConnectionCompletion) {
        processFake(endpoint, params: [:], completion:  completion)
    }
    
    func postWithoutToken(_ endpoint: String, params: [String : Any]?, encode: ParameterEncoding, completion: @escaping ConnectionCompletion) {
        processFake(endpoint, params: [:], completion:  completion)
    }

    
    
    func processFake(_ endpoint: String, params: [String : Any]?, completion: @escaping ConnectionCompletion){
        
        print("""
        ---------------------------------------------------------------------
        ---------------------------------------------------------------------
        ---------         ---------------------------------------------------
        ---------   ---------------------------------------------------------
        ---------   ---------------------------------------------------------
        ---------         ---------------------------------------------------
        ---------   ---------------------------------------------------------
        ---------   ---------------------------------------------------------
        ---------   ----de FAKE----------------------------------------------
        ---------------------------------------------------------------------
        ---------------------------------------------------------------------
        """)
        
        
        guard let path = Bundle.main.path(forResource: endpoint, ofType: "json") else {
            completion(404, nil, [:], nil)
            return
        }
        
        if let data = try? NSData(contentsOfFile: path) as Data {
            let json = try? JSON(data: data)
            completion(200, json, [:], nil)
        }else{
            completion(404, nil, [:], nil)
        }
    }
    
    func processFakeNoParams(_ endpoint: String, completion: @escaping ConnectionCompletion){
        
        print("""
        ---------------------------------------------------------------------
        ---------------------------------------------------------------------
        ---------         ---------------------------------------------------
        ---------   ---------------------------------------------------------
        ---------   ---------------------------------------------------------
        ---------         ---------------------------------------------------
        ---------   ---------------------------------------------------------
        ---------   ---------------------------------------------------------
        ---------   ----de FAKE----------------------------------------------
        ---------------------------------------------------------------------
        ---------------------------------------------------------------------
        """)
        
        
        guard let path = Bundle.main.path(forResource: endpoint, ofType: "json") else {
            completion(404, nil, [:], nil)
            return
        }
        
        if let data = try? NSData(contentsOfFile: path) as Data {
            let json = try? JSON(data: data)
            completion(200, json, [:], nil)
        }else{
            completion(404, nil, [:], nil)
        }
    }
    
    func processFakePdfData(_ endpoint: String, params: [String : Any]?, completion: @escaping ConnectionPdf){
        guard let path = Bundle.main.path(forResource: endpoint, ofType: "json") else {
            completion(404, nil, [:], nil)
            return
        }
        
        if let data = try? NSData(contentsOfFile: path) as Data {
            completion(200, data, [:], nil)
        }else{
            completion(404, nil, [:], nil)
        }
    }
    
}
