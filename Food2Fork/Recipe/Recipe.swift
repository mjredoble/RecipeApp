//
//  Recipe.swift
//  Food2Fork
//
//  Created by Michael Redoble on 18/11/2017.
//  Copyright © 2017 mjredoble. All rights reserved.
//

import Foundation

class Recipe {
    
    var f2fUrl: String
    var imageUrl: String
    var publisher: String
    var publisherUrl: String
    var recipeId: Double?
    var socialRank: Int
    var sourceUrl: String
    var title: String
    var ingredients = [String]()
    
    init(dictionary: [String: AnyObject]) throws {
        f2fUrl = dictionary["f2f_url"] as! String
        imageUrl = dictionary["image_url"] as! String
        publisher = dictionary["publisher"] as! String
        publisherUrl = dictionary["publisher_url"] as! String
        
        if let recId = (dictionary["recipe_id"] as? NSString)?.doubleValue {
            recipeId = recId
        }
        
        socialRank = dictionary["social_rank"] as! Int
        sourceUrl = dictionary["source_url"] as! String
        title = dictionary["title"] as! String
    }
}
