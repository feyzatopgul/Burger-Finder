//
//  LocationManager.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/24/22.
//

import Foundation
import CoreLocation

protocol LocationManagerProtocol {
    func getCurrentLocation(completion: @escaping ((CLLocation) -> Void))
    func resolvedCurrentLocation(completion: @escaping ((String?) -> Void))
}

class LocationManager: NSObject, CLLocationManagerDelegate, LocationManagerProtocol {
    
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    
    private var locationCompletion: ((CLLocation) -> Void)?
    
    private var locationServiceDisabled: Bool = false
    
    private func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    //Check if location is enabled or not
    func isLocationEnabled(completion: @escaping ((Bool) -> Void)){
        if locationManager.authorizationStatus == .denied ||
            locationManager.authorizationStatus == .restricted {
            completion(false)
        } else {
            completion(true)
        }
    }
    
    //Get current location as CLLocation
    func getCurrentLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.locationCompletion = completion
        //checkLocationServices()
        setUpLocationManager()
        locationManager.startUpdatingLocation()
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        locationCompletion?(location)
        locationManager.stopUpdatingLocation()
    }
    
    //Get current location as locality and administrativeArea in a string
    func resolvedCurrentLocation(completion: @escaping ((String?) -> Void)){
        let geocoder = CLGeocoder()
        getCurrentLocation { location in
            geocoder.reverseGeocodeLocation(location, preferredLocale: .current){ placemarks, error in
                guard let place = placemarks?.first, error == nil else {
                    completion(nil)
                    return
                }
                var resolvedLocation = ""
                if let locality = place.locality{
                    resolvedLocation += locality
                }
                if let adminRegion = place.administrativeArea {
                    resolvedLocation += ", \(adminRegion)"
                }
                print("Resolved Location: \(resolvedLocation)")
                completion(resolvedLocation)
            }
        }
    }
    //Find a valid location with a given string query
    func findLocation(query: String, completion: @escaping (String?)->Void) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(query) { placemarks, error in
            guard let place = placemarks?.first, error == nil else {
                completion(nil)
                return
            }
            var validAddress = ""
            if let name = place.name {
                validAddress += name
            }
            if let locality = place.locality{
                validAddress += ", \(locality)"
            }
            if let adminRegion = place.administrativeArea {
                validAddress += ", \(adminRegion)"
            }
            if let country = place.country {
                validAddress += ", \(country)"
            }
            print("Valid address: \(validAddress)")
            completion(validAddress)
        }
    }
}
