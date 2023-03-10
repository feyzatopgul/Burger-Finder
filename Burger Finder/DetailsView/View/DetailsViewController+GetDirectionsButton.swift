//
//  DetailsViewController+GetDirectionsButton.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/27/22.
//

import Foundation
import CoreLocation
import MapKit

extension DetailsViewController {
    
    //Configure getDirectionsButton
    func configureGetDirectionsButton() {
        //Button configuration
        getDirectionsButton.backgroundColor = UIColor(named: DetailsViewConstants.primaryAppColor)
        getDirectionsButton.setTitle(DetailsViewConstants.getDirectionsTitle, for: .normal)
        getDirectionsButton.setTitleColor(.tertiarySystemBackground, for: .normal)
        getDirectionsButton.tintColor = .white
        getDirectionsButton.layer.cornerRadius = 20
        
        //Add target
        getDirectionsButton.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
        
        //Adjust constraints
        getDirectionsButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            getDirectionsButton.centerXAnchor.constraint(equalTo: detailsScrollView.centerXAnchor),
            getDirectionsButton.topAnchor.constraint(equalTo: detailInfoView.bottomAnchor, constant: 30),
            getDirectionsButton.widthAnchor.constraint(equalToConstant: 150),
            getDirectionsButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    //Show directions on maps
    @objc func getDirections() {
        guard let geoCoord = detailsViewModel.place?.geocodes.main else { return }
        let coordinates = CLLocationCoordinate2DMake(geoCoord.latitude, geoCoord.longitude)
        let regionSpan =   MKCoordinateRegion(center: coordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        mapItem.name = DetailsViewConstants.mapItemName
        mapItem.openInMaps(launchOptions: options)
    }
}
