//
//  APIError.swift
//  CodeBase
//
//  Created by Hafiz on 18/09/2017.
//  Copyright © 2017 github. All rights reserved.
//

import ObjectMapper

struct APIError: Mappable, LocalizedError {
    
    var message: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        message <- map["message"]
    }
    
    var errorDescription: String? {
        return message
    }
}


struct LocalError: Error {
    var errorDescription: String? {
        return "This is an error"
    }
}
