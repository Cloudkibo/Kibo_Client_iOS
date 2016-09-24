//
//  ChatSessions.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 24/09/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import Foundation

class ChatSessions
{
    
    func createChatSessions(companyid:String,name:String,email:String,phone:String)
    {
        
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
         var agIds = [String]()
         var chArray = [String]()
         chArray.append(channelsList[0]["_id"] as! String)
         //channel_ID
         var customeridjson = JSON(["name" : "sumaira saeed","email" : "aaaaa@cloudkibo.com","country" : "Pakistan","phone" :   "1234567899","companyid'" : channelsList[0]["companyid"] as! String,"isMobileClient":false])
         /*{‘customerID’ : //mandatory,
         'name' : name.value //optional : remove key if not available,
         'email' : email.value //optional,
         'country' : country.value //optional,
         'phone' :   phone.value //optional,
         */
         DatabaseObjectInitialiser.getInstance().socketObj.socket.emit("join meeting",
         ["customerid" : customeridjson.object,
         "departmentid" : channelsList[0]["groupid"] as! String, //groupID
         "platform" : "mobile",  // "web" or “mobile”
         "agent_ids" : agIds,  //initially empty
         "group" : "Finance", //groupname //---------------------------
         "messagechannel" : chArray, // array of channel ID’s
         "channelname": channelsList[0]["msg_channel_name"] as! String, //name of currnet channel choosen
         "fullurl" :  "", //optional
         "currentPage" : "", //optional
         "phone" :  "1234567899",
         "requesttime":NSDate().description,
         "status" : "new", //initial value “new”
         "device" : "iOS", //android or iOS
         "device_version":"9.3",
         "ipAddress":"", //optional
         "Is_rescheduled":false,  //initially false
         "initiator" : "visitor",
         "companyid" : channelsList[0]["companyid"] as! String, //get from host app
         "room": channelsList[0]["companyid"] as! String,
         "request_id" : "sd8sdoh8v9sdvhsvusd98w4hfkfjsds", //generate urself unique id and save
         "webrtc_browser":"",//optional
         "msg" : "User joined session"]
         )
         
 
    }
    
}