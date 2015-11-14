//
//  tinyBits.swift
//  SuperCarrito
//
//  Created by Rodolfo Castillo on 14/11/15.
//  Copyright © 2015 Rodolfo Castillo. All rights reserved.
//

import Foundation

class tinyBits {
    func HTTPsendRequest(request: NSMutableURLRequest,callback: (String, String?) -> Void) {
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request,completionHandler :
            {
                data, response, error in
                if error != nil {
                    callback("", (error!.localizedDescription) as String)
                } else {
                    callback(NSString(data: data!, encoding: NSUTF8StringEncoding) as! String,nil)
                }
        })
        
        task.resume() //Tasks are called with .resume()
        
    }
    
    func HTTPGet(url: String, callback: (String, String?) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!) //To get the URL of the receiver , var URL: NSURL? is used
        HTTPsendRequest(request, callback: callback)
    }
    
    
//    let request = NSMutableURLRequest(URL: NSURL(string: "http://google.com")!)
//    
//    func afunc() {
//        let session = NSURLSession.sharedSession()
//        request.HTTPMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        
//        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
//        
//        // or if you think the conversion might actually fail (which is unlikely if you built `params` yourself)
//        //
//        // do {
//        //    request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
//        // } catch {
//        //    print(error)
//        // }
//        
//        let task = session.dataTaskWithRequest(request) { data, response, error in
//            guard data != nil else {
//                print("no data found: \(error)")
//                return
//            }
//            
//            // this, on the other hand, can quite easily fail if there's a server error, so you definitely
//            // want to wrap this in `do`-`try`-`catch`:
//            
//            do {
//                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
//                    let success = json["success"] as? Int                                  // Okay, the `json` is here, let's get the value for 'success' out of it
//                    print("Success: \(success)")
//                } else {
//                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)    // No error thrown, but not NSDictionary
//                    print("Error could not parse JSON: \(jsonStr)")
//                }
//            } catch let parseError {
//                print(parseError)                                                          // Log the error thrown by `JSONObjectWithData`
//                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                print("Error could not parse JSON: '\(jsonStr)'")
//            }
//        }
//        
//        task.resume()
//
//    }
    
}