//
//  Constants.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 29/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import Foundation
import UIKit

enum Constants {
    
    #if DEV
    static let baseUrlString = "http://localhost:8080"
    static let currentEnviorment = "DEV"
    
    #else //Release
    static let baseUrlString = "http://ec2-54-242-19-40.compute-1.amazonaws.com:8080"
    static let currentEnviorment = "PROD"
    
    #endif
}
