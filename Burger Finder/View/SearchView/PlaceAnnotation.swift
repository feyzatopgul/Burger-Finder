//
//  PlaceAnnotation.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 1/2/23.
//

import Foundation
import MapKit

//Custom annotation for mapView
class PlaceAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var place: Place

    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, place: Place){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.place = place
    }
    
}
