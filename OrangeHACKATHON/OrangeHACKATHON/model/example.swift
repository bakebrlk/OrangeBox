//
//  example.swift
//  Groceries
//
//  Created by Rauan on 22.10.2023.
//

import SwiftUI
import CoreLocation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentLocation: String = "Fetching Location..."
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func updateLocation(_ newLocation: String) {
        currentLocation = newLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let placemark = placemarks?.first {
                    if let city = placemark.locality, let street = placemark.thoroughfare {
                        self.currentLocation = "\(street), \(city)"
                    } else if let city = placemark.locality {
                        self.currentLocation = city
                    } else {
                        self.currentLocation = "Location not found"
                    }
                }
            }
        }
    }
}

struct LocationView: View {
    @ObservedObject var locationViewModel: LocationViewModel
    @State private var isChangingLocation = false
    
    var body: some View {
        VStack {
            Text("Current Location: \(locationViewModel.currentLocation)")
            Button("Change Location") {
                isChangingLocation.toggle()
            }
        }
        .sheet(isPresented: $isChangingLocation) {
            ChangeLocationView(locationViewModel: locationViewModel, isChangingLocation: $isChangingLocation)
        }
    }
}

struct ChangeLocationView: View {
    @ObservedObject var locationViewModel: LocationViewModel
    @Binding var isChangingLocation: Bool
    @State private var newLocation: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter New Location", text: $newLocation)
            Button("Update Location") {
                locationViewModel.updateLocation(newLocation)
                isChangingLocation = false
            }
            Button("Cancel") {
                isChangingLocation = false
            }
        }
    }
}


