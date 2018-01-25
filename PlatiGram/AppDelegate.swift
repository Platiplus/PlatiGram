//
//  AppDelegate.swift
//  PlatiGram
//
//  Created by Platiplus on 11/01/18.
//  Copyright © 2018 Platiplus. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var actIdc = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var container: UIView!
    
    
    class func instance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    
    func showActivityIndicator() {
        if let window = window {
            container = UIView()
            container.frame = window.frame
            container.center = window.center
            container.backgroundColor = UIColor(white: 0, alpha: 0.8)
            
            actIdc.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            actIdc.hidesWhenStopped = true
            actIdc.center = CGPoint(x: container.frame.size.width / 2, y: container.frame.size.height / 2)
            
            container.addSubview(actIdc)
            window.addSubview(container)
            
            actIdc.startAnimating()
        }
    }
    
    func dismissActivityIndicator() {
        if let _ = window {
            container.removeFromSuperview()
        }
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }


}

