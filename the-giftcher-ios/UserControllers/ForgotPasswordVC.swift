//
//  ForgotPasswordVC.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 05/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import NVActivityIndicatorView

class ForgotPasswordVC: BaseVC, NVActivityIndicatorViewable {
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setModifiers()
    }
    
    func setModifiers() {
        sendButton.layer.cornerRadius = 20
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        if emailInput.text != "" {
            if emailInput.text!.isValidEmail {
                print("Email --> \(String(describing: emailInput.text))")
                let email = emailInput.text
                doForgotPasswordRequest(email: email)
            } else {
                let banner = NotificationBanner(title: "Error", subtitle: "Debes introducir un email válido ", style: .warning)
                banner.show()
            }
        } else {
            let banner = NotificationBanner(title: "Error", subtitle: "Debes rellenar el campo email", style: .warning)
            banner.show()
        }
    }
    
    @IBAction func closeView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func doForgotPasswordRequest(email: String?){
        print("Do Forgot Password Request")
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        dataMapper.forgotPasswordRequest(email: email) {
            success, result, error in
            if let result = result as? SingletonModel {
                let banner = NotificationBanner(title: "Mail Enviado", subtitle: "Revisa tu buzón para encontrar las instrucciones", style: .info)
                banner.show()
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        }
    }
}
