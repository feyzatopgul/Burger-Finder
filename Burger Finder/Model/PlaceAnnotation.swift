//
//  PlaceAnnotation.swift
//  Burger Finder
//
//  Created by fyz on 12/31/22.
//

import Foundation
import MapKit

//Custom annotation for mapView
class PlaceAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var place: Place

    init(coordinate: CLLocationCoordinate2D, title: String, place: Place){
        self.coordinate = coordinate
        self.title = title
        self.place = place
    }
    
}
