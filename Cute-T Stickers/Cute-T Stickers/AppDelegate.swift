//
//  AppDelegate.swift
//  Cute-T Stickers
//
//  Created by Ankit Garg on 4/21/20.
//  Copyright © 2020 Omni Soft Solutions. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window:UIWindow?
    
    func application(_ application:UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplication.LaunchOptionsKey:Any]?)->Bool
    {
        let appDomain=Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName:appDomain!)
        
        return true
    }
    
    @available(iOS 13.0, *)
    func application(_ application:UIApplication, configurationForConnecting connectingSceneSession:UISceneSession, options:UIScene.ConnectionOptions)->UISceneConfiguration
    {
        return UISceneConfiguration(name:"Default Configuration", sessionRole:connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application:UIApplication, didDiscardSceneSessions sceneSessions:Set<UISceneSession>)
    {
        
    }
}
