//
//  ContactFormVC.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 01/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

class ContactFormVC: UIViewController {

    @IBOutlet weak var formNameField: UITextField!
    @IBOutlet weak var formEmailField: UITextField!
    @IBOutlet weak var formAffairField: UITextField!
    @IBOutlet weak var formMessageField: UITextView!
    @IBOutlet weak var formSubmitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacto"
        
        //formNameField atributes
        formNameField.layer.borderWidth = 1
        formNameField.layer.cornerRadius = 5
        formNameField.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        formNameField.textColor = UIColor(red: 1/255, green: 1/255, blue: 1/225, alpha: 1)
        formNameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: formNameField.frame.height))
        formNameField.leftViewMode = .always
        
        //formEmailField atributes
        formEmailField.layer.borderWidth = 1
        formEmailField.layer.cornerRadius = 5
        formEmailField.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        formEmailField.textColor = UIColor(red: 1/255, green: 1/255, blue: 1/225, alpha: 1)
        formEmailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: formEmailField.frame.height))
        formEmailField.leftViewMode = .always
        
        //formAffairField atributes
        formAffairField.layer.borderWidth = 1
        formAffairField.layer.cornerRadius = 5
        formAffairField.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        formAffairField.textColor = UIColor(red: 1/255, green: 1/255, blue: 1/225, alpha: 1)
        formAffairField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: formAffairField.frame.height))
        formAffairField.leftViewMode = .always
        
        //formMessageField atributes
        formMessageField.layer.borderWidth = 1
        formMessageField.layer.cornerRadius = 5
        formMessageField.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        formMessageField.textColor = UIColor(red: 1/255, green: 1/255, blue: 1/225, alpha: 1)
        
        //formSubmitButton atributes
        formSubmitButton.layer.cornerRadius = 20

    }
    

}
