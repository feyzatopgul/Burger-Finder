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
    
    //multicast delegate pattern for updating views when location authorization changes
    var locationListeners: [LocationUpdateDelegate] = []
    
    func checkLocationService() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationAuthorization()
    }
    
    //Checks location authorization status and performs required actions
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            isLocationEnabled = false
        case .denied:
            isLocationEnabled = false
        case .authorizedAlways, .authorizedWhenInUse:
            isLocationEnabled = true
        @unknown default:
            break
        }
    }
    
    //Called when location authorization status is changed
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
        //Call didLocationUpdated method for listeners
        locationListeners.forEach { $0.didLocationUpdated() }
    }
    
    //Called when locationManager cannot retrieve the location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
    }
    
    //Get current location as CLLocation
    func getCurrentLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.locationCompletion = completion
        locationManager.startUpdatingLocation()
    }
    //Called when new location data is available
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        locationCompletion?(location)
        locationManager.stopUpdatingLocation()
    }
    
    //Get current location as coordinate
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
    
    //Find a valid location as a coordinate with a given string query
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
    
    //Add listener to delegate pattern
    func addListener(locationListener: LocationUpdateDelegate) {
        locationListeners.append(locationListener)
    }
    
    //Remove listener from delegate pattern
    func removeListener(locationListener: LocationUpdateDelegate) {
        if let index = locationListeners.firstIndex(where: { $0 === locationListener }) {
            locationListeners.remove(at: index)
        }
    }
}

