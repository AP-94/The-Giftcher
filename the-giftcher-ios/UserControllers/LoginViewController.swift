//
//  LoginViewController.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 17/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var forgotPsswdButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 20
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        loginButton.backgroundColor = UIColor.white
        
        registerButton.layer.cornerRadius = 20

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginSubmit(_ sender: UIButton) {
        
        performSegue(withIdentifier: "HomeView", sender: self)
    }
    

}
