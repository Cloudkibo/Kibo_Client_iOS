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

class ChannelsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UpdateChannelsDetailsDelegate {

    var delegateChannels:UpdateChannelsDetailsDelegate!
    
    
    var teamName:String!
    @IBOutlet weak var channelsTitleNavItem: UINavigationItem!
    
    var deptid:String!
    var channelsList=[[String:AnyObject]]()
    @IBOutlet weak var btnback: UIBarButtonItem!
    @IBOutlet weak var tbl_channels: UITableView!
    
    var LastMessage=[String]()
    var lastMessageTimestamp=[String]()
    
    
    func retrieveChannels()
    {
        
        
        let to = Expression<String>("to")// agent email or customer id if agent is sender
        let from = Expression<String>("from") //customer id or name
        let visitoremail = Expression<String>("visitoremail")
        let type = Expression<String>("type")
        let uniqueid = Expression<String>("uniqueid")
        let msg = Expression<String>("msg")
        let datetime = Expression<NSDate>("datetime")
        let request_id = Expression<String>("request_id")
        let messagechannel = Expression<String>("messagechannel")
        let companyid = Expression<String>("companyid")
        let is_seen = Expression<String>("is_seen")
        // let time = Expression<String>("time")
        let fromMobile = Expression<String>("fromMobile")
        let status = Expression<String>("status") //pending,sent,delivered,seen
        let customername = Expression<String>("customername") //pending,sent,delivered,seen

        LastMessage.removeAll()
        lastMessageTimestamp.removeAll()
        
        channelsTitleNavItem.title=teamName
        channelsList=DatabaseObjectInitialiser.getDB().getMessageChannelsObjectList(deptid)
        
        for(var i=0;i<channelsList.count;i++)
        {
            var reqidgot=DatabaseObjectInitialiser.getDB().getSingleRequestIDs(channelsList[i]["groupid"] as! String, messagechannel_id: channelsList[i]["_id"] as! String)
            
            let myquerylastmsg=DatabaseObjectInitialiser.getDB().userschats.filter(request_id==reqidgot).order(datetime.desc)
            
            var queryruncount=0
            
            
            
            
            do{for ccclastmsg in try DatabaseObjectInitialiser.getDB().db.prepare(myquerylastmsg) {
                print("date received in chat view is \(ccclastmsg[datetime])")
                LastMessage.append(ccclastmsg[msg])
                
                
                /*var formatter2 = NSDateFormatter();
                 formatter2.dateFormat = "MM/dd, HH:mm"
                 formatter2.timeZone = NSTimeZone.localTimeZone()
                 ///////////////==========var defaultTimeeee = formatter2.stringFromDate(defaultTimeZoneStr!)
                 var defaultTimeeee = formatter2.stringFromDate(ccclastmsg[datetime] as! NSDate)
                 
                 
                 */
                
                
                var formatter2 = NSDateFormatter();
                formatter2.dateFormat = "MM/dd, HH:mm"
                formatter2.timeZone = NSTimeZone.localTimeZone()
                ///////////////==========var defaultTimeeee = formatter2.stringFromDate(defaultTimeZoneStr!)
                var defaultTimeeee = formatter2.stringFromDate(ccclastmsg[datetime])
                
                lastMessageTimestamp.append(defaultTimeeee)
                break
                }
            }
            catch{
                print("errorrr")
            }
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
         Delegates.getInstance().delegateChannelsDetails1=self
       
        retrieveChannels()
        tbl_channels.reloadData()
            }
    @IBAction func backbtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
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
        print("channels count is \(channelsList.count)")
        return channelsList.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell=tbl_channels.dequeueReusableCellWithIdentifier("channelsCell") as! ChannelsCell
        
        //GroupsObjectList[indexPath.row]["deptname"] as! String
        
        cell.lblChannelName.text=channelsList[indexPath.row]["msg_channel_name"] as! String
        if(!LastMessage.isEmpty)
        {
      //  cell.lbl_description.text=LastMessage[indexPath.row]
          //  cell.lblTime.text=lastMessageTimestamp[indexPath.row]
        }
        else{
            cell.lbl_description.text=channelsList[indexPath.row]["msg_channel_description"] as! String
            cell.lblTime.hidden=true
        }
        
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
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        
        //let indexPath = tableView.indexPathForSelectedRow();
        //let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!;
        
        ///print(ContactNames[indexPath.row], terminator: "")
       // if(tblForChat.editing.boolValue==false)
        //{
            self.performSegueWithIdentifier("showChats", sender: nil);
      //  }
        //slideToChat
        
    }
    
    
    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //showChannelsSegue
        
        if segue.identifier == "showChats" {
            
            if let destinationVC = segue.destinationViewController as? ChatsDetailViewController{
                let selectedRow = tbl_channels.indexPathForSelectedRow!.row
                
                //.indexPathForSelectedRow!.row
                destinationVC.team_id=deptid
                destinationVC.messagechannel_id=channelsList[selectedRow]["_id"] as! String
                                
                //destinationVC.participants=self.participantsSelected
                //  let selectedRow = tblForChat.indexPathForSelectedRow!.row
                
            }}
    }

    func refreshChannelsUI(message: String, data: AnyObject!) {
        
        retrieveChannels()
        dispatch_async(dispatch_get_main_queue())
        {
            self.tbl_channels.reloadData()
        }
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
