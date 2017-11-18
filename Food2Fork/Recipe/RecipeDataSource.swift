//
//  RecipeDataSource.swift
//  Food2Fork
//
//  Created by Michael Redoble on 18/11/2017.
//  Copyright © 2017 mjredoble. All rights reserved.
//

import UIKit

class RecipeDataSource {
    typealias SuccessHandler = (Data, URLResponse?) -> ()
    typealias ErrorHandler = (Error, URLResponse?) -> ()
    
    static var listOfReicpe = [Recipe]()
    
    class func searchRecipe(keyword: String, successHandler: (()->Void)? = nil, errorHandler: (()->Void)? = nil) {
        let url = Constants.baseURL + "search"
        var list = [Recipe]()
        
        self.makeRequest(
            path: url,
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
    
    static func makeRequest(path: String, successHandler: @escaping SuccessHandler, errorHandler: @escaping ErrorHandler) {
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
        
        let session = URLSession.shared
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let paramString = "key=\(Constants.key)"
        request.httpBody = paramString.data(using: String.Encoding.utf8)

        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if let _ = response {
                successHandler(data!, response)
            }
            else {
                NSLog("error Serializing JSON: \(error!)")
                errorHandler(error!, response)
            }
        })
        
        task.resume()
    }
    
}
