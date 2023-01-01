//
//  ImageLoader.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 12/24/22.
//

import Foundation

protocol ImageLoaderProtocol {
    func loadImage(imageUrl: String, completion: @escaping (Data?, Error?) -> Void)
}

class ImageLoader: ImageLoaderProtocol {
    
    static var shared = ImageLoader()
    private init() {}
    
    private var images = NSCache<NSString, NSData>()
    
    func loadImage(imageUrl: String, completion: @escaping (Data?, Error?) -> Void){
        
        guard let url = URL(string: imageUrl) else { return }
        let request = URLRequest(url: url)
        
        if let imageData = images.object(forKey: url.absoluteString as NSString){
            completion(imageData as Data, nil)
            return
        }
        
        let task = URLSession.shared.downloadTask(with: request) {[weak self] localUrl, response, error in
            guard let self = self else { return }
            if let error = error {
                completion(nil, NetworkError.badRequest(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(nil, NetworkError.badResponse(response))
                return
            }
            guard let localUrl = localUrl else {
                completion(nil, NetworkError.badLocalUrl)
                return
            }
            do {
                let data = try Data(contentsOf: localUrl)
                self.images.setObject(data as NSData, forKey: url.absoluteString as NSString)
                completion(data, nil)
            }
            catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
}
