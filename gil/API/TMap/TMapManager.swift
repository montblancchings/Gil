//
//  TMapManager.swift
//  gil
//
//  Created by HyungSoo Song on 2021/03/14.
//

import Foundation
import TMapSDK

class TMapManager{
    //Test
    let sP = CLLocationCoordinate2D(latitude: 37.14697470595607, longitude: 127.07138045751294) //내집
    let eP = CLLocationCoordinate2D(latitude: 37.14587205249258, longitude: 127.06676160466189) //오산역
    
    /**
     제가 T Map 으로부터 발급받은 Key입니다. 가져다 쓰지마세요.
     - Description: <#Description#>
     - Date: 20210316
     */
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
//        let sP = CLLocationCoordinate2D(latitude: 37.14697470595607, longitude: 127.07138045751294) //내집
//        let eP = CLLocationCoordinate2D(latitude: 37.14587205249258, longitude: 127.06676160466189) //오산역
        path.findPathDataWithType(.PEDESTRIAN_PATH, startPoint: sP, endPoint: eP) { (lineData, error) in
            guard error == nil else {return}
            guard let data = lineData else {return}
        }
    }
    
    /**
     검색 키워드랑, 반경으로 주변데이터를 원하는 갯수만큼 가져오는 API
     - Parameters radius: 검색할 반경(1~33 / 1 = 1Km)
     - Parameters count: 검색 개수.. .흠.. 아마.. 최대 검색갯수가 될듯?? 갑자기 문뜩.. 요청한 정보다주면서. 리턴할때 짜르는가..?? 그러면 API데이터양은 똑같은거아닌가? ..wireshark로 확인해보자.
     - Returns [TMapPoiItem]:  TMapPoiItem: 전반적으로 장소에대한 기본적인 요소와. Poi Object에 무언갈 담는다. 자세한건 SDK뜯어볼 것.
     - Description: <#Description#>
     - Date: 20210316
     */
    func requestAroundSearch(keywoard: String, completionHandler: @escaping ([TMapPoiItem]?) -> ()){
        let path = TMapPathData()
        
        path.requestFindAroundKeywordPOI(sP, keywordName: keywoard, radius: searchDistanceKM, count: searchKeywoardLimitCount) { (items, error) in
            completionHandler(items)
        }
    }
}

/**
 개인의 걸음 검색 반경. 킬로미터.
 - Description: 음.. 사람이 걸을 수 있는 평균을 잡지만. 개인이 변경할 수 있도록 하면 좋을것같다. 그래서 설정값으로 바꿀 수 있게 하자. 많이 걸을 수도. 졸라 조금 걸을 수도... 위키출처상. 평균 시속 5Km 1시간동안 걸어가는 거리가 필요할까????? 크흠....난 안걷는데...흠... 뭐.. 검색이니까. 3시간 해줒.
 - Date: 20210316
 */
var searchDistanceKM: Int = 15
var searchKeywoardLimitCount: Int = 20

/**
 현재 기기의 위치.
 - Description: <#Description#>
 - Date: 20210316
 */
var myCoordinate: CLLocationCoordinate2D? = CLLocationCoordinate2D(latitude: 37.14697470595607, longitude: 127.07138045751294) //내집
