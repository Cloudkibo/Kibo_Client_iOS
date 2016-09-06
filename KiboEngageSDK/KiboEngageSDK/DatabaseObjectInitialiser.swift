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
    var database:DatabaseHandler!
    static let sharedInstance = DatabaseObjectInitialiser()
    class func getInstance() -> DatabaseObjectInitialiser
    {
        if(sharedInstance.database == nil)
        {
           sharedInstance.database = DatabaseHandler.init(dbName: "kiboEngageDB")
            
            
        }
        return sharedInstance
    }
    ///- See more at: http://www.theappguruz.com/blog/use-sqlite-database-swift#sthash.cLfkyZBz.dpuf
    
    
 private init() {}
    
}