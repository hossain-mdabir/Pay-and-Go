//
//  LocationModel.swift
//  Pay and Go
//
//  Created by Md Abir Hossain on 04-05-2023.
//

import Foundation
import CoreLocation


struct LocationModel {
    var address: CLPlacemark?
    var name: String?
    var thoroughfare: String?
    var subThoroughfare: String?
    var postalCode: String?
    var subLocality: String?
    var locality: String?
    var administrativeArea: String?
    var subAdministrativeArea: String?
    var areasOfInterest: String?
    var country: String?
    
}
