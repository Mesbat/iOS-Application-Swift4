//
//  Sources.swift
//  yCheck
//
//  Created by Hint Desktop on 01/10/2017.
//  Copyright © 2017 Yacine.M. All rights reserved.
//

import Foundation
import UIKit

class SourceList: Codable {
    let sources: [Sources]
    
    init(sources: [Sources]) {
        self.sources = sources
    }
}

class Sources : Codable {
    let id : String
    let name : String
    let description : String
    let category : String
    
    init(id : String, name : String, description : String, category : String) {
        self.id = id
        self.name = name
        self.description = description
        self.category = category
    }
}
