//
//  RecipeDataSource.swift
//  Food2Fork
//
//  Created by Michael Redoble on 18/11/2017.
//  Copyright © 2017 mjredoble. All rights reserved.
//

import UIKit

class RecipeDataSource {
    
    static var listOfReicpe = [Recipe]()
    
    class func searchRecipe(keyword: String, successHandler: (()->Void)? = nil, errorHandler: (()->Void)? = nil) {
        let url = Constants.baseURL + "search"
        let paramString = "key=\(Constants.key)" // add q = for search queries later
        
        var list = [Recipe]()
        
        Communication.makeRequest(
            path: url,
            paramString: paramString,
            httpMethod: "POST",
            successHandler: { data, response in
                do {
                    let receivedData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
                    let jsonArray = receivedData["recipes"] as! [[String: AnyObject]]
                    for item in jsonArray {
                        let recipe = try Recipe(dictionary: item)
                        list.append(recipe)
                    }
                    
                    self.listOfReicpe.removeAll()
                    self.listOfReicpe.append(contentsOf: list)
                    
                    successHandler!()
                }
                catch {
                    NSLog("Error parsing recipe data!!! ")
                    errorHandler!()
                }
        },
            errorHandler: { error ,_ in
            NSLog("Error fetching recipe data!!! \(error)")
                errorHandler!()
        })
    }
    
    class func getRecipe(recipeId: Double, successHandler: (()->Void)? = nil, errorHandler: (()->Void)? = nil) {
        let parameters = "key=\(Constants.key)&rId=\(Int(recipeId))"
        let url = Constants.baseURL + "get"
        
        Communication.makeRequest(
            path: url,
            paramString: parameters,
            httpMethod: "POST",
            successHandler: { data, response in
                do {
                    let receivedData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
                    print(receivedData)
                    
                    successHandler!()
                }
                catch {
                    NSLog("Error parsing recipe data!!! ")
                    errorHandler!()
                }
        },
            errorHandler: { error ,_ in
                NSLog("Error fetching recipe data!!! \(error)")
                errorHandler!()
        })
    }
}
