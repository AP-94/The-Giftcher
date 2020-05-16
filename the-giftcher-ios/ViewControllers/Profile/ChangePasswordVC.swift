//
//  ChangePasswordVC.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 03/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import NVActivityIndicatorView

class ChangePasswordVC: BaseVC, NVActivityIndicatorViewable {

    @IBOutlet weak var oldPasswordTF: UITextField!
    @IBOutlet weak var oldPassVisibilityButton: UIButton!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var newPassVisibilityButton: UIButton!
    @IBOutlet weak var repNewPasswordTF: UITextField!
    @IBOutlet weak var repNewPassVisibilityButton: UIButton!
    @IBOutlet weak var changePassSubmitButton: UIButton!
    
    //hide password icon
    var iconClick = true
    let hidePassImage = UIImage(systemName: "eye.slash")
    let showPassImage = UIImage(systemName: "eye")
    
    var correctPassword = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customItems()
        
    }
    
    func customItems() {
        
        //editUsernameTF atributes
        oldPasswordTF.layer.borderWidth = 1
        oldPasswordTF.layer.cornerRadius = 5
        oldPasswordTF.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        oldPasswordTF.textColor = UIColor(red: 1/255, green: 1/255, blue: 1/225, alpha: 1)
        oldPasswordTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: oldPasswordTF.frame.height))
        oldPasswordTF.leftViewMode = .always
        
        //editUsernameTF atributes
        newPasswordTF.layer.borderWidth = 1
        newPasswordTF.layer.cornerRadius = 5
        newPasswordTF.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        newPasswordTF.textColor = UIColor(red: 1/255, green: 1/255, blue: 1/225, alpha: 1)
        newPasswordTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: newPasswordTF.frame.height))
        newPasswordTF.leftViewMode = .always
        
        //editUsernameTF atributes
        repNewPasswordTF.layer.borderWidth = 1
        repNewPasswordTF.layer.cornerRadius = 5
        repNewPasswordTF.layer.borderColor = UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1).cgColor
        repNewPasswordTF.textColor = UIColor(red: 1/255, green: 1/255, blue: 1/225, alpha: 1)
        repNewPasswordTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: repNewPasswordTF.frame.height))
        repNewPasswordTF.leftViewMode = .always
        
        //formSubmitButton atributes
        changePassSubmitButton.layer.cornerRadius = 20
        
        oldPasswordTF.delegate = self
        newPasswordTF.delegate = self
        repNewPasswordTF.delegate = self
    }
    
    @IBAction func showOldPassword(_ sender: Any) {
        if(iconClick == true) {
            oldPasswordTF.isSecureTextEntry = false
            oldPassVisibilityButton.setImage(hidePassImage, for: .normal)
        } else {
            oldPasswordTF.isSecureTextEntry = true
            oldPassVisibilityButton.setImage(showPassImage, for: .normal)
        }

        iconClick = !iconClick
    }
    
    @IBAction func showNewPassword(_ sender: Any) {
        if(iconClick == true) {
            newPasswordTF.isSecureTextEntry = false
            newPassVisibilityButton.setImage(hidePassImage, for: .normal)
        } else {
            newPasswordTF.isSecureTextEntry = true
            newPassVisibilityButton.setImage(showPassImage, for: .normal)
        }

        iconClick = !iconClick
    }
    
    @IBAction func showRepNewPassword(_ sender: Any) {
        if(iconClick == true) {
            repNewPasswordTF.isSecureTextEntry = false
            repNewPassVisibilityButton.setImage(hidePassImage, for: .normal)
        } else {
            repNewPasswordTF.isSecureTextEntry = true
            repNewPassVisibilityButton.setImage(showPassImage, for: .normal)
        }

        iconClick = !iconClick
    }
    
    @IBAction func updatePassword(_ sender: UIButton) {
        changePassSubmitButton.bounce()
        
        if oldPasswordTF.text == "" || newPasswordTF.text == "" || repNewPasswordTF.text == "" {
            
            let banner = NotificationBanner(title: "Error", subtitle: "Ningún campo debe estar vacío", style: .warning)
            banner.show()
            
            } else if newPasswordTF.text!.isValidPassword {
                if newPasswordTF.text == repNewPasswordTF.text {
                    if newPasswordTF.text != oldPasswordTF.text {
                        
                            let inputPassword = InputUpdatePassword(oldPassword: oldPasswordTF.text, newPassword: newPasswordTF.text)
                                doUpdateRequest(inputUpdatePassword: inputPassword)
                                
                        
                            if correctPassword == true {
                                
                                let banner = NotificationBanner(title: "Éxito", subtitle: "Password cambiado correctamente", style: .success)
                            banner.show()
                                backToEProf()
                                self.navigationController?.popViewController(animated: true)
                            
                        } else if correctPassword == false {
                            
                            print("Contraseñas no coinciden")
                        }
                        
                    } else {
                        
                        let banner = NotificationBanner(title: "Error", subtitle: "El password no debe ser el mismo que el anterior", style: .warning)
                        banner.show()
                    }
                    
                } else {
                    
                    let banner = NotificationBanner(title: "Error", subtitle: "Las contraseñas no coinciden", style: .warning)
                    banner.show()
            }
        } else {
            
            let banner = GrowingNotificationBanner(title: "Error", subtitle: "La contraseña debe contener: \n - 1 letra minúscula, \n - 1 letra mayúscula, \n - 1 símbolo de los siguientes @#!$%, \n - 1 número \n - contener 8-20 caracteres", style: .warning)
            banner.show()
        }
    }
    
    func doUpdateRequest(inputUpdatePassword: InputUpdatePassword){
        print("Do Update Request")
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        dataMapper.updateUserPasswordRequest(inputUpdatePassword: inputUpdatePassword) {
            success, result, error in
            if let result = result as? UserModel {
                
                self.correctPassword = false
                
                Session.clean()
                let currentSession = Session.current
                    currentSession.token = result.token
                    currentSession.userName = result.username
                    currentSession.id = result.id
                    currentSession.userModel = result
                
                print("USUERNAME => \(currentSession.userName ?? "NO HAY USUARIO")")
                
                Session.save()
            } else {
                
                self.correctPassword = true
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        }
    }
    
    func backToEProf() {
        oldPasswordTF.text = ""
        newPasswordTF.text = ""
        repNewPasswordTF.text = ""
    }
    
}
