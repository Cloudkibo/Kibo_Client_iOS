//
//  ChatSessions.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 24/09/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import Foundation
import SQLite
import SwiftyJSON

public class ChatSessions
{

    public init()
    {
        
    }
    
    public func createChatSessions()
    {
        var GroupsObjectList:[[String:AnyObject]]
        GroupsObjectList = DatabaseObjectInitialiser.getDB().getGroupsObjectList()
        var customeridDataList=[String:AnyObject]()
        customeridDataList["customerID"]=DatabaseObjectInitialiser.getInstance().customerid
        for keyname in DatabaseObjectInitialiser.getInstance().optionalDataList.keys {
            print("Key: \(keyname) value: \(DatabaseObjectInitialiser.getInstance().optionalDataList[keyname]!)")
            customeridDataList["\(keyname)"]=DatabaseObjectInitialiser.getInstance().optionalDataList[keyname]!
        }
        customeridDataList["isMobileClient"]=true
        
        
        

        
        
        for(var i=0;i<GroupsObjectList.count;i++)
        {
            print("group iteration is for \(GroupsObjectList[i]["deptname"] as! String)")
        var channelsList=DatabaseObjectInitialiser.getDB().getMessageChannelsObjectList(GroupsObjectList[i]["_id"] as! String)
        
        
         let _id = Expression<String>("_id")
         let msg_channel_name = Expression<String>("msg_channel_name")
         let msg_channel_description = Expression<String>("msg_channel_description")
         let companyid = Expression<String>("companyid")
         let groupid = Expression<String>("groupid")
         let createdby = Expression<String>("createdby")
         let creationdate = Expression<String>("creationdate")
         let deleteStatus = Expression<String>("deleteStatus")
         
           /// DatabaseObjectInitialiser.getInstance().optionalDataList.ke
         //GroupsObjectList[indexPath.row]["deptname"] as! String
            
         // var sessiondata=
            
            var j=0
            for(j=0;j<channelsList.count;j++)
            {
                
                var randomRequestID=(DatabaseObjectInitialiser.randomStringWithLength(5) as String)+"\(GroupsObjectList[i]["_id"] as! String)"+"\(channelsList[j]["_id"] as! String)"
                
                print("request id for group \(i) and channel \(j) is \(randomRequestID) ")
         var agIds = [String]()
         var chArray = [String]()
         chArray.append(channelsList[j]["_id"] as! String)
                var customeridjson = JSON(customeridDataList)
                print("customer id JSON object is \(customeridjson.debugDescription)")
         //channel_ID
        // var customeridjson = JSON(["customerID" : DatabaseObjectInitialiser.getInstance().customerid,"email" : "aaaaa@cloudkibo.com","country" : "Pakistan","phone" :   "12323424","companyid" : channelsList[j]["companyid"] as! String,"isMobileClient":false])
                
                print("channel iteration is for \(channelsList[j]["msg_channel_name"] as! String)")
                var socketDataList=[String:AnyObject]()
                
                socketDataList["customerid"]=customeridjson.object
                socketDataList["departmentid"]=GroupsObjectList[i]["_id"] as! String //groupIDdepartment id
                socketDataList["platform"]="mobile"  // "web" or “mobile”
                socketDataList["agent_ids"]=agIds  //initially empty
                socketDataList["group"]=GroupsObjectList[i]["deptname"] as! String //groupname
                socketDataList["messagechannel"]=chArray // array of channel ID’s
                socketDataList["channelname"]=channelsList[j]["msg_channel_name"] as! String //name of currnet channel choosen
                //fullurl :  fullurl, //optional
                // currentPage : pathname, //optional
                if(customeridDataList["phone"] != nil)
                 {
                 socketDataList["phone"]=customeridDataList["phone"] as! String
                 
                 }
                socketDataList["requesttime"]=NSDate().description
                socketDataList["status"]="new" //initial value “new”
                socketDataList["device"]="iOS" //android or iOS
                ////socketDataList["device_version"]="9.3"
                ///ipAddress:'192.168.1.2', //optional
                socketDataList["Is_rescheduled"]=false  //initially false
                socketDataList["initiator"]="visitor"
                socketDataList["companyid"]=DatabaseObjectInitialiser.getInstance().clientid //get from host app 'clientID'
                socketDataList["room"]=DatabaseObjectInitialiser.getInstance().clientid
                socketDataList["request_id"]=randomRequestID //generate urself unique id and save
                //webrtc_browser :'true',//optional
                socketDataList["msg"]="User joined session"
               
                print("socket data is \(socketDataList.debugDescription)")
                DatabaseObjectInitialiser.getInstance().socketObj.socket.emit("join meeting",socketDataList)
                
                
                /*
                 var customerid = {‘customerID’ : //mandatory,
                 'name' : name.value //optional : remove key if not available,
                 'email' : email.value //optional,
                 'country' : country.value //optional,
                 'phone' :   phone.value //optional,
                 'companyid' : companyid,
                 'isMobileClient':"false"}*/
                 
                /* DatabaseObjectInitialiser.getInstance().socketObj.socket.emit("join meeting",
                 customerid : customeridjson.object,
                 departmentid : GroupsObjectList[i]["_id"] as String, //groupIDdepartment id
                 platform :"mobile",  // "web" or “mobile”
                 agent_ids : agIds,  //initially empty
                 group:GroupsObjectList[i]["deptname"] as String, //groupname
                 messagechannel : chArray, // array of channel ID’s
                 channelname : channelsList[j]["msg_channel_name"] as String, //name of currnet channel choosen
                 //fullurl :  fullurl, //optional
                // currentPage : pathname, //optional
                    /*if(customeridDataList["phone"] != nil)
                    {
                    phone : customeridDataList["phone"] as String,

                    }*/
                 requesttime:Date.now(),
                 status : "new", //initial value “new”
                 device : “iOS”, //android or iOS
                 device_version:”9.3”
                 ipAddress:'192.168.1.2', //optional
                 Is_rescheduled:"false",  //initially false
                 initiator : 'visitor',
                 companyid : companyid, //get from host app
                 room: companyid,
                 request_id : unique_id, //generate urself unique id and save
                 webrtc_browser :'true',//optional
                 msg : 'User joined session',
                 };*/

 
                
                //=====
                
                
         /*{‘customerID’ : //mandatory,
         'name' : name.value //optional : remove key if not available,
         'email' : email.value //optional,
         'country' : country.value //optional,
         'phone' :   phone.value //optional,
         */
         
            
            
            /*DatabaseObjectInitialiser.getInstance().socketObj.socket.emit("join meeting",
         ["customerid" : customeridjson.object,
         "departmentid" : channelsList[j]["groupid"] as! String, //groupID
         "platform" : "mobile",  // "web" or “mobile”
         "agent_ids" : agIds,  //initially empty
         ////"group" : "Finance", //groupname //---------------------------
            "group" : GroupsObjectList[i]["deptname"] as! String, //groupname //---------------------------
            "messagechannel" : chArray, // array of channel ID’s
         "channelname": channelsList[j]["msg_channel_name"] as! String, //name of currnet channel choosen
         "fullurl" :  "", //optional
         "currentPage" : "", //optional
         "phone" :  phone,
         "requesttime":NSDate().description,
         "status" : "new", //initial value “new”
         "device" : "iOS", //android or iOS
         "device_version":"",
         //"ipAddress":"", //optional
         "Is_rescheduled":false,  //initially false
         "initiator" : "visitor",
         "companyid" : channelsList[j]["companyid"] as! String, //get from host app
         "room": channelsList[j]["companyid"] as! String,
         "request_id" : "sd8sdoh8v9sdvhsvusd98w4hfkfjsds", //generate urself unique id and save
         "webrtc_browser":"",//optional
         "msg" : "User joined session"]
         )*/
            }
        }
    }
    
}