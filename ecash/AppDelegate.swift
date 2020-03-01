//
//  AppDelegate.swift
//  ecast
//
//  Created by phong070 on 7/25/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var timeStartOnBackground = Date()
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.initLanguage()
        self.initConfig()
        self.initGoogleServices()
        self.registerPush(application : application)
        self.initTabBarController(selectedIndex: 0)

        NotificationCenter.default.addObserver(self, selector: #selector(onPayToRequest(_:)), name: NSNotification.Name(rawValue: "eventPayToRequest"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(onToPayInfoPayment(_:)), name: NSNotification.Name(rawValue: "eventToPayInfoPayment"), object: nil)
        
        GlobalRequestApiHelper.shared.doApplicationSignOut()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        timeStartOnBackground = Date()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        debugPrint("Will enter app")
        SwiftEventBusHelper.post(ConfigKey.RequestUpdateeDong)
        if let _ = CommonService.getPublicKey() {
            WebSocketClientHelper.instance.connect()
        }
        let passedSeconds = Date().timeIntervalSince(timeStartOnBackground)
        if (passedSeconds >= AppConstants.APP_INDIE_TIME) {
            GlobalRequestApiHelper.shared.doApplicationSignOut()
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

extension AppDelegate{
    /**
     Init language when open the app, store language to db, store language to memory
     */
    fileprivate func initLanguage() {
        if let languagesObject = JSONHelper.loadJsonfromLocal("languages") {
            let enLang = languagesObject[LanguageCode.English] as! Dictionary<String, Any>
            let viLang = languagesObject[LanguageCode.Vietnamese] as! Dictionary<String, Any>
            // Store language to db
            LanguageHelper.storeLanguageByKey(LanguageCode.English, data: JSONHelper.convertDictionaryToJson(enLang) ?? "")
            LanguageHelper.storeLanguageByKey(LanguageCode.Vietnamese, data: JSONHelper.convertDictionaryToJson(viLang) ?? "")
            
            // store language to global data
            GlobalVariableHelper.languages[LanguageCode.English] = enLang
            GlobalVariableHelper.languages[LanguageCode.Vietnamese] = viLang
        }
    }
}
