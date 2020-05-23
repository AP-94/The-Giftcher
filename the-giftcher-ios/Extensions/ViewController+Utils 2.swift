//
//  ViewController+Utils.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 07/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController : UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
