//
//  Places.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import Foundation

struct Places: Codable, Hashable {
    var results: [Place]
}

struct Place: Codable,Hashable {
    var id: String
    var distance: Int
    var geocodes:Geocode
    var hours: Hours
    var location:Location?
    var name: String
    var rating: Double?
    var phoneNumber: String?
    var website: String?
    var description: String?
    var photos:[Photo]?
    var price: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "fsq_id"
        case distance
        case geocodes
        case hours
        case location
        case name
        case rating
        case phoneNumber = "tel"
        case website
        case description
        case photos
        case price
    }
}

struct Icon: Codable, Hashable {
    var prefix: String
    var suffix: String
}

struct Geocode: Codable, Hashable {
    var main: Coordinate
}

struct Coordinate: Codable, Hashable {
    var latitude: Double
    var longitude: Double
}

struct Hours: Codable, Hashable {
    var display: String?
    var openNow: Bool
    
    enum CodingKeys: String, CodingKey {
        case display
        case openNow = "open_now"
    }
}

struct Location: Codable, Hashable {
    var formattedAddress: String?
    var locality: String?
    var country: String?
    var postcode: String?
    var region: String?
    
    enum CodingKeys: String, CodingKey {
        case formattedAddress = "formatted_address"
        case locality
        case country
        case postcode
        case region
    }
}

struct Photo: Codable, Hashable {
    var id: String
    var prefix:String
    var suffix: String
    var width: Int
    var height: Int
}
