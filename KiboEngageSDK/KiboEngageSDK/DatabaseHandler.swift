//
//  DatabaseHandler.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 06/09/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import Foundation
import SQLite
import UIKit

internal class DatabaseHandler:NSObject
{
    
    var db:Connection!
    //var db:Database
    var dbPath:String
    var credentials:Table!
    var groups:Table!
    var userschats:Table!
    var allcontacts:Table!
    var callHistory:Table!
    var statusUpdate:Table!
    var files:Table!
    
    init(dbName:String)
    {print("inside database handler class")
        
        
        
               let fileManager = NSFileManager.defaultManager()
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docsDir1 = dirPaths[0]
        self.dbPath = (docsDir1 as NSString).stringByAppendingPathComponent("kiboEngageDB.sqlite3")
        
        ////////self.db = Database(dbPath)
        do {
            self.db = try Connection(dbPath)
            print(db.description)
            
        }
        catch{
            print("Database Connection failed")
        }
        /////////db=Database(dbPath)
        
        super.init()
      
        
        createCredentialsTable()
        createGroupsTable()
        /*createAllContactsTable()
        createContactListsTable()
        createUserChatTable()
        createMessageSeenStatusTable()
        createCallHistoryTable()
        createFileTable()
        //createAllContactsTable()
        */
    }
    
    func createCredentialsTable()
    {
       print("creating credentials table")
        let kiboAppID = Expression<String>("kiboAppID")
        let kiboAppSecret = Expression<String>("kiboAppSecret")
        let kiboClientID = Expression<String>("kiboClientID")
      
        self.credentials = Table("credentials")
        
        do{
            try db.run(credentials.create(ifNotExists: true) { t in
                
                t.column(kiboAppID)
                t.column(kiboAppSecret)
                t.column(kiboClientID)
                
                })
            
        }
        catch
        {
            print("error in creating credentials table")
            
        }
        

    }
    
    func createGroupsTable()
    {
        /*
         "deptname": "Sales",
         "deptCapital": "SALES",
         "deptdescription": "Sales",
         "companyid": "cd89f71715f2014725163952",
         "createdby": {
         <profile of creator>
         },
         "_id": "56312598eeff671029ad280b",
         "__v": 0,
         "deleteStatus": "No",
         "creationdate": "2015-10-28T19:44:24.057Z"
         }, {
         "__v": 0,
         "_id": "563125adeeff671029ad280c",
         "companyid": "cd89f71715f2014725163952",
         "createdby": {
         <profile of creator>
         },
         "deptCapital": "SUPPORT",
         "deptdescription": "Support",
         "deptname": "Domin Support",
         "deleteStatus": "No",
         "creationdate": "2015-10-28T19:44:45.068Z"
 */
        
        let _id = Expression<String>("_id")
        let deptname = Expression<String>("deptname")
        let deptdescription = Expression<String>("deptdescription")
        let companyid = Expression<String>("companyid")
        let createdby = Expression<String>("createdby")
        let creationdate = Expression<NSDate>("creationdate")
        let deleteStatus = Expression<Bool>("deleteStatus")
        
        self.groups = Table("credentials")
        
        do{
            try db.run(groups.create(ifNotExists: true) { t in
                
                t.column(_id, unique: true)
                t.column(deptname)
                t.column(deptdescription)
                t.column(companyid)
                t.column(createdby)
                t.column(creationdate)
                t.column(deleteStatus)
                
                })
            
        }
        catch
        {
            print("error in creating credentials table")
            
        }
        
        
    }
    
    func storeCredentials(appID:String,appSecret:String,appClientID:String,companyname:String,companyemail:String){
      
        let kiboAppID = Expression<String>("kiboAppID")
        let kiboAppSecret = Expression<String>("kiboAppSecret")
        let kiboClientID = Expression<String>("kiboClientID")
        let companyName = Expression<String>("companyName")
        let companyEmail = Expression<String>("companyEmail")
        
        do{
        let rowid = try DatabaseObjectInitialiser.getInstance() .database.credentials.insert(kiboAppID<-appID,
            kiboAppSecret<-appSecret,
            kiboClientID<-appClientID,
            companyName<-companyname,
            companyEmail<-companyemail
            
        //lastname<-"",
        //email<-json["email"].string!,
        )
        }
        catch{
            NSLog("error in saving credentials")
        }
        
    }
    
    
    func storeGroups(deptid:String,deptname:String,deptDesc:String,compID:String,creeateby:String,datecreation:NSDate,delStatus:Bool){
        let _id = Expression<String>("_id")
        let deptname = Expression<String>("deptname")
        let deptdescription = Expression<String>("deptdescription")
        let companyid = Expression<String>("companyid")
        let createdby = Expression<String>("createdby")
        let creationdate = Expression<NSDate>("creationdate")
        let deleteStatus = Expression<Bool>("deleteStatus")
        do{
            let rowid = try DatabaseObjectInitialiser.getInstance().database.groups.insert(_id<-deptid,
                deptname<-deptname,
                deptdescription<-deptDesc,
                companyid<-compID,
                createdby<-creeateby,
                creationdate<-datecreation,
                deleteStatus<-delStatus
                
            )
        }
        catch{
            NSLog("error in saving groups data")
        }
        
    }
    
    }

