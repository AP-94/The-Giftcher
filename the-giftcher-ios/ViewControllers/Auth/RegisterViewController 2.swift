//
//  RegisterViewController.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 18/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import NVActivityIndicatorView

class RegisterViewController: BaseVC, NVActivityIndicatorViewable {
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var surnameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var repPasswordInput: UITextField!
    @IBOutlet weak var birthdayButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var backToLoginButton: UIButton!
    @IBOutlet weak var birthdayInput: UILabel!
    @IBOutlet weak var passwordEye: UIButton!
    @IBOutlet weak var repeatPassEye: UIButton!
    
    //DatePicker ViewOutlets
    @IBOutlet weak var datePickerBackground: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dondeButton: UIButton!
    
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setModifiers()
        
    }
    
    func setModifiers(){
        confirmButton.layer.cornerRadius = 20
        confirmButton.layer.borderWidth = 1
        confirmButton.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        confirmButton.backgroundColor = UIColor.white
        backToLoginButton.layer.cornerRadius = 20
        nameInput.delegate = self
        surnameInput.delegate = self
        emailInput.delegate = self
        userNameInput.delegate = self
        passwordInput.delegate = self
        repPasswordInput.delegate = self
    }
    
    
    @IBAction func setBirthday(_ sender: Any) {
        datePickerBackground.layer.isHidden = false
        datePicker.layer.isHidden = false
        dondeButton.layer.isHidden = false
    }
    
    
    @IBAction func doRegisterRequest(_ sender: Any) {
        if nameInput.text != "" || userNameInput.text != "" || surnameInput.text != "" || emailInput.text != "" || passwordInput.text != "" || birthdayInput.text != "" {
            if emailInput.text!.isValidEmail {
                if passwordInput.text!.isValidPassword {
                    if passwordInput.text == repPasswordInput.text {
                        let inputRegister = InputRegister(name: nameInput.text, username: userNameInput.text, lastName: surnameInput.text, mail: emailInput.text, password: passwordInput.text, birthday: birthdayInput.text)
                        doRegisterRequest(inputRegister: inputRegister)
                    } else {
                        let banner = NotificationBanner(title: "Error", subtitle: "Las contraseñas no coinciden", style: .warning)
                                         banner.show()
                    }
                } else {
                    let banner = GrowingNotificationBanner(title: "Error", subtitle: "La contraseña debe contener: \n - 1 letra minúscula, \n - 1 letra mayúscula, \n - 1 símbolo de los siguientes @#!$%, \n - 1 número \n - contener 8-20 caracteres", style: .warning)
                    banner.show()
                }
            } else {
                let banner = NotificationBanner(title: "Error", subtitle: "Debes introducir un mail valido", style: .warning)
                banner.show()
            }
        } else {
            let banner = NotificationBanner(title: "Error", subtitle: "Debes rellenar todos los campos", style: .warning)
            banner.show()
            
        }
    }
    
    @IBAction func backToLoginAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "LoginVC", sender: nil)
    }
    
    func doRegisterRequest(inputRegister: InputRegister) {
        print("Do Register Request")
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        dataMapper.registerRequest(inputRegister: inputRegister) {
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
                    if currentSession.userCategories.isEmpty {
                        self.performSegue(withIdentifier: "TutorialSegue", sender: nil)
                    } else {
                        self.performSegue(withIdentifier: "HomeView", sender: nil)
                    }
                }
            }
            
             NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        }
        
    }
    
    @IBAction func hideDatePickerView(_ sender: UIButton) {
        convertBirthday()
        birthdayInput.isHidden = false
        datePickerBackground.layer.isHidden = true
        datePicker.layer.isHidden = true
        dondeButton.layer.isHidden = true
        
    }
    
    func convertBirthday() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateToString = dateFormatter.string(from: datePicker.date)
        birthdayInput.text = dateToString
    }
    
    @IBAction func passwordEyeController(_ sender: Any) {
        if(iconClick == true) {
                          passwordInput.isSecureTextEntry = false
                           passwordEye.setImage(UIImage(systemName: "eye.slash"), for: .normal)
                      } else {
                          passwordInput.isSecureTextEntry = true
                          passwordEye.setImage(UIImage(systemName: "eye"), for: .normal)
                      }

                      iconClick = !iconClick
    }
    
    @IBAction func repPassEyeController(_ sender: Any) {
        if(iconClick == true) {
                          repPasswordInput.isSecureTextEntry = false
                           repeatPassEye.setImage(UIImage(systemName: "eye.slash"), for: .normal)
                      } else {
                          repPasswordInput.isSecureTextEntry = true
                          repeatPassEye.setImage(UIImage(systemName: "eye"), for: .normal)
                      }

                      iconClick = !iconClick
    }
}
