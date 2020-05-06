//
//  LoginViewController.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 17/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import NVActivityIndicatorView

class LoginViewController: BaseVC, NVActivityIndicatorViewable {
    
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var forgotPsswdButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setModifiers()
        keyboardActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkSession()
    }
    
    func setModifiers() {
        loginButton.layer.cornerRadius = 20
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        loginButton.backgroundColor = UIColor.white
        registerButton.layer.cornerRadius = 20
        
    }
    
    @IBAction func loginSubmit(_ sender: UIButton) {
        
        if !userInput.text!.isEmpty {
            if !passwordInput.text!.isEmpty {
                let inputLogin = InputLogin(username: userInput.text, pass: passwordInput.text)
                doLoginRequest(inputLogin: inputLogin)
            } else {
                let banner = NotificationBanner(title: "Error", subtitle: "Debes rellenar el campo contraseña", style: .warning)
                banner.show()
            }
        } else {
            let banner = NotificationBanner(title: "Error", subtitle: "Debes rellenar el campo de usuario", style: .warning)
            banner.show()
            
        }
    }
    
    func doLoginRequest(inputLogin: InputLogin){
        print("Do Login Request")
        startAnimating(sizeOfIndivatorView, message: "Loading...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        dataMapper.loginRequest(inputLogin: inputLogin) {
            success, result, error in
            if let result = result as? UserModel {
                
                let currentSession = Session.current
                currentSession.token = result.token
                currentSession.userName = result.username
                currentSession.id = result.id
                currentSession.userModel = result
                
                print("USUERNAME => \(currentSession.userName ?? "NO HAY USUARIO")")
                
                Session.save()
                
                if Session.isValid() {
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
                    self.performSegue(withIdentifier: "HomeView", sender: nil)
                }
            }
            
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        }
    }

    func checkSession() {
        if Session.isValid(){
            print("Session is valid, going to home view")
            self.performSegue(withIdentifier: "HomeView", sender: nil)
        } else {
            print("Session invalid, goin to log in view")
        }
    }
    
    
}
