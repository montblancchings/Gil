//
//  Network.swift
//  gil
//
//  Created by HyungSoo Song on 2021/03/14.
//

import Foundation

class GilNet{
    
    enum HTTPMethod: String {
        case get = "get"
        case post = "post"
    }
    
    static func request<T: Decodable>(method: HTTPMethod, url: URL, params: [String:Any]?, type: T.Type, completionModel: @escaping (T) -> ()){
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        guard let request = self.createRequest(method: method, url: url, params: params) else {return}
        session.dataTask(with: request) { (_data, _response, _error) in
            guard _error == nil else {return}
            guard let data = _data else {return}
            do{
                let decodeData = try JSONProvider().decode(decodable: type, data: data)
                guard let model = decodeData else {return}
                completionModel(model)
            }catch{
                //error
            }
        }.resume()
    }
    
    private static func createRequest(method: HTTPMethod, url: URL, params: [String:Any]?) -> URLRequest?{
        do{
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.httpBody = try JSONProvider().encodeJsonData(object: params)
            request.allHTTPHeaderFields = ["Connection":"Keep-Alive", "Accept-Charset":"UTF-8", "Content-Type":"application/json"]
            return request
        }catch{
            //error
        }
        
        
        return nil
    }
    
    struct JSONProvider {
        func encodeJsonData(object _obj: [String:Any]?) throws -> Data?{
            do{
                guard let obj = _obj else {return nil}
                let json = try JSONSerialization.data(withJSONObject: obj, options: .fragmentsAllowed)
                return json
            }catch{
                //error
                return nil
            }
        }
        
        func decode<T: Decodable>(decodable: T.Type, data: Data) throws -> T?{
            do{
                let decoder = JSONDecoder()
                let result = try decoder.decode(decodable, from: data)
                return result
            }catch{
                //error
                return nil
            }
        }
    }
}


