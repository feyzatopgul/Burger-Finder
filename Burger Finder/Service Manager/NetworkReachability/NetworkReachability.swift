//
//  NetworkMonitor.swift
//  Burger Finder
//
//  Created by Feyza Topgul on 1/5/23.
//

import SystemConfiguration
import Foundation

protocol NetworkReachabilityProtocol{
    func isConnectedToNetwork() -> Bool
}

class NetworkReachability: NetworkReachabilityProtocol {
    
    static let shared = NetworkReachability()
    
    //Determines if the device is connected to the network or not
    func isConnectedToNetwork() -> Bool {
        //Creates an addres to check connection
        let reachabilityAddress = SCNetworkReachabilityCreateWithName(nil, "api.foursquare.com")
        //Creates a SCNetworkReachabilityFlags instance and initialize
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags()
        if let reachabilityAddress = reachabilityAddress {
            //Checks if the network target is reachable and fills the flags
            if SCNetworkReachabilityGetFlags(reachabilityAddress, &flags) == false {
                return false
            }
        }
        //If flags contains reachable and not connectionRequired returns true
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let result = (isReachable && !needsConnection)
        return result
    }
}

