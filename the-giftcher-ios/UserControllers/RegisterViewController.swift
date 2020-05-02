//
//  RegisterViewController.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 18/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

class RegisterViewController: BaseVC {
    
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
    
    //DatePicker ViewOutlets
    @IBOutlet weak var datePickerBackground: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dondeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setModifiers()
        keyboardActions()
        
    }
    
    func setModifiers(){
        confirmButton.layer.cornerRadius = 20
        confirmButton.layer.borderWidth = 1
        confirmButton.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        confirmButton.backgroundColor = UIColor.white
        backToLoginButton.layer.cornerRadius = 20
    }
    
    
    @IBAction func setBirthday(_ sender: Any) {
        datePickerBackground.layer.isHidden = false
        datePicker.layer.isHidden = false
        dondeButton.layer.isHidden = false
    }
    
    
    @IBAction func doRegisterRequest(_ sender: Any) {
        fieldsValidator()
        let inputRegister = InputRegister(name: nameInput.text, username: userNameInput.text, lastName: surnameInput.text, mail: emailInput.text, password: passwordInput.text, birthday: birthdayInput.text)
        doRegisterRequest(inputRegister: inputRegister)
    }
    
    func fieldsValidator() {
        if nameInput.text == "" || userNameInput.text == "" || surnameInput.text == "" || emailInput.text == "" || passwordInput.text == "" || birthdayInput.text == "" {
            if emailInput.text!.isValidEmail {
                
            }
        }
        
    }
    
    
    @IBAction func backToLoginAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "LoginVC", sender: nil)
    }
    
    func doRegisterRequest(inputRegister: InputRegister) {
        print("Do Register Request")
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
                    self.performSegue(withIdentifier: "HomeViewR", sender: nil)
                }
            } else {
                print("ERROR EN LA PETICIÓN DE REGISTRO")
            }
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
        dateFormatter.dateFormat = "yyyy-mm-dd"
        
        let dateToString = dateFormatter.string(from: datePicker.date)
        birthdayInput.text = dateToString
    }
    
}
