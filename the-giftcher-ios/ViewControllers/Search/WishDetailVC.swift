//
//  WishDetailVC.swift
//  the-giftcher-ios
//
//  Created by Alessandro Pace on 29/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import NotificationBannerSwift

class WishDetailVC: UIViewController, NVActivityIndicatorViewable {
    
    var wish: WishModel?
    var categoryString: String?
    let sizeOfIndivatorView = CGSize(width: 40, height: 40)
    let dataMapper = DataMapper()
    var wishOfUser: Bool = false
    
    //Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var uiViewsOutlet: UIView!
    @IBOutlet weak var uiViews2Outlet: UIView!
    @IBOutlet weak var uiViews3Outlet: UIView!
    @IBOutlet weak var shareButtonView: UIView!
    @IBOutlet weak var buttonSaveView: UIView!
    @IBOutlet weak var wishName: UILabel!
    @IBOutlet weak var wishPrice: UILabel!
    @IBOutlet weak var wishDescription: UILabel!
    @IBOutlet weak var wishCategory: UILabel!
    @IBOutlet weak var wishStore: UILabel!
    @IBOutlet weak var getWishButton: UIButton!
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var trashButtonContainer: UIView!
    @IBOutlet weak var saveWishButton: UIButton!
    @IBOutlet weak var editButtonContainer: UIView!
    @IBOutlet weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title =  "Detalle de Deseo"
        setModifiers()
        loadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData(_:)), name: .didEditWishRequest, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.title =  "Detalle de Deseo"
    }
    
    @objc private func refreshData(_ notification:Notification) {
        refreshData()
    }
    
    
    func setModifiers(){
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.layer.borderWidth = 0.5
        
        uiViewsOutlet.layer.borderColor = UIColor.red.cgColor
        uiViewsOutlet.layer.borderWidth = 0.5
        
        uiViews2Outlet.layer.borderColor = UIColor.red.cgColor
        uiViews2Outlet.layer.borderWidth = 0.5
        
        uiViews3Outlet.layer.borderColor = UIColor.red.cgColor
        uiViews3Outlet.layer.borderWidth = 0.5
        
        buttonSaveView.layer.cornerRadius = 5.0
        shareButtonView.layer.cornerRadius = 5.0
        trashButtonContainer.layer.cornerRadius = 5.0
        editButtonContainer.layer.cornerRadius = 5.0
        
        getWishButton.layer.cornerRadius = 5
        
        let url = wish?.onlineShop ?? ""
        
        if !url.isEmpty {
            getWishButton.isHidden = false
        } else {
            getWishButton.isHidden = true
        }
        
        if wishOfUser {
            trashButton.isHidden = false
            trashButtonContainer.isHidden = false
            editButton.isHidden = false
            editButtonContainer.isHidden = false
            saveWishButton.isHidden = true
            buttonSaveView.isHidden = true
        } else {
            trashButton.isHidden = true
            trashButtonContainer.isHidden = true
            saveWishButton.isHidden = false
            buttonSaveView.isHidden = false
        }
        
    }
    
    func loadData() {
        wishName.text = wish?.name
        wishPrice.text = "\(String(describing: wish?.price ?? 0))€"
        wishDescription.text = wish?.description
        setCategory(category: wish?.category ?? 0)
        wishCategory.text = categoryString
        wishStore.text = wish?.shop
        
        if let avatar = wish?.imagePath {
            imageView.loadUrl(from: avatar, contentMode: .scaleAspectFill)
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
        
    }
    
    @IBAction func saveWish(_ sender: UIButton) {
        saveWishFromOtherUser()
    }
    
    @IBAction func shareWish(_ sender: Any) {
        let firstActivityItem = "Regalame esto: \(wishName.text!)"
        let image : UIImage = imageView.image!
        var secondActivityItem : NSURL = NSURL(string: "http://www.thegiftcher.com")!
        let url = wish?.onlineShop ?? ""
        
        if !url.isEmpty {
            secondActivityItem = NSURL(string: url)!
        }
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
        
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func saveWishFromOtherUser() {
        print("Do copy wish from another user")
        
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        dataMapper.copyWishFromUserRequest(userId: wish?.userId.unsafelyUnwrapped, idWish: wish?.id.unsafelyUnwrapped) {
            success, result, error in
            if let result = result as? WishModel {
                if result.userId == Session.current.id {
                    let banner = NotificationBanner(title: "Deseo Guardado", subtitle: "Nuevo deseo guardado en tu lista de deseos", style: .info)
                    banner.show()
                }
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        }
    }
    
    func deleteWishOfUser() {
        print("Do delete wish of user")
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        let idOfWish = wish?.id!
        dataMapper.deleteWishByIdRequest(wishId: idOfWish) {
            success, result, error in
            if (result as? SingletonModel) != nil {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
                self.navigationController?.popViewController(animated: true)
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        }
    }
    
    @IBAction func getWish(_ sender: Any) {
        let stringUrl = wish?.onlineShop ?? ""
        let url = URL(string: stringUrl)
        UIApplication.shared.open(url!)
    }
    
    @IBAction func deleteWish(_ sender: Any) {
        showConfirm {
            self.deleteWishOfUser()
        }
    }
    
    func showConfirm(completion: @escaping () -> Void) {
        let message = UIAlertController(title: "Confirmar", message: "¿Estás seguro que deseas eliminar este deseo?", preferredStyle: .alert)
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
    
    func setCategory(category: Int) {
        switch category {
        case 1:
            categoryString = "Videojuegos"
        case 2:
            categoryString = "Hogar"
        case 3:
            categoryString = "Motor"
        case 4:
            categoryString = "Electrodomésticos"
        case 5:
            categoryString = "Moda"
        case 6:
            categoryString = "Jardín"
        case 7:
            categoryString = "TV"
        case 8:
            categoryString = "Música"
        case 9:
            categoryString = "Foto"
        case 10:
            categoryString = "Móviles"
        case 11:
            categoryString = "Informática"
        case 12:
            categoryString = "Deporte"
        case 13:
            categoryString = "Libros"
        case 14:
            categoryString = "Niños y bebés"
        case 15:
            categoryString = "Agricultura"
        case 16:
            categoryString = "Servicios"
        case 17:
            categoryString = "Coleccionismo"
        case 18:
            categoryString = "Construcción"
        default:
            categoryString = "Otros"
        }
    }
    
    func refreshData() {
        print("Do get wish request")
        startAnimating(sizeOfIndivatorView, message: "Cargando...", type: .ballBeat, color: UIColor.black, backgroundColor: UIColor(white: 1, alpha: 0.7), textColor: UIColor.black, fadeInAnimation: nil)
        dataMapper.oneWishRequest(id: wish?.id!) {
            success, result, error in
            if let result = result as? WishModel {
                self.wishName.text = result.name
                self.wishPrice.text = "\(String(describing: result.price!))€"
                self.wishDescription.text = result.description
                self.setCategory(category: result.category ?? 0)
                self.wishCategory.text = self.categoryString
                self.wishStore.text = result.shop
                
                if let avatar = result.imagePath {
                    self.imageView.loadUrl(from: avatar, contentMode: .scaleAspectFill)
                } else {
                    self.imageView.image = UIImage(named: "placeholder")
                }
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WishEditSegue" {
            if let editWishVC = segue.destination as? EditWishVC {
                editWishVC.wish = self.wish
                print("WISH -> \(String(describing: editWishVC.wish?.name))")
            }
        }
    }
    
    @IBAction func reserveWish(_ sender: Any) {
        
    }
}
