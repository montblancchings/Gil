//
//  ViewController.swift
//  gil
//
//  Created by HyungSoo Song on 2021/03/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
}

struct Test: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try map.decode(String.self, forKey: .name)
    }
}

