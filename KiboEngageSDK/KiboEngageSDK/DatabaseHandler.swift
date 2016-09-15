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
    var messageChannels:Table!
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
        createMessageChannelsTable()
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
        let creationdate = Expression<String>("creationdate")
        let deleteStatus = Expression<String>("deleteStatus")
        
        self.groups = Table("groups")
        
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
    
    func createMessageChannelsTable()
    {
        let _id = Expression<String>("_id")
        let msg_channel_name = Expression<String>("msg_channel_name")
        let msg_channel_description = Expression<String>("msg_channel_description")
        let companyid = Expression<String>("companyid")
        let groupid = Expression<String>("groupid")
        let createdby = Expression<String>("createdby")
        let creationdate = Expression<String>("creationdate")
        let deleteStatus = Expression<String>("deleteStatus")
        
        self.messageChannels = Table("messageChannels")
        
        do{
            try db.run(messageChannels.create(ifNotExists: true) { t in
                
                t.column(_id, unique: true)
                t.column(msg_channel_name)
                t.column(msg_channel_description)
                t.column(companyid)
                t.column(groupid)
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
             let rowid = try DatabaseObjectInitialiser.getInstance().database.db.run(groups.insert(kiboAppID<-appID,
            kiboAppSecret<-appSecret,
            kiboClientID<-appClientID,
            companyName<-companyname,
            companyEmail<-companyemail
            
        //lastname<-"",
        //email<-json["email"].string!,
        ))
        }
        catch{
            NSLog("error in saving credentials")
        }
        
    }
    
    
    func storeGroups(deptid:String,deptname1:String,deptDesc:String,compID:String,creeateby:String,datecreation:String,delStatus:String){
        let _id = Expression<String>("_id")
        let deptname = Expression<String>("deptname")
        let deptdescription = Expression<String>("deptdescription")
        let companyid = Expression<String>("companyid")
        let createdby = Expression<String>("createdby")
        let creationdate = Expression<String>("creationdate")
        let deleteStatus = Expression<String>("deleteStatus")
        
        do{
            let rowid = try DatabaseObjectInitialiser.getInstance().database.db.run(groups.insert(_id<-deptid,
                deptname<-deptname1,
                deptdescription<-deptDesc,
                companyid<-compID,
                createdby<-creeateby,
                creationdate<-datecreation,
                deleteStatus<-delStatus
                
            ))
        }
        catch{
            NSLog("error in saving groups data \(error)")
        }
        
    }

    func storeMessageChannel(channelid:String,channelname:String,channelDesc:String,compID:String,groupID:String,creeateby:String,datecreation:String,delStatus:String){
     
        
        let _id = Expression<String>("_id")
        let msg_channel_name = Expression<String>("msg_channel_name")
        let msg_channel_description = Expression<String>("msg_channel_description")
        let companyid = Expression<String>("companyid")
        let groupid = Expression<String>("groupid")
        let createdby = Expression<String>("createdby")
        let creationdate = Expression<String>("creationdate")
        let deleteStatus = Expression<String>("deleteStatus")
        do{
            //sqliteDB.db.run(tbl_accounts.insert(
            let rowid = try DatabaseObjectInitialiser.getInstance().database.db.run(messageChannels.insert(_id<-channelid,
                msg_channel_name<-channelname,
                msg_channel_description<-channelDesc,
                companyid<-compID,
                groupid<-groupID,
                createdby<-creeateby,
                creationdate<-datecreation,
                deleteStatus<-delStatus
                
            ))
        }
        catch{
            NSLog("error in saving message channels data \(error)")
        }
        
    }
    
    func getGroupsObjectList()->[[String:AnyObject]]
    {
    
        var groupsList=[[String:AnyObject]]()
    
        let _id = Expression<String>("_id")
        let deptname = Expression<String>("deptname")
        let deptdescription = Expression<String>("deptdescription")
        let companyid = Expression<String>("companyid")
        let createdby = Expression<String>("createdby")
        let creationdate = Expression<String>("creationdate")
        let deleteStatus = Expression<String>("deleteStatus")
        
        self.groups = Table("groups")
        do
        {for groupsnames in try self.db.prepare(self.groups){
            var newEntry: [String: AnyObject] = [:]
            newEntry["_id"]=groupsnames.get(_id)
            newEntry["deptname"]=groupsnames.get(deptname)
            newEntry["deptdescription"]=groupsnames.get(deptdescription)
            newEntry["companyid"]=groupsnames.get(companyid)
            newEntry["createdby"]=groupsnames.get(createdby)
            newEntry["creationdate"]=groupsnames.get(creationdate)
            newEntry["deleteStatus"]=groupsnames.get(deleteStatus)
            groupsList.append(newEntry)
        
        
        }
        }
        catch{
            print("failed to get groups data")
        }
    print("groupsList count is \(groupsList.count)")
    return groupsList
        /*do{
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
            
        }*/
    }
    
    func getMessageChannelsObjectList()->[[String:AnyObject]]
    {
        
 let _id = Expression<String>("_id")
 let msg_channel_name = Expression<String>("msg_channel_name")
 let msg_channel_description = Expression<String>("msg_channel_description")
 let companyid = Expression<String>("companyid")
 let groupid = Expression<String>("groupid")
 let createdby = Expression<String>("createdby")
 let creationdate = Expression<String>("creationdate")
 let deleteStatus = Expression<String>("deleteStatus")
 
        var channelsList=[[String:AnyObject]]()
        
       /* let _id = Expression<String>("_id")
        let deptname = Expression<String>("deptname")
        let deptdescription = Expression<String>("deptdescription")
        let companyid = Expression<String>("companyid")
        let createdby = Expression<String>("createdby")
        let creationdate = Expression<String>("creationdate")
        let deleteStatus = Expression<String>("deleteStatus")
 */
        
        
        do
        {for channelNames in try self.db.prepare(self.messageChannels){
            var newEntry: [String: AnyObject] = [:]
            newEntry["_id"]=channelNames.get(_id)
            newEntry["msg_channel_name"]=channelNames.get(msg_channel_name)
            newEntry["msg_channel_description"]=channelNames.get(msg_channel_description)
            newEntry["companyid"]=channelNames.get(companyid)
            newEntry["groupid"]=channelNames.get(groupid)
            newEntry["createdby"]=channelNames.get(createdby)
            newEntry["creationdate"]=channelNames.get(creationdate)
            newEntry["deleteStatus"]=channelNames.get(deleteStatus)
            channelsList.append(newEntry)
            
            
            }
        }
        catch{
            print("failed to get channelsList")
        }
        print("channelsList count is \(channelsList.count)")
        return channelsList
        /*do{
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
         
         }*/
    }

    
    }

