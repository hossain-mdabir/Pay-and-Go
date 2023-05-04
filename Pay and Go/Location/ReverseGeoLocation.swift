//
//  ReverseGeoLocation.swift
//  Pay and Go
//
//  Created by Md Abir Hossain on 04-05-2023.
//

import Foundation
import MapKit


class Location: ObservableObject {
    @Published var userLocation = LocationModel()
    @Published var userLocationString = ""
    
    func reverseGeoLocation(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let geo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let location: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        geo.reverseGeocodeLocation(location, completionHandler:
                                    {(placemarks, error) in
            if (error != nil)
            {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            let location = placemarks! as [CLPlacemark]
            
            if location.count > 0 {
                let pm = placemarks![0]
                self.userLocation.address = pm  // Need to check in future--Added in CIBL Test--
                
                self.userLocation.name = pm.name
                self.userLocation.thoroughfare = pm.thoroughfare
                self.userLocation.subThoroughfare = pm.subThoroughfare
                self.userLocation.postalCode = pm.postalCode
                self.userLocation.subLocality = pm.subLocality
                self.userLocation.locality = pm.locality
                self.userLocation.administrativeArea = pm.administrativeArea
                self.userLocation.subAdministrativeArea = pm.subAdministrativeArea
                self.userLocation.country = pm.country
                
                // Full Address String
                var addressString : String = ""
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                self.userLocationString = addressString
                print(addressString)
            }
        })
    }
}
