//
//  CoreDataManager.swift
//  Burger Finder
//
//  Created by fyz on 12/29/22.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataManagerProtocol {
    func fetchPlaces() -> [Place]
    func filterPlaces(filter : String) -> [Place]
    func savePlace(place: Place)
    func deletePlace(place: Place)
    func deleteAllPlaces()
}

class CoreDataManager:CoreDataManagerProtocol {
    
    static let shared = CoreDataManager()
    private init() {}
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Fetches all placeItems from CoreData and returns a Place array
    func fetchPlaces() -> [Place] {
        var placeItems = [PlaceItem]()
        var places = [Place]()
        do {
            placeItems = try context.fetch(PlaceItem.fetchRequest())
            places = convertPlaceItemToPlace(placeItems: placeItems)
        } catch{
            print("Error fetching images from CoreData :\(error)")
        }
        return places
    }
    
    //Save a place to CoreData as placeItem
    func savePlace(place: Place) {
        
        let placeItem = PlaceItem(context: context)
        let coordinateItem = CoordinateItem(context: context)
        let hoursItem = HoursItem(context: context)
        let locationItem = LocationItem(context: context)
        var photoItems = Set<PhotoItem>()
        
        coordinateItem.latitude = place.geocodes.main.latitude
        coordinateItem.longitude = place.geocodes.main.longitude
        placeItem.coordinates = coordinateItem
        hoursItem.openNow = place.hours.openNow
        hoursItem.display = place.hours.display
        locationItem.formattedAddress = place.location?.formattedAddress
        locationItem.locality = place.location?.locality
        locationItem.postcode = place.location?.postcode
        locationItem.region = place.location?.region
        locationItem.country = place.location?.country
        
        placeItem.id = place.id
        placeItem.distance = Int32(place.distance)
        placeItem.name = place.name

        placeItem.location = locationItem
        placeItem.hours = hoursItem
        placeItem.price = Int32(place.price ?? 0)
        placeItem.website = place.website
        placeItem.phoneNumber = place.phoneNumber
        placeItem.rating = place.rating ?? 0
        
        place.photos?.forEach { photo in
            let photoItem = PhotoItem(context: context)
            photoItem.id = photo.id
            photoItem.prefix = photo.prefix
            photoItem.suffix = photo.suffix
            photoItem.width = Int32(photo.width)
            photoItem.height = Int32(photo.height)
            photoItems.insert(photoItem)
        }
       
        placeItem.photos = photoItems as NSSet
        
        do {
            try context.save()
        } catch {
            print("Error saving places to CoreData :\(error)")
        }
    }
    //Delete selected place
    func deletePlace(place: Place) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "PlaceItem")
        //filters the result that matches with the place id
        fetchRequest.predicate = NSPredicate(format: "id == %@", place.id)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Error deleting the place :\(error)")
        }
        
    }
    
    //Deletes all places in CoreData
    func deleteAllPlaces() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "PlaceItem")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Error deleting all places :\(error)")
        }
    }
    
    //Filter saved places according to search term
    func filterPlaces(filter : String) -> [Place] {
        var placeItems = [PlaceItem]()
        var places = [Place]()
        
        let namePredicate = NSPredicate(format: "name CONTAINS [c] %@", filter)
        let localityPredicate = NSPredicate(format: "location.locality CONTAINS [c] %@", filter)
        
        let fetchRequest: NSFetchRequest<PlaceItem>
        fetchRequest = PlaceItem.fetchRequest()
        
        fetchRequest.predicate = NSCompoundPredicate(
            orPredicateWithSubpredicates: [
                namePredicate,
                localityPredicate
            ]
        )
        do {
            placeItems = try context.fetch(fetchRequest)
            places = convertPlaceItemToPlace(placeItems: placeItems)
        }
        catch(let error) {
        print("Error filtering in CoreData: \(error)")
        }
        return places
    }
    
    private func convertPlaceItemToPlace(placeItems: [PlaceItem]) -> [Place]{
        var places = [Place]()
        placeItems.forEach { placeItem in
            let coordinates = Coordinate(
                latitude: placeItem.coordinates.latitude,
                longitude: placeItem.coordinates.longitude
            )
            let geocodoes = Geocode(
                main: coordinates
            )
            let hours = Hours(
                display: placeItem.hours.display,
                openNow: placeItem.hours.openNow
            )
            let location = Location(
                formattedAddress: placeItem.location?.formattedAddress,
                locality: placeItem.location?.locality,
                country:placeItem.location?.country,
                postcode: placeItem.location?.postcode,
                region: placeItem.location?.region
            )
            var photos = [Photo]()
            placeItem.photos?.forEach({ photo in
                let photo = Photo(id: (photo as AnyObject).id,
                                  prefix: (photo as AnyObject).prefix,
                                  suffix: (photo as AnyObject).suffix,
                                  width: (photo as AnyObject).width,
                                  height: (photo as AnyObject).height)
                photos.append(photo)
            })
            
            let place = Place(
                id: placeItem.id,
                distance: Int(placeItem.distance),
                geocodes: geocodoes,
                hours: hours,
                location: location,
                name: placeItem.name,
                rating: placeItem.rating,
                phoneNumber: placeItem.phoneNumber,
                website: placeItem.website,
                photos: photos,
                price: Int(placeItem.price)
            )
            places.append(place)
        }
        return places
    }
}
