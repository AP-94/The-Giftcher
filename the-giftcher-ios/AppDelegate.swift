//
//  AppDelegate.swift
//  the-giftcher-ios
//
//  Created by Rafael Juan Llabrés Socías on 17/04/2020.
//  Copyright © 2020 Rafael Juan Llabrés Socías. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 3.0)
        
       /* if Session.isValid(){
            setupViewController(viewController: "LoginView", storyBoard: "Main")
        }*/
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    public func setupViewController(viewController: String, storyBoard: String) {
        let mainstoryboard = UIStoryboard(name: storyBoard, bundle: nil)
        let mainController = mainstoryboard.instantiateViewController(withIdentifier: viewController)
        
        let navigationController = UINavigationController(rootViewController: mainController)
        navigationController.modalPresentationStyle = .fullScreen
        
    }


}

