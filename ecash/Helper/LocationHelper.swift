//
//  GlobalVariableHelper.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
import MapKit

class LocationManager: NSObject,CLLocationManagerDelegate {
    // MARK: - Singleton
    static let shared = LocationManager()
    
    var currentLocation: CLLocation?
    fileprivate var getCurrentLocationCallback: ((CLLocation?) -> Void)?
    fileprivate var locationManager: CLLocationManager?
    
    override init() {
        super.init()
    }
    
    func startLocationServices() {
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
    }
    // MARK: - Callback
    func getCurrentLocation(completion: ((_ location: CLLocation?) -> Void)?) {
        self.getCurrentLocationCallback = completion
        self.startStandardUpdates()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // check status
        switch status {
        case .notDetermined:
            manager.requestAlwaysAuthorization()
            break
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        }
    }
    
    func isEnableLocation() -> Bool {
        return CLLocationManager.locationServicesEnabled() && CLLocationManager.authorizationStatus() != .denied
    }
    
    func startStandardUpdates() {
        if isEnableLocation() {
            self.locationManager?.pausesLocationUpdatesAutomatically = true
            self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager?.activityType = CLActivityType.otherNavigation
            self.locationManager?.distanceFilter = 10.0
            self.locationManager?.startUpdatingLocation()
        } else {
            self.startLocationServices()
        }
    }
    
    func stopStandardUpdates() {
        self.getCurrentLocationCallback = nil
        self.locationManager?.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // get location
        if let latestLocation = locations.last {
            print("-------\(latestLocation.coordinate.latitude) -- \(latestLocation.coordinate.longitude)")
            let howRecent = latestLocation.timestamp.timeIntervalSinceNow
            
            if abs(howRecent) <= 5 {
                self.currentLocation = latestLocation
                self.getCurrentLocationCallback?(latestLocation)
                self.stopStandardUpdates()
            } else {
                self.startStandardUpdates()
            }
        } else {
            self.startStandardUpdates()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.getCurrentLocationCallback?(nil)
    }
}
