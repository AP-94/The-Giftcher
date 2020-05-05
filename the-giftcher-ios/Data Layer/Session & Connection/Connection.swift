//
//  Connection.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 29/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias ConnectionCompletion = (_ httpStatus: Int, _ response: JSON?, _ responseHeaders: [AnyHashable: Any], _ error: Error?) -> Void
typealias ConnectionPdf = (_ httpStatus: Int, _ response: Data?, _ responseHeaders: [AnyHashable: Any], _ error: Error?) -> Void

protocol RestManager {
    var httpHeaders: HTTPHeaders? { get set }
    func connect(to url: String, method: HTTPMethod, params: [String: Any]?, encode: ParameterEncoding, completion: @escaping ConnectionCompletion)
    //POSTS
    func post(_ endpoint: String, params: [String: Any]?, encode: ParameterEncoding,  completion: @escaping ConnectionCompletion)
    func postWithoutParams(_ endpoint: String, encode: ParameterEncoding, completion: @escaping ConnectionCompletion)
    func postWithoutToken(_ endpoint: String, params: [String: Any]?, encode: ParameterEncoding,  completion: @escaping ConnectionCompletion)
    func imageUploadRequest(_ endpoint: String,_ data: NSData, params: [String: Any]?, completion: @escaping ConnectionCompletion)
    func postForgotPassword(_ endpoint: String, encode: ParameterEncoding, completion: @escaping ConnectionCompletion)
    //GETS
    func get(_ endpoint: String, params: [String: Any]?, encode: ParameterEncoding,  completion: @escaping ConnectionCompletion)
    func getWithoutParams(_ endpoint: String, encode: ParameterEncoding, completion: @escaping ConnectionCompletion)
    func getPdf(_ endpoint: String, params: [String: Any]?, completion: @escaping ConnectionPdf)
    //PUTS
    func put(_ endpoint: String, params: [String: Any]?, encode: ParameterEncoding, completion: @escaping ConnectionCompletion)
    func putWithoutParams(_ endpoint: String, encode: ParameterEncoding, completion: @escaping ConnectionCompletion)
    //DELETES
    func delete(_ endpoint: String, encode: ParameterEncoding, completion: @escaping ConnectionCompletion)
    
}

class Connection: RestManager {
    
    let baseUrlString = Constants.baseUrlString
    var sessionManager: SessionManager
    var httpHeaders: HTTPHeaders?
    
    init() {
        // get the default headers
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        // add your custom header
        //headers["Authorization"] = "Bearer \(Session.current.token)"
        headers["Content-Type"] = "application/json"
        
        // create a custom session configuration
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 0
        // add the headers
        configuration.httpAdditionalHeaders = headers
        
        // create a session manager with the configuration
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func setUpHeaders(){
        
    }
    
    func connect(to url: String, method: HTTPMethod, params: [String: Any]?, encode: ParameterEncoding, completion: @escaping ConnectionCompletion) -> Void {
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            
            request.httpMethod = method.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(Session.current.token ?? "")", forHTTPHeaderField: "Authorization")
            request.httpBody = try! JSONSerialization.data(withJSONObject: params ?? [])
            
            
            Alamofire.request(request).responseJSON {
                response in
                
                let httpCode = response.response?.statusCode ?? 0
                print("---> HTTP code: ", httpCode)
                print("---> URL: ", url)
                print("---> PARAMS: ", params ?? "")
                
                let responseHeaders = response.response?.allHeaderFields ?? [AnyHashable: Any]()
                
                var json: JSON? = nil
                if let data = response.data{
                    json = try? JSON(data: data)
                    print("---> JSON: \(json ?? "NO JSON")")
                }
                
                completion(httpCode, json, responseHeaders, response.error)
                
            }
        }
    }
    
    
    
