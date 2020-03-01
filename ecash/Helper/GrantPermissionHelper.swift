//
//  GlobalVariableHelper.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import AVFoundation
import UserNotifications
import CoreLocation
import Photos
import Contacts
import ContactsUI

class GrantPermission{
    enum  NotificationAuthorizationStatus : String {
        case notDetermined,denied,authorized
    }
    static func requestNotification(completion :@escaping (NotificationAuthorizationStatus)->()){
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { (settings) in
            switch settings.authorizationStatus{
            case .notDetermined:
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options: [.alert, .sound,.badge]) { (granted, error) in
                    if granted{
                        completion(NotificationAuthorizationStatus.authorized)
                    }else{
                        completion(NotificationAuthorizationStatus.denied)
                    }
                }
                break
            case .denied:
                completion(NotificationAuthorizationStatus.denied)
                break
            case .authorized:
                completion(NotificationAuthorizationStatus.authorized)
                break
            case .provisional:
                break
            @unknown default:
                break
            }
        })
    }
    
    static func checkNotification(completion :@escaping (UNAuthorizationStatus)->()){
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { (settings) in
            switch settings.authorizationStatus{
            case .notDetermined:
                completion(.notDetermined)
                break
            case .denied:
                completion(.denied)
                break
            case .authorized:
                completion(.authorized)
                break
            case .provisional:
                break
            }
        })
    }
    
    static func requestMicPermission(completion :@escaping (AVAudioSession.RecordPermission)->()){
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSessionRecordPermission.granted:
            completion(AVAudioSession.RecordPermission.granted)
        case AVAudioSessionRecordPermission.denied:
            completion(AVAudioSession.RecordPermission.denied)
        case AVAudioSessionRecordPermission.undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
                if granted {
                    completion(AVAudioSession.RecordPermission.granted)
                    print("Granted")
                } else {
                    completion(AVAudioSession.RecordPermission.denied)
                    print("Denied")
                }
            })
        default:
            break
        }
    }
    static func checkMicPermission()->AVAudioSession.RecordPermission{
        var permissionCheck: AVAudioSession.RecordPermission
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSessionRecordPermission.granted:
            permissionCheck = AVAudioSession.RecordPermission.granted
        case AVAudioSessionRecordPermission.denied:
            permissionCheck = AVAudioSession.RecordPermission.denied
        case .undetermined:
            permissionCheck = AVAudioSession.RecordPermission.undetermined
        }
        return permissionCheck
    }
    
    static func checkLocationServiceEnabled() -> CLAuthorizationStatus {
        if CLLocationManager.locationServicesEnabled() {
            return CLLocationManager.authorizationStatus()
        } else {
            return CLAuthorizationStatus.notDetermined
        }
    }
    
    /**
     requestCameraPermission
     */
    static func requestCameraPermission(completion :@escaping (Bool)->()) {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            completion(granted)
        })
    }
    
    /**
     requestCameraPermission
     */
    static func checkCameraPermission() -> AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatus(for: .video)
    }
    
    /**
     requestCameraPermission
     */
    static func requestPhotoPermission(completion :@escaping (Bool)->()) {
        PHPhotoLibrary.requestAuthorization({status in
            if status == .authorized {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    /**
     requestCameraPermission
     */
    static func checkPhotoPermission() -> PHAuthorizationStatus {
        return PHPhotoLibrary.authorizationStatus()
    }
    
    /**
     checktContactPermission
    */
    static func checkContactPermission(completion :@escaping (CNAuthorizationStatus)->()) {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
           completion(CNAuthorizationStatus.authorized)
        case .denied:
           completion(CNAuthorizationStatus.denied)
        case .restricted:
            completion(CNAuthorizationStatus.restricted)
        case .notDetermined:
            completion(CNAuthorizationStatus.notDetermined)
        @unknown default:
             completion(CNAuthorizationStatus.notDetermined)
        }
    }
    
    /**
     requestContactPermission
    */
    static func requestContactPermission(completion :@escaping (Bool)->()){
        CNContactStore().requestAccess(for: .contacts) { (access, error) in
            print("Access: \(access)")
            completion(access)
        }
    }
}
