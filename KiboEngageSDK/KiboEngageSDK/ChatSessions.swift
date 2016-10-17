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
import Alamofire

public class ChatSessions
{

    public init()
    {
        
    }
    
    
    public func getChatSessions()
    {
         var sessionInfoList=[[String:AnyObject]]()
        
        //get chat sessions if previously exists
        print("get chat sessions if previously exists")
        var url=Constants.mainURL+Constants.getChatSessions
    
        var header:[String:String]=["kibo-app-id":DatabaseObjectInitialiser.getInstance().appid,"kibo-app-secret":DatabaseObjectInitialiser.getInstance().secretid,"kibo-client-id":DatabaseObjectInitialiser.getInstance().clientid]
        var hhh=["headers":"\(header)"]
       
        print("header is \(header.description) and customer id is \(DatabaseObjectInitialiser.getInstance().customerid)")
        
            Alamofire.request(.POST,"\(url)",parameters: ["customerid":DatabaseObjectInitialiser.getInstance().customerid],headers:header,encoding: .JSON).validate().responseJSON { response in
            //request, response_, data, error in
            
            if(response.response!.statusCode==200)
            {
                print("request success")
                ////print(response.data.debugDescription)
                print("..1")
               /////print(JSON(response.data!).debugDescription)
                 print("..2")
                
                print(JSON(response.result.value!))
                
                var receivedChatSessions=JSON(response.result.value!)
            
                print("receivedChatSessions count is \(receivedChatSessions.count)")
 
                var TeamsObjectList=[[String:AnyObject]]()
                TeamsObjectList = DatabaseObjectInitialiser.getDB().getTeamsObjectList()
                
                //for each team
                var i=0
                for(i=0;i<TeamsObjectList.count;i++)
                {
                    
                    var channelsList=DatabaseObjectInitialiser.getDB().getMessageChannelsObjectList(TeamsObjectList[i]["_id"] as! String)
                    
                    var j=0
                    
                    //for each channel
                    for(j=0;j<channelsList.count;j++)
                    {
           
                       
                        var messagechannelsArray=[String]()
                       
                        var foundChatSessionAlready=false
                        //for each channel received from server
                        var k=0
                       
                        for(k=0;k<receivedChatSessions.count;k++)
                        {
                            messagechannelsArray=receivedChatSessions[k]["messagechannel"].arrayObject as! [String]
                            var messageChannelLastElement=messagechannelsArray.last!
                            var receivedTeamid=receivedChatSessions[k]["departmentid"].string!
                            
                            if(receivedTeamid == (TeamsObjectList[i]["_id"] as! String)
                                && messageChannelLastElement == (channelsList[j]["_id"] as! String))
                            {
                                foundChatSessionAlready=true
                                break
                            }
                        }
                        
                        if(foundChatSessionAlready==false)
                        {
                            
                            //chat session doesnot exist, create new
                            
                            //store session data in requestIDs table
                            DatabaseObjectInitialiser.getDB().storeRequestIDs(TeamsObjectList[i]["_id"] as! String, msgchannelid: channelsList[j]["_id"] as! String)
                            
                            var requestIDnew=DatabaseObjectInitialiser.getDB().getSingleRequestIDs(TeamsObjectList[i]["_id"] as! String,messagechannel_id: channelsList[j]["_id"] as! String)
                           
                            if(requestIDnew != "")
                                {
                                sessionInfoList.append(["departmentid":TeamsObjectList[i]["_id"] as! String,"messagechannel":channelsList[j]["_id"]!,"request_id":requestIDnew])
                                }
                        }
                        
                    }
                }
                
                /*
                 [
                 {
                 "departmentid" : "5745e4da7329b12e16b0e7b7",
                 "request_id" : "h kaIi5vx 2016 10 17 10 34 4",
                 "is_rescheduled" : "false",
                 "customerID" : "newCustomer1",
                 "requesttime" : "2016-10-17T08:21:05.819Z",
                 "socketid" : "",
                 "_id" : "580489f111e5b3b774b7a998",
                 "agent_ids" : [
                 
                 ],
                 "platform" : "mobile",
                 "messagechannel" : [
                 "574db78d23785bca7c650a0f"
                 ],
                 "customerid" : "57f3335694e8ecba4161c6fd",
                 "__v" : 0,
                 "companyid" : "cd89f71715f2014725163952",
                 "initiator" : "visitor",
                 "status" : "new"
                 },
                 ......
                 ]
                 */
                
                
                //if body null, no chat sessions created
                // call createChatSessions()
                
                //if get data
                
                //start loop and for each session, do
                
                //save request id of that team/channel combination in table
                //DatabaseObjectInitialiser.getDB().updateRequestID(<#T##team_id1: String##String#>, messagechannel_id1: <#T##String#>, request_id1: <#T##String#>)
                
                //end loop
                
            }
            else{
                print("request failed")
                print(response.result.error)
               
                }
        }
    
    }
    
