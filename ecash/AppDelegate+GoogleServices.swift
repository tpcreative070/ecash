//
//  AppDelegate+GoogleServices.swift
//  ecash
//
//  Created by phong070 on 8/6/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import GoogleSignIn
import Firebase
extension AppDelegate  {
    
    func initGoogleServices(){
        FirebaseApp.configure()
        GIDSignIn.sharedInstance()?.clientID = ConfigKey.GoogleClientId.infoForKey() ?? ""
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url as URL?,
                                                 sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplication.OpenURLOptionsKey.annotation])
    }
}
