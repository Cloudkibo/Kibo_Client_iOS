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
    
    public func createChatSessions(companyid:String,name:String,email:String,phone:String)
    {
        var GroupsObjectList:[[String:AnyObject]]
        GroupsObjectList = DatabaseObjectInitialiser.getDB().getGroupsObjectList()
        
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
         
         
         //GroupsObjectList[indexPath.row]["deptname"] as! String
         
         
         // var sessiondata=
            
            
            for(var j=0;j<channelsList.count;j++)
            {
         var agIds = [String]()
         var chArray = [String]()
         chArray.append(channelsList[j]["_id"] as! String)
         //channel_ID
         var customeridjson = JSON(["name" : "sumaira guest","email" : "aaaaa@cloudkibo.com","country" : "Pakistan","phone" :   phone,"companyid" : channelsList[j]["companyid"] as! String,"isMobileClient":false])
                
                print("channel iteration is for \(channelsList[j]["msg_channel_name"] as! String)")
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