//
//  LocationManager.swift
//  Pay and Go
//
//  Created by Md Abir Hossain on 04-05-2023.
//

import Foundation
import CoreLocation


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        //        locationManager.distanceFilter = 1.0 // 1.0 meters

        //        if CLLocationManager.locationServicesEnabled() {
        //            locationManager.startUpdatingLocation()
        //            locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        //            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //        locationManager.kCLDistanceFilterNone.distance(to: 1.0) ////////
        locationManager.distanceFilter = 1.0  //      020.0 meters
                                              //        }
    }



    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }

        switch status {
            case .notDetermined: return "notDetermined"
            case .authorizedWhenInUse: return "authorizedWhenInUse"
            case .authorizedAlways: return "authorizedAlways"
            case .restricted: return "restricted"
            case .denied: return "denied"
            default: return "unknown"
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        self.locationStatus = status
        print(#function, self.statusString)

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else { return }
        self.lastLocation = location
        print(#function, location)

    }
}
