//
//  SearchViewController+MapView.swift
//  Burger Finder
//
//  Created by fyz on 12/31/22.
//

import Foundation
import UIKit
import MapKit

extension SearchViewController: MKMapViewDelegate {
    
    func configureMapView() {
        view.addSubview(mapView)
        
        //Adjust constraints
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            mapView.topAnchor.constraint(equalTo: locationSearchBar.bottomAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.delegate = self
        
        //Set mapView hidden by default
        mapView.isHidden = true
    }
    
    //Dismiss keyboard when anywhere is tapped on screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func createAnnotations(places: [Place]) {
        //Remove all existing annotations
        let allAnotations = mapView.annotations
        mapView.removeAnnotations(allAnotations)
        
        //Add annotations based on search result
        for place in places {
            let annotation = PlaceAnnotation(
                coordinate: CLLocationCoordinate2D(
                    latitude: place.geocodes.main.latitude,
                    longitude: place.geocodes.main.longitude ),
                title: place.name,
                place: place)
            mapView.addAnnotation(annotation)
        }
        //Zoom to map centered around the searched location to display searched results
        searchViewModel.getCoordinate(location: locationText) {[weak self] coordinate in
            guard let self = self else {return}
            let region =   MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
            self.mapView.setRegion(region, animated: true)
        }
    }
    //Navigate to details view when annotation is tapped on map
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        guard let annotation = view.annotation as? PlaceAnnotation else { return }
        let detailsVC = DetailsViewController()
        detailsVC.place = annotation.place
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
