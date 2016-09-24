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
    var appid=""
    var clientid=""
    var secretid=""
    var customerid=""
    var optionalDataList=[String:AnyObject]()
    /*var companyname:String!
    var companyemail:String!
    var phone:String!
    var account_number:String!
    */
    
    var socketObj:SocketService!=nil
    var database:DatabaseHandler!
    static let sharedInstance = DatabaseObjectInitialiser()
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
    
 private init() {}
    
}