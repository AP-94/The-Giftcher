//
//  ContactFormVC.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 01/05/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
import MessageUI

class ContactFormVC: UIViewController, MFMailComposeViewControllerDelegate {

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
        if MFMailComposeViewController.canSendMail() {
            let composer = MFMailComposeViewController()
            composer.mailComposeDelegate = self
            composer.setToRecipients(["thegiftcher@gmail.com"])
            composer.setSubject("Ayuda! Necesito información sobre...")
            composer.setMessageBody("Escriba aquí su consulta...", isHTML: false)
        
            present(composer, animated: true, completion: nil)
        } else {
            print("Cannot send mail")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Cancelled")
        case MFMailComposeResult.saved.rawValue:
            print("Saved")
            case MFMailComposeResult.sent.rawValue:
            print("Sent")
            case MFMailComposeResult.failed.rawValue:
            print("Error")
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
}

