//
//  URLFactory.swift
//  Foody
//
//  Created by npiprava on 7/3/15.
//  Copyright (c) 2015 Nit. All rights reserved.
//

import Foundation

/** Builds the URLs needed to call Web services. */
class URLFactory
{
    
    //Mark - serachFood
    class func searchFood (food: String) -> NSURL {
        let absolutePath = baseService + "?q=" + food
        return NSURL(string: absolutePath)!
    }
    
    //Mark - getUrl
    private class func urlWithName(name: String, var args: [String: String]) -> NSURL
    {
        //args["username"] = "Foody"
        let
        baseURL      = baseService,
        queryString  = queryWithArgs(args),
        absolutePath = baseURL + name + "?" + queryString
        return NSURL(string: absolutePath)!
    }
    
    //Mark-parseArgs
    private class func queryWithArgs(args: [String: String]) -> String
    {
        let parts: [String] = reduce(args, [])
        {
            result, pair in
            let
            key   = pair.0,
            value = pair.1,
            part  = "\(key)=\(value)"
            return result + [part]
        }
        return (parts as NSArray).componentsJoinedByString("&")
    }
}
