//
//  ChannelsViewController.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 08/09/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import UIKit
import SQLite
import SwiftyJSON

class ChannelsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    
    var teamName:String!
    @IBOutlet weak var channelsTitleNavItem: UINavigationItem!
    
    var deptid:String!
    var channelsList=[[String:AnyObject]]()
    @IBOutlet weak var btnback: UIBarButtonItem!
    @IBOutlet weak var tbl_channels: UITableView!
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        
        channelsTitleNavItem.title=teamName
    }
    @IBAction func backbtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        channelsList=DatabaseObjectInitialiser.getDB().getMessageChannelsObjectList(deptid)
        //cell.label1.text=GroupsObjectList[indexPath.row]["deptname"] as! String
        
        /*
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

 */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 66
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return channelsList.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell=tbl_channels.dequeueReusableCellWithIdentifier("channelsCell") as! ChannelsCell
        
        //GroupsObjectList[indexPath.row]["deptname"] as! String
        
        cell.lblChannelName.text=channelsList[indexPath.row]["msg_channel_name"] as! String
        cell.lbl_description.text="Last message will be shown here"
        
        return cell

        
       /* if(indexPath.row==0)
        {
        let cell=tbl_channels.dequeueReusableCellWithIdentifier("channelsCell") as! ChannelsCell
            cell.lblChannelName.text="Ordering"
            cell.lbl_description.text="Your order is ready for pickup"
        
        return cell
        }
        if(indexPath.row==1)
        {
            let cell=tbl_channels.dequeueReusableCellWithIdentifier("channelsCell1") as! ChannelsCell
            
            return cell
        }
        if(indexPath.row==2)
        {
            let cell=tbl_channels.dequeueReusableCellWithIdentifier("channelsCell2") as! ChannelsCell
            
            return cell
        }
        if(indexPath.row==3)
        {
            let cell=tbl_channels.dequeueReusableCellWithIdentifier("channelsCell3") as! ChannelsCell
            
            return cell
        }
        if(indexPath.row==4)
        {
            let cell=tbl_channels.dequeueReusableCellWithIdentifier("channelsCell4") as! ChannelsCell
            
            return cell
        }
        else
        {
            let cell=tbl_channels.dequeueReusableCellWithIdentifier("channelsCell5") as! ChannelsCell
            
            return cell
        }*/
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
