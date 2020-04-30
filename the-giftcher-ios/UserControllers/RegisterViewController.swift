//
//  RegisterViewController.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 18/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var surnameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var repPasswordInput: UITextField!
    @IBOutlet weak var birthdayButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var backToLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmButton.layer.cornerRadius = 20
        confirmButton.layer.borderWidth = 1
        confirmButton.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        confirmButton.backgroundColor = UIColor.white
        
        backToLoginButton.layer.cornerRadius = 20

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToLoginAction(_ sender: UIButton) {
    }
    
}
