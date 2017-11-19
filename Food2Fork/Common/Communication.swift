//
//  Communication.swift
//  Food2Fork
//
//  Created by Michael Redoble on 19/11/2017.
//  Copyright © 2017 mjredoble. All rights reserved.
//

import UIKit

class Communication {
    typealias SuccessHandler = (Data, URLResponse?) -> ()
    typealias ErrorHandler = (Error, URLResponse?) -> ()
    
    static func makeRequest(path: String, paramString: String,  httpMethod: String, successHandler: @escaping SuccessHandler, errorHandler: @escaping ErrorHandler) {
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
        
        let session = URLSession.shared
        request.httpMethod = httpMethod
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
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
