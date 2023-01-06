//
//  WebViewModel.swift
//  Burger Finder
//
//  Created by fyz on 1/5/23.
//

import Foundation

class WebViewModel {
    
    var urlString: String?
    
    func createUrlRequest() -> URLRequest? {
        guard let urlString = urlString else {return nil }
        guard let url = URL(string: urlString) else { return nil}
        return URLRequest(url: url)
    }
}
