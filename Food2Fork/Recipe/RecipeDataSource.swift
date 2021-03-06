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
        var paramString = "key=\(Constants.key)" // add q = for search queries later
        
        if keyword.count > 0 {
            let processedKeyword = keyword.replacingOccurrences(of: " ", with: ",")
            paramString.append("&q=\(processedKeyword)")
        }
        
        var list = [Recipe]()
        
        Communication.makeRequest(
            path: url,
            paramString: paramString,
            httpMethod: "POST",
            successHandler: { data, response in
                do {
                    let receivedData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
                    
                    if let jsonArray = receivedData["recipes"] {
                        for item in jsonArray as! [[String: AnyObject]] {
                            let recipe = try Recipe(dictionary: item)
                            list.append(recipe)
                        }
                        
                        self.listOfReicpe.removeAll()
                        self.listOfReicpe.append(contentsOf: list)
                        
                        successHandler!()
                    }
                    else {
                        NSLog("Error fetching recipe data!!! ")
                        errorHandler!()
                    }
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
    
    class func getIngredients(recipeId: Double, successHandler: (([String])->Void)? = nil, errorHandler: (()->Void)? = nil) {
        let parameters = "key=\(Constants.key)&rId=\(Int(recipeId))"
        let url = Constants.baseURL + "get"
        
        Communication.makeRequest(
            path: url,
            paramString: parameters,
            httpMethod: "POST",
            successHandler: { data, response in
                do {
                    let receivedData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
                    if let recipe = receivedData["recipe"] {
                        if let ingredients = recipe["ingredients"] {
                            successHandler!(ingredients as! [String])
                        }
                        else {
                            NSLog("Error parsing recipe data!!! ")
                            errorHandler!()
                        }
                    }
                    else {
                        NSLog("Error parsing recipe data!!! ")
                        errorHandler!()
                    }
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
