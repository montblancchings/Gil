//
//  TMapManager.swift
//  gil
//
//  Created by HyungSoo Song on 2021/03/14.
//

import Foundation
import TMapSDK

class TMapManager{
    
    private let appKey: String = "l7xx578bbe967d274a43a77ed0c2b6468e42"
    
    /**
     TMap API를 사용하기위해 Key를 등록합니다.
     - Date: 20210314
     */
    func registKey(){
        let tempRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        let tMap: TMapView = TMapView(frame: tempRect)
        tMap.setApiKey(appKey)
    }
    
    /**
     검색어 기반 연관검색어를 TMap SDK를 통해 받아옵니다. 
     - Date: 20210314
     */
    func requestAutoComplete(keyword: String, completionHandler: @escaping ([String]?) -> ()){
        let path = TMapPathData()
        path.autoComplete(keyword) { (result, error) in
            guard error == nil else {return completionHandler(nil)}
            completionHandler(result)
        }
    }
    
    /**
     T Map API 경로 데이터
     - Description: <#Description#>
     - Date: 20210314
     */
    func requestPathData(){
        let path = TMapPathData()
        let sP = CLLocationCoordinate2D(latitude: 37.14697470595607, longitude: 127.07138045751294)
        let eP = CLLocationCoordinate2D(latitude: 37.14587205249258, longitude: 127.06676160466189)
        path.findPathDataWithType(.PEDESTRIAN_PATH, startPoint: sP, endPoint: eP) { (lineData, error) in
            guard error == nil else {return}
            guard let data = lineData else {return}
        }
    }
}