    public func createRequiredChatSessions(sessionInfoList:[[String:AnyObject]])
    {
        var customerInfoList=[String:AnyObject]()
        customerInfoList["customerID"]=DatabaseObjectInitialiser.getInstance().customerid
        for keyname in DatabaseObjectInitialiser.getInstance().optionalDataList.keys {
            print("Key: \(keyname) value: \(DatabaseObjectInitialiser.getInstance().optionalDataList[keyname]!)")
            customerInfoList["\(keyname)"]=DatabaseObjectInitialiser.getInstance().optionalDataList[keyname]!
        }
        customerInfoList["isMobile"]=true
        customerInfoList["companyid"]=DatabaseObjectInitialiser.getInstance().clientid //get from host app 'clientID'
        customerInfoList["platform"]="mobile"
        customerInfoList["status"]="new"
        
        customerInfoList["sessionInfo"]=sessionInfoList
    }
    
    public func createChatSessions()
    {
        //http://api.kibosupport.com/visitorcalls/createbulksession
        
        
        
        let team_id = Expression<String>("team_id")
        let msg_channel_id = Expression<String>("msg_channel_id")
        let request_id = Expression<String>("request_id")
        
        
         var customerInfoList=[String:AnyObject]()
         customerInfoList["customerID"]=DatabaseObjectInitialiser.getInstance().customerid
         for keyname in DatabaseObjectInitialiser.getInstance().optionalDataList.keys {
         print("Key: \(keyname) value: \(DatabaseObjectInitialiser.getInstance().optionalDataList[keyname]!)")
         customerInfoList["\(keyname)"]=DatabaseObjectInitialiser.getInstance().optionalDataList[keyname]!
         }
         customerInfoList["isMobile"]=true
         customerInfoList["companyid"]=DatabaseObjectInitialiser.getInstance().clientid //get from host app 'clientID'
         customerInfoList["platform"]="mobile"
         customerInfoList["status"]="new"
        var TeamsObjectList=[[String:AnyObject]]()
        TeamsObjectList = DatabaseObjectInitialiser.getDB().getTeamsObjectList()
        
        for(var i=0;i<TeamsObjectList.count;i++)
        {
        
        var channelsList=DatabaseObjectInitialiser.getDB().getMessageChannelsObjectList(TeamsObjectList[i]["_id"] as! String)
            
            var j=0
            
            for(j=0;j<channelsList.count;j++)
            {
                DatabaseObjectInitialiser.getDB().storeRequestIDs(TeamsObjectList[i]["_id"] as! String, msgchannelid: channelsList[j]["_id"] as! String)
                
            }
            
        }
        var requestIDsList=DatabaseObjectInitialiser.getDB().getRequestIDsObjectList()
        var sessionInfoList=[[String:AnyObject]]()
      //  var sessionInfoList=[AnyObject]()
                var k=0
        for(k=0;k<requestIDsList.count;k++)
        {
           /* var sessionInfoItem=[String: AnyObject]()
            sessionInfoItem["departmentid"]=requestIDsList[k]["team_id"] as! String
             sessionInfoItem["messagechannel"]=requestIDsList[k]["msg_channel_id"] as! String
             sessionInfoItem["request_id"]=requestIDsList[k]["request_id"] as! String*/
             sessionInfoList.append(["departmentid":requestIDsList[k]["team_id"] as! String,"messagechannel":requestIDsList[k]["msg_channel_id"] as! String,"request_id":requestIDsList[k]["request_id"] as! String])
           /* for keyname in sessionInfoItem.keys {
                print("Key: \(keyname) value: \(sessionInfoItem[keyname]!)")
                sessionInfoList.append["\(keyname)"]=sessionInfoItem[keyname]!
            }*/
            
            //sessionInfoList.append(["departmentid":sessionInfoItem["departmentid"].debugDescription,"messagechannel":sessionInfoItem["messagechannel"].debugDescription,"request_id":sessionInfoItem["request_id"].debugDescription])
        }
        
        
        //customerInfoList["sessionInfo"]=JSON(sessionInfoItem).object

        customerInfoList["sessionInfo"]=sessionInfoList
        print("data sending to API is \(customerInfoList.debugDescription)")


/*     let team_id = Expression<String>("team_id")
 let msg_channel_id = Expression<String>("msg_channel_id")
 let request_id = Expression<String>("request_id")*/
 
 
 
 
        //'email' : email.value,
        //'customerID' : email.value,
        /*sessionInfo :[{
        'departmentid': ,
        'messagechannel' :,
        'request_id' :
        },...]
 */
        //'phone' :  phone.value,
        //'country' : country.value,
        //'companyid' : companyid,
        //'platform': 'mobile',
        //'customerName' : name.value,
        //'isMobile' : "true",
        //'status' : 'new',
        
        
        
        var params = "\"email\" : \"test@y.com\",\"customerID\" : \"testID12323234\",\"phone\" : \"03201211991\",\"platform\": \"mobile\",\"isMobile\" : \"true\",\"status\" : \"new\",\"sessionInfo\" : [{ \"departmentid\" :\"5745e4da7329b12e16b0e7b7\",\"messagechannel\":\"574db78d23785bca7c650a0f\",\"request_id\":\"hIDrKb4B2016929131317\"}]}\""
        
        
        var params2:[String:AnyObject]=[:]
        var params3:[Dictionary<String,AnyObject>]
        params3=[["departmentid":"5745e4da7329b12e16b0e7b7","messagechannel":"574db78d23785bca7c650a0f","request_id":"hIDrKb4B2016929131317"]]
        params2=["customerID":"testID12323234","platform":"mobile","isMobile":"true","status":"new","sessionInfo":params3]
        var url=Constants.mainURL+Constants.createBulksessions
        //print(url.debugDescription)
        /*
         'kibo-app-id' : '5wdqvvi8jyvfhxrxmu73dxun9za8x5u6n59',
         'kibo-app-secret': 'jcmhec567tllydwhhy2z692l79j8bkxmaa98do1bjer16cdu5h79xvx',
         'kibo-client-id': 'cd89f71715f2014725163952',
         */
        var header:[String:String]=["kibo-app-id":DatabaseObjectInitialiser.getInstance().appid,"kibo-app-secret":DatabaseObjectInitialiser.getInstance().secretid,"kibo-client-id":DatabaseObjectInitialiser.getInstance().clientid]
        var hhh=["headers":"\(header)"]
        print("header is \(header.description)")
        
        
        /*
        var proxyConfiguration = [NSObject: AnyObject]()
        proxyConfiguration[kCFNetworkProxiesHTTPProxy] = "10.2.20.18"
        proxyConfiguration[kCFNetworkProxiesHTTPPort] = "9090"
        proxyConfiguration[kCFNetworkProxiesHTTPEnable] = 1
        let sessionConfiguration = Alamofire.Manager.sharedInstance.session.configuration
        sessionConfiguration.connectionProxyDictionary = proxyConfiguration
        var manager = Alamofire.Manager(configuration: sessionConfiguration)
        */
        
        //print("url is \(url)")
        //print("params are \(params2)")
        Alamofire.request(.POST,"\(url)",parameters: customerInfoList,headers:header,encoding: .JSON).response{
            request, response_, data, error in
            
            if(response_?.statusCode==200)
            {
            /* print(response)
             
             
             print(".......")
             print(response.data!)
             print(".......")
             print(response.result.value!)*/
            
            /*
             
             "__v" = 0;
             "_id" = 57c69e61dfff9e5223a8fcb2;
             activeStatus = Yes;
             companyid = cd89f71715f2014725163952;
             createdby = 554896ca78aed92f4e6db296;
             creationdate = "2016-08-31T09:07:45.236Z";
             groupid = 57c69e61dfff9e5223a8fcb1;
             "msg_channel_description" = "This channel is for general discussions";
             "msg_channel_name" = General;
             
             
             */
            print(response_?.statusCode)
           // print(request.debugDescription)
            print(data.debugDescription)
            print(JSON(data!).debugDescription)
            print(error.debugDescription)
            //print(JSON(response.result.value!))
            }

        }
    }
    
