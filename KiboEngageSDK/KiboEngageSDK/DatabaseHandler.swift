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
    var teams:Table!
    var messageChannels:Table!
    var userschats:Table!
    var requestIDsTable:Table!
    
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
        createTeamsTable()
        createMessageChannelsTable()
        createRequestIDsTable()
        createChatsTable()
    }
    
    
    
     func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
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
    
    func createChatsTable()
    {
        /*
        'to' : 'All Agents',
        'from' : String, //customer name or customerID
        'visitoremail' :  String //customer email:optional
        'type': 'message',
        'uniqueid' : String, //generate unique message id
        'msg' : String, // message
        'datetime' : Date.now(),
        'request_id' : String, //request id of a session already stored
        'messagechannel': String, //channel id
        'companyid': String,
        'is_seen': String, // ‘yes’/’no’
        'time' : String,//hours,mins
        ‘fromMobile’ : String // ‘yes’ or ‘no’
        */
        
         let to = Expression<String>("to")
         let from = Expression<String>("from")
         let visitoremail = Expression<String>("visitoremail")
         let type = Expression<String>("type")
         let uniqueid = Expression<String>("uniqueid")
         let msg = Expression<String>("msg")
         let datetime = Expression<String>("datetime")
         let request_id = Expression<String>("request_id")
         let messagechannel = Expression<String>("messagechannel")
         let companyid = Expression<String>("companyid")
         let is_seen = Expression<String>("is_seen")
         let time = Expression<String>("time")
         let fromMobile = Expression<String>("fromMobile")
        
        self.userschats = Table("userschats")
        
        do{
            try db.run(userschats.create(ifNotExists: true) { t in
                
                t.column(to)
                t.column(from)
                t.column(visitoremail)
                t.column(type)
                t.column(uniqueid, unique:true)
                t.column(msg)
                t.column(datetime)
                t.column(request_id)
                t.column(messagechannel)
                t.column(companyid)
                t.column(is_seen)
                t.column(time)
                t.column(fromMobile)
                
                })
            
        }
        catch
        {
            print("error in creating credentials table")
            
        }
        

        
    }
    
    func createTeamsTable()
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
        
        self.teams = Table("teams")
        
        do{
            try db.run(teams.create(ifNotExists: true) { t in
                
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
    
    
    func createRequestIDsTable()
    {
        let primeID=Expression<String>("primeID")
        let team_id = Expression<String>("team_id")
        let msg_channel_id = Expression<String>("msg_channel_id")
        let request_id = Expression<String>("request_id")
        let agent_email = Expression<String>("agent_email")

        let agent_id = Expression<String>("agent_id")

        let agent_name = Expression<String>("agent_name")

        
        self.requestIDsTable = Table("requestIDsTable")
        
        do{
            try db.run(requestIDsTable.create(ifNotExists: true) { t in
                t.column(primeID, unique:true)
                t.column(team_id)
                t.column(msg_channel_id)
                t.column(request_id)
                t.column(agent_email,defaultValue:"")
                t.column(agent_id,defaultValue:"")
                t.column(agent_name,defaultValue:"")
                
                
                })
            
        }
        catch
        {
            print("error in creating requestIDsTable table")
            
        }
        
    }
    
    
    func storeRequestIDs(teamid:String,msgchannelid:String){
        
        let primeID=Expression<String>("primeID")
        let team_id = Expression<String>("team_id")
        let msg_channel_id = Expression<String>("msg_channel_id")
        let request_id = Expression<String>("request_id")
        let agent_email = Expression<String>("agent_email")
        
        let agent_id = Expression<String>("agent_id")
        
        let agent_name = Expression<String>("agent_name")
        

        //var requestid=""
        
        var uid=randomStringWithLength(7)
        
        var date=NSDate()
        var calendar = NSCalendar.currentCalendar()
        var year=calendar.components(NSCalendarUnit.Year,fromDate: date).year
        var month=calendar.components(NSCalendarUnit.Month,fromDate: date).month
        var day=calendar.components(.Day,fromDate: date).day
        var hr=calendar.components(NSCalendarUnit.Hour,fromDate: date).hour
        var min=calendar.components(NSCalendarUnit.Minute,fromDate: date).minute
        var sec=calendar.components(NSCalendarUnit.Second,fromDate: date).second
        print("\(year) \(month) \(day) \(hr) \(min) \(sec)")
        var requestid="h \(uid) \(year) \(month) \(day) \(hr) \(min) \(sec)"
        
        var prime=teamid+msgchannelid
        
        do{
            let rowid = try DatabaseObjectInitialiser.getInstance().database.db.run(requestIDsTable.insert(
                primeID<-prime,
                team_id<-teamid,
                msg_channel_id<-msgchannelid,
                request_id<-requestid
                
                
                //lastname<-"",
                //email<-json["email"].string!,
                ))
        }
        catch{
            NSLog("error in saving credentials")
        }
        
    }
    
    func storeCredentials(appID:String,appSecret:String,appClientID:String,customerID:String){
      
        let kiboAppID = Expression<String>("kiboAppID")
        let kiboAppSecret = Expression<String>("kiboAppSecret")
        let kiboClientID = Expression<String>("kiboClientID") //companyid
        //let customerName = Expression<String>("customerName")
        let customerid = Expression<String>("customerid")
        
        do{
             let rowid = try DatabaseObjectInitialiser.getInstance().database.db.run(teams.insert(kiboAppID<-appID,
            kiboAppSecret<-appSecret,
            kiboClientID<-appClientID,
            customerid<-customerID
            
        //lastname<-"",
        //email<-json["email"].string!,
        ))
        }
        catch{
            NSLog("error in saving credentials")
        }
        
    }
    
    
    func storeTeams(deptid:String,deptname1:String,deptDesc:String,compID:String,creeateby:String,datecreation:String,delStatus:String){
        let _id = Expression<String>("_id")
        let deptname = Expression<String>("deptname")
        let deptdescription = Expression<String>("deptdescription")
        let companyid = Expression<String>("companyid")
        let createdby = Expression<String>("createdby")
        let creationdate = Expression<String>("creationdate")
        let deleteStatus = Expression<String>("deleteStatus")
        
        do{
            let rowid = try DatabaseObjectInitialiser.getInstance().database.db.run(teams.insert(_id<-deptid,
                deptname<-deptname1,
                deptdescription<-deptDesc,
                companyid<-compID,
                createdby<-creeateby,
                creationdate<-datecreation,
                deleteStatus<-delStatus
                
            ))
        }
        catch{
            NSLog("error in saving teams data \(error)")
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
    
    func storeChat(to1:String,from1:String,visitoremail1:String,type1:String,uniqueid1:String,msg1:String,datetime1:String,request_id1:String,messagechannel1:String,companyid1:String,is_seen1:String,time1:String,fromMobile1:String)
    {
        let to = Expression<String>("to")
        let from = Expression<String>("from")
        let visitoremail = Expression<String>("visitoremail")
        let type = Expression<String>("type")
        let uniqueid = Expression<String>("uniqueid")
        let msg = Expression<String>("msg")
        let datetime = Expression<String>("datetime")
        let request_id = Expression<String>("request_id")
        let messagechannel = Expression<String>("messagechannel")
        let companyid = Expression<String>("companyid")
        let is_seen = Expression<String>("is_seen")
        let time = Expression<String>("time")
        let fromMobile = Expression<String>("fromMobile")
        
        
        
        self.userschats = Table("userschats")
        
        do{
            //sqliteDB.db.run(tbl_accounts.insert(
            let rowid = try DatabaseObjectInitialiser.getInstance().database.db.run(userschats.insert(to<-to1,
                from<-from1,
                visitoremail<-visitoremail1,
                type<-type1,
                uniqueid<-uniqueid1,
                msg<-msg1,
                datetime<-datetime1,
                request_id<-request_id1,
                messagechannel<-messagechannel1,
                companyid<-companyid1,
                is_seen<-is_seen1,
                time<-time1,
                fromMobile<-fromMobile1
                
                ))
        }
        catch{
            NSLog("error in saving message channels data \(error)")
        }

        
    }
    
    func storeAgentsInfo(agent_email1:String,agent_id1:String,agent_name1:String,request_id1:String)
    {
        let agent_email = Expression<String>("agent_email")
        
        let agent_id = Expression<String>("agent_id")
        
        let agent_name = Expression<String>("agent_name")
        let request_id = Expression<String>("request_id")
        
        do{
            
            
           var query=self.requestIDsTable.select(agent_id,agent_email,agent_name).filter(request_id == request_id1)
            
                try self.db.run(query.update([agent_id<-agent_id1,agent_name<-agent_name1,agent_email<-agent_email]))
                
                
            }
        catch{
            print("error in saving agents info")
        }
         /*   let rowid = try DatabaseObjectInitialiser.getInstance().database.db.run(requestIDsTable.insert(
                primeID<-prime,
                team_id<-teamid,
                msg_channel_id<-msgchannelid,
                request_id<-requestid
                
                
                //lastname<-"",
                //email<-json["email"].string!,
                ))
        }
        catch{
            NSLog("error in saving credentials")
        }
*/
    }
    
    func getAgentsInfo(request_id1:String)->[String:String]
    {
        let agent_email = Expression<String>("agent_email")
        
        let agent_id = Expression<String>("agent_id")
        
        let agent_name = Expression<String>("agent_name")
        let request_id = Expression<String>("request_id")
        
        var result=[String:String]()
        do{
            
            
            var query=self.requestIDsTable.select(agent_id,agent_email,agent_name).filter(request_id == request_id1)
            
           
                
            for agentsinfo in try self.db.prepare(query)
            {   result["agent_id"]=agentsinfo.get(agent_id)
                result["agent_email"]=agentsinfo.get(agent_email)
                result["agent_name"]=agentsinfo.get(agent_name)
            }
        }
           
        catch{
            print("error in fetching agents info")
        }
    
    return result
        
    }
    
    func getSingleTeamObject(teamid:String)->[String: AnyObject]
    {
       // var groupsList=[String:AnyObject]()
        var newEntry: [String: AnyObject] = [:]
       
        let _id = Expression<String>("_id")
        let deptname = Expression<String>("deptname")
        let deptdescription = Expression<String>("deptdescription")
        let companyid = Expression<String>("companyid")
        let createdby = Expression<String>("createdby")
        let creationdate = Expression<String>("creationdate")
        let deleteStatus = Expression<String>("deleteStatus")
        
        self.teams = Table("teams")
        do
        {for teamsnames in try self.db.prepare(self.teams.filter(_id == teamid)){
           
            newEntry["_id"]=teamsnames.get(_id)
            newEntry["deptname"]=teamsnames.get(deptname)
            newEntry["deptdescription"]=teamsnames.get(deptdescription)
            newEntry["companyid"]=teamsnames.get(companyid)
            newEntry["createdby"]=teamsnames.get(createdby)
            newEntry["creationdate"]=teamsnames.get(creationdate)
            newEntry["deleteStatus"]=teamsnames.get(deleteStatus)
            //groupsList.append(newEntry)
            
            
            }
        }
        catch{
            print("failed to get teams single object data")
        }
        return newEntry
        
    }
    
    
    
    func getSingleRequestIDs(teamid:String,messagechannel_id:String)->String
    {
        // var groupsList=[String:AnyObject]()
        var newEntry=""
        
        let team_id = Expression<String>("team_id")
        let msg_channel_id = Expression<String>("msg_channel_id")
        let request_id = Expression<String>("request_id")
        
        self.requestIDsTable = Table("requestIDsTable")
        do
        {for reqIDs in try self.db.prepare(self.requestIDsTable.filter(team_id==teamid && msg_channel_id==messagechannel_id)){
            
            newEntry=reqIDs.get(request_id)
            
            //groupsList.append(newEntry)
            
            
            }
        }
        catch{
            print("failed to get teams single object data")
        }
        return newEntry
        
    }
    
    func getRequestIDsObjectList()->[[String:AnyObject]]
    {
        
        var requestIDsList=[[String:AnyObject]]()
        
        let team_id = Expression<String>("team_id")
        let msg_channel_id = Expression<String>("msg_channel_id")
        let request_id = Expression<String>("request_id")
        
        self.teams = Table("teams")
        do
        {for teamsnames in try self.db.prepare(self.requestIDsTable){
            var newEntry: [String: AnyObject] = [:]
            newEntry["team_id"]=teamsnames.get(team_id)
            newEntry["msg_channel_id"]=teamsnames.get(msg_channel_id)
            newEntry["request_id"]=teamsnames.get(request_id)
            requestIDsList.append(newEntry)
            }
        }
        catch{
            print("failed to get requestIDsList data")
        }
        print("requestIDsList count is \(requestIDsList.count)")
        return requestIDsList
        
    }
    func getTeamsObjectList()->[[String:AnyObject]]
    {
    
        var teamsList=[[String:AnyObject]]()
    
        let _id = Expression<String>("_id")
        let deptname = Expression<String>("deptname")
        let deptdescription = Expression<String>("deptdescription")
        let companyid = Expression<String>("companyid")
        let createdby = Expression<String>("createdby")
        let creationdate = Expression<String>("creationdate")
        let deleteStatus = Expression<String>("deleteStatus")
        
        self.teams = Table("teams")
        do
        {for teamsnames in try self.db.prepare(self.teams){
            var newEntry: [String: AnyObject] = [:]
            newEntry["_id"]=teamsnames.get(_id)
            newEntry["deptname"]=teamsnames.get(deptname)
            newEntry["deptdescription"]=teamsnames.get(deptdescription)
            newEntry["companyid"]=teamsnames.get(companyid)
            newEntry["createdby"]=teamsnames.get(createdby)
            newEntry["creationdate"]=teamsnames.get(creationdate)
            newEntry["deleteStatus"]=teamsnames.get(deleteStatus)
            teamsList.append(newEntry)
        
        
        }
        }
        catch{
            print("failed to get groups data")
        }
    print("teamsList count is \(teamsList.count)")
    return teamsList
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
    
    func getMessageChannelsObjectList(deptid:String)->[[String:AnyObject]]
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
        {for channelNames in try self.db.prepare(self.messageChannels.filter(groupid == deptid)){
            print("channel name for deptid \(deptid) is \(channelNames.get(msg_channel_name))")
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

