//
//  Navigator.swift
//  gil
//
//  Created by HyungSoo Song on 2021/03/22.
//

import Foundation
import CoreLocation

/**
 경로 안내자. 반드시, 경로가 존재해야함.
 - Description: <#Description#>
 - Date: 20210322
 */
struct GilNavigator {
    
    /**
     네비게이터가 안내할 경로.
     - Description: 경로는 네비게이터 존재 이유, 경로가 없으면 네비게이터도 없다.
     - Date: 20210322
     */
    let path: GilPath
    
    /**
     나의 위치.
     - Description: <#Description#>
     - Date: 20210322
     */
    lazy var myLocation: () -> (CLLocationCoordinate2D?) = {
        return nil
    }
    
    private mutating func asdf(){
        let s = myLocation()
    }
}

/**
 경로.
 - Description: <#Description#>
 - Date: 20210322
 */
struct GilPath {
}
