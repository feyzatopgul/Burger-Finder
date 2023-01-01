//
//  LocationManager.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/24/22.
//

import Foundation
import CoreLocation

protocol LocationManagerProtocol {
    func checkLocationService()
    func getCurrentLocation(completion: @escaping ((CLLocation) -> Void))
    func resolvedCurrentLocation(completion: @escaping ((CLLocationCoordinate2D?) -> Void))
    func findLocation(query: String, completion: @escaping (CLLocationCoordinate2D?)->Void)
    var isLocationEnabled: Bool { get set }
}

protocol LocationUpdateDelegate: NSObject {
    func didLocationUpdated()
}

class LocationManager: NSObject, CLLocationManagerDelegate, LocationManagerProtocol {
    
    static let shared = LocationManager()
    private var locationManager = CLLocationManager()
    private var locationCompletion: ((CLLocation) -> Void)?
    var isLocationEnabled = false
    
    //delegate for updating HomeViewController when location authorization changes
    weak var locationDelegate: LocationUpdateDelegate? = nil
    
    func checkLocationService() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationAuthorization()
    }
    
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location is restricted")
        case .denied:
            print("Denied")
        case .authorizedAlways, .authorizedWhenInUse:
            isLocationEnabled = true
            print("Authorized")
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
        locationDelegate?.didLocationUpdated()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
    }
    
    //Get current location as CLLocation
    func getCurrentLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.locationCompletion = completion
        locationManager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        locationCompletion?(location)
        locationManager.stopUpdatingLocation()
    }
    
    //Get current location as locality and administrativeArea in a string
    func resolvedCurrentLocation(completion: @escaping ((CLLocationCoordinate2D?) -> Void)){
        let geocoder = CLGeocoder()
        getCurrentLocation { location in
            geocoder.reverseGeocodeLocation(location, preferredLocale: .current){ placemarks, error in
                guard let place = placemarks?.first, error == nil else {
                    completion(nil)
                    return
                }
                if let coordinate = place.location?.coordinate {
                    completion(coordinate)
                }
            }
        }
    }
    //Find a valid location with a given string query
    func findLocation(query: String, completion: @escaping (CLLocationCoordinate2D?)->Void) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(query) { placemarks, error in
            guard let place = placemarks?.first, error == nil else {
                completion(nil)
                return
            }
            if let coordinate = place.location?.coordinate {
                completion(coordinate)
            }
        }
    }
    
}
