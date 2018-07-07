//
//  AppDelegate.swift
//  MaoTrailer
//
//  Created by Ahmet Sina on 30.06.2018.
//  Copyright © 2018 Ahmet Sina Ustem. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor(red:0.96, green:0.32, blue:0.12, alpha:1.0)], for: .selected)
    
    

    return true
  }



}

