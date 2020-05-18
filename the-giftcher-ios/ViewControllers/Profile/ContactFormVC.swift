//
//  ContactFormVC.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 01/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
import MessageUI

class ContactFormVC: UIViewController {

    @IBOutlet weak var contactButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacto"
        
        //formSubmitButton atributes
        contactButton.layer.cornerRadius = 20
        
    }

    @IBAction func emailButtonTapped(_ sender: UIButton) {
        showMailComposer()
    }
    
    func showMailComposer() {
        
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["thegiftcher@gmail.com"])
        composer.setSubject("Ayuda! Necesito información sobre...")
        composer.setMessageBody("Escriba aquí su consulta...", isHTML: false)
        
        present(composer, animated: true)
    }
}

extension ContactFormVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            controller.dismiss(animated: true)
        }
        
        switch result {
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("Failed to send")
        case .saved:
            print("Saved")
        case .sent:
            print("Email sent")
        
        }
        
        controller.dismiss(animated: true)
    }
}
