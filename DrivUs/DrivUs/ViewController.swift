//
//  LocationManager.swift
//  DrivUs
//
//  Created by MacBook on 05.03.24.
//

import Foundation
import CoreLocation
import CoreLocationUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        //print(location.self as Any)
        
        // Haversine distance calculation
        
        // person A
        //let lat1 = 48.2590
        //let lon1 = 14.2439
        
        // person B
        //let lat2 = location?.latitude ?? 0.0
        //let lon2 = location?.longitude ?? 0.0
        
        //let distance = haversine(lat1: lat1, lon1: lon1, lat2: lat2, lon2: lon2)
        //print("Distance from fixed location: \(distance) km")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
    
    func haversine(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {
        // distance between latitudes and longitudes
        let dLat = lat2.toRadians - lat1.toRadians
        let dLon = lon2.toRadians - lon1.toRadians
        
        // convert to radians
        let radLat1 = lat1.toRadians
        let radLat2 = lat2.toRadians
        
        // apply formulae
        let a = sin(dLat / 2) * sin(dLat / 2) +
            sin(dLon / 2) * sin(dLon / 2) * cos(radLat1) * cos(radLat2)
        let rad = 6371.0 // Earth radius in kilometers
        let c = 2 * asin(sqrt(a))
        return rad * c
    }
}

extension Double {
    var toRadians: Double {
        return self * .pi / 180.0
    }
}
