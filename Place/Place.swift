//
//  Place.swift
//  Place
//
//  Created by Zubair on 6/1/17.
//  Copyright © 2017 Zubair. All rights reserved.
//

import Foundation

class Place {
    var id: String?
    var hours: String?
    var url: String?
    var description: String?
    var title: String?
    
    init(_ jsonDict: [String: AnyObject]) {
        self.id = jsonDict["id"] as? String
        self.hours = jsonDict["hours"] as? String
        self.url = jsonDict["url"] as? String
        self.description = jsonDict["description"] as? String
        self.title = jsonDict["title"] as? String
    }
}
