//
//  UserLocation.swift
//  Groceries
//
//  Created by Rauan on 22.10.2023.
//

import SwiftUI
import CoreLocation

class UserLocation: NSObject,ObservableObject,CLLocationManagerDelegate {
    @Published var locationManager = CLLocationManager()
    @Published var userLocation: CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            print("unknown")
            self.noLocation = false
            locationManager.requestWhenInUseAuthorization()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userLocation = locations.last
        self.extractLocation()
    }
    func extractLocation() {
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res, err) in
            guard let safeData = res else { return }
            var addressComponents: [String] = []

            if let name = safeData.first?.name {
                addressComponents.append(name)
            }
            
            if let locality = safeData.first?.locality {
                addressComponents.append(locality)
            } else if let administrativeArea = safeData.first?.administrativeArea {
                addressComponents.append(administrativeArea)
            } else if let subLocality = safeData.first?.subLocality {
                addressComponents.append(subLocality)
            }

            // Join the address components with ", " to form the address string.
            self.userAddress = addressComponents.joined(separator: ", ")
        }
    }
}
