//
//  AppDelegate.swift
//  Pinterest
//
//  Created by Nicholas Rode on 4/2/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit
import Parse




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    Parse.initializeWithConfiguration(ParseClientConfiguration { (config) in
        config.applicationId = "d46e9ba1-4394-4048-b757-f3a55a07e435"
        config.clientKey = " "
        config.server = "https://therealwhittrade.azurewebsites.net/parse"
        });
    
    
    return true
    }
    
    
}

