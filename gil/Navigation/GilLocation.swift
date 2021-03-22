//
//  GilLocation.swift
//  gil
//
//  Created by HyungSoo Song on 2021/03/22.
//

import Foundation
import CoreLocation

class GilLocation: NSObject, CLLocationManagerDelegate  {
    
    static let shared: GilLocation = {
        return GilLocation()
    }()
    
    private let manager: CLLocationManager = CLLocationManager()
    
    override init() {
        super.init()
        
        self.manager.delegate = self
    }
    
    private var locationHandler: ((CLLocationCoordinate2D) -> ())?
    
    func on(_ completionHandler: @escaping (CLLocationCoordinate2D) -> ()){
        manager.startUpdatingLocation()
        locationHandler = completionHandler
    }
    
    var off: () -> () = {
        
    }
    
    
}