    func dataConnect(to url: String, method: HTTPMethod, params: [String: Any]?, completion: @escaping ConnectionPdf) -> Void {
        
        // make calls with the session manager
        let request = sessionManager.request(url, method: method, parameters: params, headers: httpHeaders)
        
        request.responseData {
            response in
            
            // Do whatever task with response data
            // debugPrint(response)
            
            let httpCode = response.response?.statusCode ?? 0
            let responseHeaders = response.response?.allHeaderFields ?? [AnyHashable: Any]()
            // print("httpCode: \(httpCode)")
            //            print("request: \(request) --data: \(response.result.value)")
            if let data = response.result.value {
                completion(httpCode, data, responseHeaders, response.error)
            } else {
                completion(httpCode, nil, responseHeaders, response.error)
            }
        }
    }
    
    
    func uploadImage(_ data: NSData, _ endpoint: String, params: [String : Any]?, completion: @escaping ConnectionCompletion) {
        
        guard  endpoint.isValidUrl else {
            completion(0, nil, [:], nil)
            return
        }
        
        let request = NSMutableURLRequest(url: URL(string: endpoint)!)
        request.httpMethod = "POST"
        
        let boundary = "0xKhTmLbOuNdArY"
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = ["Authorization": "Bearer \(Session.current.token ?? "")"]
        
        //        let imageData = imageView.jpegData(compressionQuality: 1)
        let imageData = data
        
        //        if(imageData==nil)  { return }
        
        request.httpBody = createBodyWithParameters(parameters: params , filePathKey: "file", imageDataKey: imageData as NSData, boundary: boundary) as Data
        
        //myActivityIndicator.startAnimating();
        print("stop")
        let task =  URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            if let data = data {
                
                // You can print out response object
                print("******* response = \(String(describing: response))")
                
                print(data.count)
                // you can use data here
                
                // Print out reponse body
                let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                
                var json: JSON? = nil
                //                let data = respons
                json = try? JSON(data: data)
                
                print("****** response data = \(responseString!)")
                
                //                let json =  try!JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                
                print("json value \(String(describing: json))")
                if let httpResponse = response as? HTTPURLResponse {
                    completion(httpResponse.statusCode, json, httpResponse.allHeaderFields, error)
                }
                
                //var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &err)
                
            } else if let error = error {
                print(error)
                completion(0, nil, [:], error)
            }
        }
        task.resume()
    }
    
    
    func createBodyWithParameters(parameters: [String: Any]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        var filename = "user-profile.jpg"
        if let docName = parameters?["doc_name"] as? String{
            filename = docName
        }
        
        //        let filename = "user-profile.jpg"
        
        let mimetype = "image/jpg"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    
    
    func withoutTokenConnect(to url: String, method: HTTPMethod, params: [String :
        Any]?,  encode: ParameterEncoding, completion: @escaping ConnectionCompletion) -> Void {
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            //request.setValue(Session.current.token,
            // forHTTPHeaderField: "Authorization")
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try! JSONSerialization.data(withJSONObject: params ?? [])
            
            
            Alamofire.request(request).responseJSON {
                response in
                
                let httpCode = response.response?.statusCode ?? 0
                print("---> HTTP code: ", httpCode)
                print("---> URL: ", url)
                print("---> PARAMS: ", params ?? "")
                
                let responseHeaders = response.response?.allHeaderFields ?? [AnyHashable: Any]()
                
                var json: JSON? = nil
                if let data = response.data{
                    json = try? JSON(data: data)
                    print("---> JSON: \(json ?? "NO JSON")")
                }
                
                completion(httpCode, json, responseHeaders, response.error)
                
            }
        }
    }
    
    func withoutParamsConnect(to url: String, method: HTTPMethod, encode: ParameterEncoding, completion: @escaping ConnectionCompletion) -> Void {
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            
            request.httpMethod = method.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(Session.current.token ?? "")", forHTTPHeaderField: "Authorization")
            
            Alamofire.request(request).responseJSON {
                response in
                
                let httpCode = response.response?.statusCode ?? 0
                print("---> HTTP code: ", httpCode)
                print("---> URL: ", url)
                
                let responseHeaders = response.response?.allHeaderFields ?? [AnyHashable: Any]()
                
                var json: JSON? = nil
                if let data = response.data{
                    json = try? JSON(data: data)
                    print("---> JSON: \(json ?? "NO JSON")")
                }
                
                completion(httpCode, json, responseHeaders, response.error)
                
            }
        }
    }
    
    func    connectNoParamsNoToken(to url: String, method: HTTPMethod, encode: ParameterEncoding, completion: @escaping ConnectionCompletion) -> Void {
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            
            request.httpMethod = method.rawValue
            
            Alamofire.request(request).responseJSON {
                response in
                
                let httpCode = response.response?.statusCode ?? 0
                print("---> HTTP code: ", httpCode)
                print("---> URL: ", url)
                
                let responseHeaders = response.response?.allHeaderFields ?? [AnyHashable: Any]()
                
                var json: JSON? = nil
                if let data = response.data{
                    json = try? JSON(data: data)
                    print("---> JSON: \(json ?? "NO JSON")")
                }
                
                completion(httpCode, json, responseHeaders, response.error)
                
            }
        }
    }
    
    func completeUrlString(forEndpoint endpoint: String) -> String {
        if endpoint.contains("http") { return endpoint }
        return baseUrlString + endpoint
    }
    
    
    
    func getPdf(_ endpoint: String, params: [String: Any]?, completion: @escaping ConnectionPdf) {
        dataConnect(to: completeUrlString(forEndpoint: endpoint), method: .get, params: params, completion: completion)
    }
    
    
    func imageUploadRequest(_ endpoint: String, _ data: NSData, params: [String : Any]?,  completion: @escaping ConnectionCompletion) {
        uploadImage(data, completeUrlString(forEndpoint: endpoint), params: params,  completion: completion)
    }
    
    func delete(_ endpoint: String, encode :ParameterEncoding = URLEncoding.default, completion: @escaping ConnectionCompletion) {
        withoutParamsConnect(to: completeUrlString(forEndpoint: endpoint), method: .delete, encode: encode, completion: completion)
    }
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    func post(_ endpoint: String, params: [String: Any]?, encode: ParameterEncoding,  completion: @escaping ConnectionCompletion) {
        connect(to: completeUrlString(forEndpoint: endpoint), method: .post, params: params, encode: encode,  completion: completion)
    }
    
    func postWithoutToken(_ endpoint: String, params: [String: Any]?, encode: ParameterEncoding,  completion: @escaping ConnectionCompletion) {
        withoutTokenConnect(to: completeUrlString(forEndpoint: endpoint), method: .post, params: params, encode: encode,  completion: completion)
    }
    
    func getWithoutParams(_ endpoint: String, encode: ParameterEncoding, completion: @escaping ConnectionCompletion) {
        withoutParamsConnect(to: completeUrlString(forEndpoint: endpoint), method: .get, encode: encode,  completion: completion)
    }
    
    func postWithoutParams(_ endpoint: String, encode: ParameterEncoding, completion: @escaping ConnectionCompletion) {
        withoutParamsConnect(to: completeUrlString(forEndpoint: endpoint), method: .post, encode: encode,  completion: completion)
    }
    
    func get(_ endpoint: String, params: [String: Any]?, encode: ParameterEncoding,  completion: @escaping ConnectionCompletion) {
        connect(to: completeUrlString(forEndpoint: endpoint), method: .get, params: params, encode: encode,  completion: completion)
    }
    
    func put(_ endpoint: String, params: [String: Any]?, encode: ParameterEncoding,  completion: @escaping ConnectionCompletion) {
        connect(to: completeUrlString(forEndpoint: endpoint), method: .put, params: params, encode: encode,  completion: completion)
    }
    
    func putWithoutParams(_ endpoint: String, encode: ParameterEncoding, completion: @escaping ConnectionCompletion) {
        withoutParamsConnect(to: completeUrlString(forEndpoint: endpoint), method: .put, encode: encode,  completion: completion)
        
    }
    
    func postForgotPassword(_ endpoint: String, encode: ParameterEncoding, completion: @escaping ConnectionCompletion) {
        connectNoParamsNoToken(to: completeUrlString(forEndpoint: endpoint), method: .post, encode: encode,  completion: completion)
    }
    
    
    
}



