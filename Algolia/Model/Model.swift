//
//  Model.swift
//  Algolia
//
//  Created by abhinav khanduja on 27/08/19.
//  Copyright © 2019 abhinav khanduja. All rights reserved.
//

import Foundation

struct Algolia : Codable {
    let hits : [Hits]
    
    struct Hits : Codable {
        let created_at : String
        let title : String
    }
}
