//
//  NetworkError.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import Foundation

enum NetworkError: Error {
    case badRequest(Error)
    case badResponse(URLResponse?)
    case badData
    case badLocalUrl
}
