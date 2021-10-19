//
//  AppDelegate.swift
//  Github iOS
//
//  Created by Numan Ayhan on 19.10.2021.
//

import UIKit

import UIKit
import Firebase
var appRoot : AppRoot?
 
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
          
        FirebaseApp.configure()
        setApp()
        
        return true
    }
    func setApp(){
        
        //Language
        
        //Keyboard
        
        //Window UI
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        //Root App
        appRoot = AppRoot(window: window!)
        appRoot?.startApp()
         
        
        //Theme
        
    }
     
}