    /*public func createChatSessionsOld()
    {
        var TeamsObjectList:[[String:AnyObject]]
        TeamsObjectList = DatabaseObjectInitialiser.getDB().getTeamsObjectList()
        var customeridDataList=[String:AnyObject]()
        customeridDataList["customerID"]=DatabaseObjectInitialiser.getInstance().customerid
        for keyname in DatabaseObjectInitialiser.getInstance().optionalDataList.keys {
            print("Key: \(keyname) value: \(DatabaseObjectInitialiser.getInstance().optionalDataList[keyname]!)")
            customeridDataList["\(keyname)"]=DatabaseObjectInitialiser.getInstance().optionalDataList[keyname]!
        }
        customeridDataList["isMobileClient"]=true
        
        
        

        
        
        for(var i=0;i<TeamsObjectList.count;i++)
        {
            print("teams iteration is for \(TeamsObjectList[i]["deptname"] as! String)")
        var channelsList=DatabaseObjectInitialiser.getDB().getMessageChannelsObjectList(TeamsObjectList[i]["_id"] as! String)
        
        
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
                
                var randomRequestID=(DatabaseObjectInitialiser.randomStringWithLength(5) as String)+"\(TeamsObjectList[i]["_id"] as! String)"+"\(channelsList[j]["_id"] as! String)"
                
                print("request id for team \(i) and channel \(j) is \(randomRequestID) ")
         var agIds = [String]()
         var chArray = [String]()
         chArray.append(channelsList[j]["_id"] as! String)
                var customeridjson = JSON(customeridDataList)
              //  print("customer id JSON object is \(customeridjson.debugDescription)")
         //channel_ID
        // var customeridjson = JSON(["customerID" : DatabaseObjectInitialiser.getInstance().customerid,"email" : "aaaaa@cloudkibo.com","country" : "Pakistan","phone" :   "12323424","companyid" : channelsList[j]["companyid"] as! String,"isMobileClient":false])
                
                print("channel iteration is for \(channelsList[j]["msg_channel_name"] as! String)")
                var socketDataList=[String:AnyObject]()
                
                socketDataList["customerid"]=customeridjson.object
                socketDataList["departmentid"]=TeamsObjectList[i]["_id"] as! String //groupIDdepartment id
                socketDataList["platform"]="mobile"  // "web" or “mobile”
                socketDataList["agent_ids"]=agIds  //initially empty
                socketDataList["group"]=TeamsObjectList[i]["deptname"] as! String //groupname
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
               
                //print("socket data is \(socketDataList.debugDescription)")
                print("emitting join meeting \(socketDataList)")
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
    */
}