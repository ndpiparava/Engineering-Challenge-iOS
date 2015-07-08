//
//  JSONService.swift
//  Foody
//
//  Created by npiprava on 7/3/15.
//  Copyright (c) 2015 Nit. All rights reserved.
//
import Foundation

class JSONService
{
    /** Prepares a GET request for the specified URL. */

    
    
    //Mark - getListData
    class func proceedGetFood(url: NSURL, suceess:((listData:NSData!) -> Void)) {
        
        loadDataFromURL(url, completion: {(data,error) -> Void in
            if let urlData = data {
                suceess(listData: urlData)
            }
        })
    }
    
    //Mark - getItemData
    class func proceedGetItems(url: NSURL, suceess:((itemData:NSData!) -> Void)) {
        
        loadDataFromURL(url, completion: {(data,error) -> Void in
            if let urlData = data {
                suceess(itemData: urlData)
            }
        })
    }
    
    
    //Mark - Loaddata
    class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error:NSError?) -> Void) {
        
        var session = NSURLSession.sharedSession()
        
        println("url == \(url)")
        
        //URL NSURLSession to get data from an NSURL
        let loadDataTask =  session.dataTaskWithURL(url, completionHandler: { (data: NSData!, response: NSURLResponse!, error:NSError!) -> Void in
            
            if let responseError = error {
                completion(data: nil, error: responseError)
            }
                
            else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    var statusError = NSError(domain: "com.Foody", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    
                    completion(data: nil, error: statusError)
                }
                else {
                    completion(data: data, error: nil)
                }
            }
        })
        loadDataTask.resume()
    }
}
