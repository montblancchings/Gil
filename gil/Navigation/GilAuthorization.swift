//
//  GilAuthorization.swift
//  gil
//
//  Created by HyungSoo Song on 2021/03/22.
//

import Foundation
import CoreLocation

/**
 앱의 권한 요청자.
 - Description: <#Description#>
 - Date: 20210322
 */
class GilAuthorization: NSObject {
    let authType: GilAuthType
    
    @frozen
    /**
     앱에서 사용될 권한.
     - Description: <#Description#>
     - Date: 20210322
     */
    enum GilAuthType {
        case Location
    }
    
    enum AuthResult {
        case notDetermine
        case accept(userInfo: [String:Any])
        case reject(userInfo: [String:Any])
    }
    
    init(authType: GilAuthType) {
        self.authType = authType
    }
    
    func requestAuth(completionHandler: @escaping (AuthResult) -> ()){
        switch self.authType {
        case .Location:
            let manager = CLLocationManager()
            manager.delegate = self
            manager.requestAlwaysAuthorization()
            break
        }
    }
}

// MARK: Location Authority
extension GilAuthorization: CLLocationManagerDelegate{
    
}
