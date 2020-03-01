//
//  AppDelegate+PushNotification.swift
//  ecash
//
//  Created by phong070 on 9/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import AVFoundation
import Firebase
extension AppDelegate : UNUserNotificationCenterDelegate , MessagingDelegate{
    //register Push
    func registerPush(application : UIApplication) {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        let options: UNAuthorizationOptions = [.alert, .sound,.badge]
        center.requestAuthorization(options: options) { (granted, error) in
            if !granted {
                print("register push fail")
            }
        }
       Messaging.messaging().delegate = self
       application.registerForRemoteNotifications()
       let token = Messaging.messaging().fcmToken
       debugPrint("FCM token: \(token ?? "")")
    }
    
    func alertRemoteNotification(notification : String, title : String? = nil){
        debugPrint("Call here")
        let content = UNMutableNotificationContent()
        content.sound = .default
        content.title = LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? ""
        if let mtitle = title {
            content.title = mtitle
        }
        //MARK:- Making device always vibrate for the both background and foreground
        content.body = notification
        content.badge = 0
        let request = UNNotificationRequest(identifier: "identifier_\(CommonService.getCurrentMillis())", content: content, trigger: nil)
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError)
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    /*Tap push item*/
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        CommonService.commonEventPush(event: ConfigKey.RequestNavigationNotificationHistory)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        if fcmToken != CommonService.getFirebaseToken(){
            CommonService.setFirebaseToken(data: fcmToken)
            RealtimeMessageHelper.instance.doInitKey()
            debugPrint("Send init key")
        }
    }
    
    func application(_ application: UIApplication,
                   didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
          Messaging.messaging().apnsToken = deviceToken as Data
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        // Print full message.
        debugPrint(userInfo)
        if let mMessage = userInfo as? Dictionary<String, Any>{
            if let mAPNS = mMessage["aps"] as? Dictionary<String, Any>{
                if let mNotifcation = mAPNS["alert"] as? Dictionary<String,Any>{
                    if let mValue =  CommonService.dataToObject(PushNotificationResponseModel.self, data: mNotifcation.json.data(using: .utf8)!){
                        let mNotification = PushNotificationViewModel(data: mValue)
                        //self.alertRemoteNotification(notification: mNotification.body ?? "", title: mNotification.title ?? "")
                        SQLHelper.insertedNotificationHistory(data: NotificationHistoryEntityModel(data: mNotification))
                        CommonService.commonEventPush(event: ConfigKey.RequestCheckAvailableNotification)
                    }
                }else{
                    if let mValue =  CommonService.dataToObject(KeyResponseModel.self, data: mMessage.json.data(using: .utf8)!){
                         let _ = KeyViewModel(data: mValue)
                        Utils.logMessage(object: mValue)
                    }
                }
            }
        }
    }
}
