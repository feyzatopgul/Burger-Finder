//
//  NetworkConstants.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import Foundation

class NetworkConstants {
    
    static let headers = [
      "Accept": "application/json",
      "Authorization": "YOUR_KEY!"
    
    ]
    
    static let httpMethod = "GET"
    
    static func createUrlStringForSearch(search: String, location: String, sort: String, limit: Int) -> String {
        
        guard let encodedSearch = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return "" }
        guard let encodedLocation = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return ""}
        
        return "https://api.foursquare.com/v3/places/search?query=\(encodedSearch)&ll=\(encodedLocation)&categories=13031&fields=fsq_id%2Cname%2Cgeocodes%2Clocation%2Cdistance%2Ctel%2Cwebsite%2Chours%2Crating%2Cprice%2Cphotos&sort=\(sort)&limit=\(limit)"
    }
    
    static func createUrlStringForPhotos(placeId: String) -> String {
        guard let encodedId = placeId.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return ""}
        return "https://api.foursquare.com/v3/places/\(encodedId)/photos?limit=20"
    }
}
