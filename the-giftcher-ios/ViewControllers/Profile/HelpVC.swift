//
//  HelpVC.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 30/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class HelpVC: BaseVC, NVActivityIndicatorViewable {

    @IBOutlet weak var helpLogoImage: UIImageView!
    @IBOutlet weak var tutorialButton: UIButton!
    @IBOutlet weak var faqButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ayuda"

        tutorialButton.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1), thickness: 1)
        faqButton.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1), thickness: 1)
        contactButton.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1), thickness: 1)
        deleteButton.layer.addBorder(edge: UIRectEdge.top, color: UIColor(red: 217/255, green: 48/255, blue: 69/225, alpha: 1), thickness: 1)
       
    }
    
    @IBAction func deleteAccount(_ sender: Any) {
        deleteUserAccount()
        showConfirm() {
            Session.clean()
            print("Eliminate account tapped...")
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func deleteUserAccount() {
        print("Do delete wish of user")
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        dataMapper.deleteUserRequest() {
            success, result, error in
            if (result as? SingletonModel) != nil {
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        }
    }
    
    func showConfirm(completion: @escaping () -> Void) {
           let message = UIAlertController(title: "Confirmar eliminar cuenta", message: "¿Estás seguro que deseas ELIMINAR tu cuenta? No hay vuelta atrás", preferredStyle: .alert)
           let ok = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) -> Void in
               print("ok")
               completion()
           }
           
           let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { (UIAlertAction) -> Void in
               print("cancel")
           }
           
           message.addAction(ok)
           message.addAction(cancel)
           
           self.present(message, animated: true, completion: nil)
       }
    
    @IBAction func goTuto(_ sender: UIButton) {
        self.performSegue(withIdentifier: "TutorialSegue", sender: nil)
    }
    
}
