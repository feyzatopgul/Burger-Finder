//
//  NetworkManager.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/23/22.
//

import Foundation

protocol NetworkManagerProtocol {
    func createRequest(for url: String) -> URLRequest?
    func executeRequest<T:Codable>(request: URLRequest, forType: T.Type, completion: @escaping (T?, Error?) -> Void)
}

class NetworkManager:NetworkManagerProtocol {
    
    static var shared = NetworkManager()
    private init() { }
    
    //Creates URLRequest for a given url string
    func createRequest(for url: String) -> URLRequest? {
        guard let url = URL(string: url) else {
            return nil
        }
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        request.httpMethod = NetworkConstants.httpMethod
        request.allHTTPHeaderFields = NetworkConstants.headers
        return request
    }
    
    //Performs network call with a given request and decode the returned JSON into a type 
    func executeRequest<T:Codable>(request: URLRequest, forType: T.Type, completion: @escaping (T?, Error?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, NetworkError.badRequest(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(nil, NetworkError.badResponse(response))
                return
            }
            guard let data = data else {
                completion(nil, NetworkError.badData)
                return
            }
            do {
                let result = try JSONDecoder().decode(forType, from: data)
                completion(result, nil)
            }
            catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
