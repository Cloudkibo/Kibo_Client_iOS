//
//  DatabaseObjectInitialiser.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 06/09/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import Foundation

internal class DatabaseObjectInitialiser
{
    var delegateProgressUpload:showUploadProgressDelegate!
    var uploadInfo=NSMutableArray()
    var appid=""
    var clientid=""
    var secretid=""
    var customerid=""
    var optionalDataList=[String:AnyObject]()
    var database:DatabaseHandler!
    
    
    class func getInstance() -> DatabaseObjectInitialiser
    {
       return sharedInstance
    
    }
    ///- See more at: http://www.theappguruz.com/blog/use-sqlite-database-swift#sthash.cLfkyZBz.dpuf
    
    class func getDB()->DatabaseHandler
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = DatabaseHandler.init(dbName: "kiboEngageDB")
            
            
        }
        return sharedInstance.database

    }
    
    class func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
    }
    
}

protocol showUploadProgressDelegate:class
{
    func updateProgressUpload(progress:Float,uniqueid:String);
}


let sharedInstance = DatabaseObjectInitialiser()















