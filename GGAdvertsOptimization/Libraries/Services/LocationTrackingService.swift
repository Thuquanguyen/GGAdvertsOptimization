//
//  LocationTrackingService.swift
//  AIC Utilities People
//
//  Created by IchNV-D1 on 5/13/19.
//  Copyright © 2019 Rikkeisoft. All rights reserved.
//

import Foundation

import CoreLocation
import UserNotifications
import GoogleMaps
import GooglePlaces


class LocationTrackingService: NSObject {
    
    // MARK: - Singleton
    static let shared = LocationTrackingService()
    typealias CallbackGMS = (GMSReverseGeocodeResponse?) -> Void
    typealias Callback = (CLLocationCoordinate2D) -> Void

    // MARK: - Variables
    private var mTimer: Timer?
    private var isEnoughTimer = false
    private lazy var locationManager: CLLocationManager = {
        let loc = CLLocationManager()
        loc.delegate = self
        loc.desiredAccuracy = kCLLocationAccuracyBest
        return loc
    }()
    private var lastCoordinate: CLLocationCoordinate2D?
    var currentCoordinate: CLLocationCoordinate2D?
    var currentLocation: CLLocation?

    // MARK: - Constant
    let distanceInMeters: Double = 4500.0
    let duration: Double = 1.5 // seconds
    private let maxCount = 10

    // MARK: - Closures
    var didChangeStatus: ((Bool) -> Void)?
    private var listCallbackGMS: [CallbackGMS] = []
    private var listCallback: [Callback] = []

    var isRunning = false
    private var isAuto = false
    private var isNewValue = false
    
    // MARK: - Initilization
    deinit {
        isAuto = false
        isRunning = false
        isNewValue = false
        mTimer?.invalidate()
        listCallbackGMS.removeAll()
        listCallback.removeAll()
    }
    
    // MARK: - Functions
    func request(_ callback: Callback? = nil) {
        let status = authorizationStatus()
        if status != .denied && status != .restricted {
            if let c = callback {
                listCallback.append(c)
            }
            if isRunning {
                return
            }
            isAuto = false
            isRunning = true
            isNewValue = true
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        } else {
            callback?(UserDefaults.location)
        }
    }
    
    func requestaAuto(_ callback: Callback? = nil) {
        let status = authorizationStatus()
        if status != .denied && status != .restricted {
            if let c = callback {
                listCallback.append(c)
            }
            if isRunning {
                if isAuto && !isNewValue {
                    updateLocation()
                }
                return
            }
            isAuto = true
            isRunning = true
            isNewValue = true
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        } else {
            callback?(UserDefaults.location)
        }
    }
    
//    func request()
    
    @objc func updateLocation() {
        isNewValue = false
        currentLocation = locationManager.location
        currentCoordinate = currentLocation?.coordinate
        if let loc = currentCoordinate {
            UserDefaults.location = loc
            listCallback.forEach{ $0(loc) }
            listCallback.removeAll()
        }
        if !isAuto {
            stopUpdateLocation()
        }
        mTimer?.invalidate()
        mTimer = nil
        if !listCallbackGMS.isEmpty {
            getCityName()
        }
    }

    func authorizationStatus() -> CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    func statusLocation() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            }
        } else {
            return false
        }
    }
    
    func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }
    
    func startUpdateLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdateLocation() {
        isNewValue = false
        isRunning = false
        isAuto = false
        locationManager.stopUpdatingLocation()
    }
    
    func checkAuthorToBackground(manager: CLLocationManager?) {
        if authorizationStatus() == .authorizedAlways {
            locationManager.allowsBackgroundLocationUpdates = true
            if let manager = manager { self.currentCoordinate = manager.location?.coordinate }
        } else if authorizationStatus() == .authorizedWhenInUse {
            locationManager.allowsBackgroundLocationUpdates = false
            if let manager = manager { self.currentCoordinate = manager.location?.coordinate }
        } else {
            locationManager.allowsBackgroundLocationUpdates = false
            self.currentCoordinate = nil
        }
    }
    
    func accessIsDenied() -> Bool {
        let status = authorizationStatus()
        return status == .denied || status == .restricted
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationTrackingService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newestLocation = locations.last {
            currentCoordinate = newestLocation.coordinate
            currentLocation = newestLocation
            if isNewValue && Date().timeIntervalSince(newestLocation.timestamp) < 50 {
                mTimer?.invalidate()
                mTimer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: false)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        updateLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        didChangeStatus?(status != .denied)
//        checkAuthorToBackground(manager: manager)
    }
}


//MARK: Google Map API
extension LocationTrackingService {
    func geocodeCoordinates(location: CLLocation, completion: @escaping (GMSReverseGeocodeResponse?) -> Void) {
        var postalAddress = ""
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(location.coordinate, completionHandler: { (response, error) in
            if let gmsAddress = response?.firstResult(){
                for line in  gmsAddress.lines! {
                    postalAddress += line + " "
                }
            }
            completion(response)
        })
    }
    
    func getLocationWeather(completion: @escaping (GMSReverseGeocodeResponse?) -> Void) {
        if !listCallbackGMS.isEmpty {
            listCallbackGMS.append(completion)
            return
        }
        listCallbackGMS.append(completion)
        if accessIsDenied() {
            getCityName()
        } else {
            if !isNewValue {
                getCityName()
            }
        }
     
    }
    
    func getCityName() {
        var postalAddress = ""
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(UserDefaults.location, completionHandler: {[unowned self] (response, error) in
            if let gmsAddress = response?.firstResult(){
                for line in  gmsAddress.lines! {
                    postalAddress += line + " "
                }
            }
            self.listCallbackGMS.forEach{ $0(response) }
            self.listCallbackGMS.removeAll()
        })
    }
}
