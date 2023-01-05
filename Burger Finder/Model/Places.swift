//
//  Places.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import Foundation

struct Places: Codable, Hashable {
    let results: [Place]
}

struct Place: Codable,Hashable {
    let id: String
    let geocodes:Geocode
    let hours: Hours
    let location:Location?
    let name: String
    let rating: Double?
    let phoneNumber: String?
    let website: String?
    let photos:[Photo]?
    let price: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "fsq_id"
        case geocodes
        case hours
        case location
        case name
        case rating
        case phoneNumber = "tel"
        case website
        case photos
        case price
    }
}

struct Geocode: Codable, Hashable {
    let main: Coordinate
}

struct Coordinate: Codable, Hashable {
    let latitude: Double
    let longitude: Double
}

struct Hours: Codable, Hashable {
    let display: String?
    let openNow: Bool
    
    enum CodingKeys: String, CodingKey {
        case display
        case openNow = "open_now"
    }
}

struct Location: Codable, Hashable {
    let formattedAddress: String?
    let locality: String?
    
    enum CodingKeys: String, CodingKey {
        case formattedAddress = "formatted_address"
        case locality
    }
}

struct Photo: Codable, Hashable {
    let id: String
    let prefix:String
    let suffix: String
    let width: Int
    let height: Int
}
