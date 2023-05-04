//
//  LocationManager.swift
//  Pay and Go
//
//  Created by Md Abir Hossain on 04-05-2023.
//

import Foundation
import CoreLocation


//class LocationManager: NSObject, ObservableObject {
//
//    private let locationManager = CLLocationManager()
//    @Published var location: CLLocation? = nil
//
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//}
//
//extension LocationManager: CLLocationManagerDelegate {
//
//    func locationManager(_ manager: CLLocationManager, didupdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else {
//            return
//        }
//
//        self.location = location
//    }
//}




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
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.distanceFilter = 1.0
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
