//
//  Artwork.swift
//  CraftyMe
//
//  Created by Daksh Upadhyay on 2021-12-06.
//  Copyright © 2021 CraftyMe. All rights reserved.

import Foundation
import UIKit
import ObjectMapper

class Artwork: NSObject, Mappable, NSCopying, NSCoding{
    
    // MARK: Properties
        
        var id: String?
        var title: String?
        var createdDate: String?
        var artDescription: String?
        var artworkImageUrl: String?
        
        init(id: String?, title: String?, createdDate: String?, artDescription: String?, artworkImageUrl: String?) {
            self.id = id
            self.title = title
            self.createdDate = createdDate
            self.artDescription = artDescription
            self.artworkImageUrl = artworkImageUrl
        }
        
        func copy(with zone: NSZone? = nil) -> Any {
            return Artwork(id: id, title: title, createdDate: createdDate, artDescription: artDescription, artworkImageUrl: artworkImageUrl)
        }
        
        override init() {
            self.id = nil
            self.title = nil
            self.createdDate = nil
            self.artDescription = nil
            self.artworkImageUrl = nil
        }
        
        // MARK: ObjectMapper Initalizers
        /**
         Map a JSON object to this class using ObjectMapper
         - parameter map: A mapping from ObjectMapper
         */
        required public init?(map: Map){
            
        }
        
        /**
         Map a JSON object to this class using ObjectMapper
         - parameter map: A mapping from ObjectMapper
         */
        public func mapping(map: Map) {
            id <- map["id"]
            title <- map["title"]
            createdDate <- map["createdDate"]
            artDescription <- map["artDescription"]
            artworkImageUrl <- map["artworkImageUrl"]
        }
        
        // MARK: NSCoding Protocol
        
        required public init(coder aDecoder: NSCoder) {
            self.id = aDecoder.decodeObject(forKey: "_id") as? String
            self.title = aDecoder.decodeObject(forKey: "title") as? String
            
        }

        public func encode(with aCoder: NSCoder) {
            aCoder.encode(id, forKey: "_id")
            aCoder.encode(title, forKey: "title")
        }
}
