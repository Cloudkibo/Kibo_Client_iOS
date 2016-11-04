//
//  ChatsDetailViewController.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 10/09/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON
import AssetsLibrary
import Photos
import MobileCoreServices

public class ChatsDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIDocumentPickerDelegate,UIDocumentMenuDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UpdateChatDetailsDelegate {
   
    
    var urlLocalFile:NSURL! //in appdelegate
    var filePathImage:String!
    ////** new commented april 2016var fileSize:Int!
    var fileContents:NSData!
    var selectedImage:UIImage!
    var filename=""
    var fileSize1:UInt64=0
  //  var filePathImage:String!
    var shareMenu = UIAlertController()
  //  var filename="test"
    //var requestIDsObject:[String:AnyObject] = [:]
    var delegateChatDetails1:UpdateChatDetailsDelegate!
    var messages:NSMutableArray!
    var request_id=""
    var messagechannel_id=""
    var team_id=""
    var channelname="FAQs"
    @IBOutlet weak var viewfortableandtextfield: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnSendChat: UIButton!
    @IBOutlet weak var composeView: UIView!
    
    @IBOutlet weak var txtFieldPost: UITextField!
    
    @IBOutlet var tblForGroupChat: UITableView!
    
    @IBOutlet weak var navigationBarTitleForChat: UINavigationItem!
    @IBAction func backBtnPressed(sender: AnyObject) {
          self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    
    
    func retrieveFromDatabase(completion:(result:Bool)->())
    {
         var tempmessages=NSMutableArray()
        var chatsList=DatabaseObjectInitialiser.getDB().getChat(request_id)
        
        var updateStatusArray=[[String:AnyObject]]()
        
        var i=0
        for(i=0;i<chatsList.count;i++)
        {
            var updateStatusData=[String:AnyObject]()
            
            //i am sender
            if((chatsList[i]["to"] as! String) != DatabaseObjectInitialiser.getInstance().customerid)
            {
                //i sent so type is 2
                tempmessages.addObject(["message":"\(chatsList[i]["msg"] as! String) \(chatsList[i]["status"] as! String)", "type":"2", "date":chatsList[i]["datetime"]!.description as! String, "uniqueid":chatsList[i]["uniqueid"] as! String])
                
              //  tempmessages.addObject(chatsList[i]["msg"] as! String, ofType: "2",date:chatsList[i]["datetime"] as! String, uniqueid: chatsList[i]["uniqueid"] as! String)

                
            }
            else
            {
                //agent is sender
                var currentstatus=chatsList[i]["status"] as! String
               if((currentstatus=="delivered") || (currentstatus=="sent"))
               {
                    updateStatusData["uniqueid"]=chatsList[i]["uniqueid"] as! String
                    updateStatusData["request_id"]=chatsList[i]["request_id"] as! String
                    updateStatusData["status"]="seen"
                // do in response of server
                
               // DatabaseObjectInitialiser.getDB().updateChatStatus(chatsList[i]["uniqueid"] as! String, requestid1: chatsList[i]["request_id"] as! String, status1: "seen")
                    updateStatusArray.append(updateStatusData)

                }
                
                tempmessages.addObject(["message":chatsList[i]["msg"] as! String, "type":"1", "date":chatsList[i]["datetime"]!.description as! String, "uniqueid":chatsList[i]["uniqueid"] as! String])
               
                
                
            }
            
        }
        //send status update array of "seen" to server
        if(updateStatusArray.count>0)
        {
            print("count updateStatusArray is \(updateStatusArray.count)")
        updateStatus(updateStatusArray)
        }
        
            messages.setArray(tempmessages as [AnyObject])
        completion(result:true)
    }
    
    
    func updateStatus(updateStatusData:[[String:AnyObject]])
    {
        
        print("inside updateStatus function updateStatusData is \(updateStatusData)")
        
        var url=Constants.mainURL+Constants.updateStatus
        
        var header:[String:String]=["kibo-app-id":DatabaseObjectInitialiser.getInstance().appid,"kibo-app-secret":DatabaseObjectInitialiser.getInstance().secretid,"kibo-client-id":DatabaseObjectInitialiser.getInstance().clientid]
        
        print("headers are \(header.description)")
        var messagesArray=[String:AnyObject]()
        messagesArray["messages"]=updateStatusData
        Alamofire.request(.POST,"\(url)",parameters:messagesArray,headers:header,encoding: .JSON).validate().responseJSON { response in
            print("updating status API called \(messagesArray)")
            if(response.response?.statusCode == 200)
            { print("response is \(response.response?.debugDescription)")
                var statusjson=JSON(response.result.value!)
                print("statusUpdate API result json is \(statusjson["status"])")
                if(statusjson["status"].string == "statusUpdated")
                {
                    //update local database
                    for(var i=0;i<updateStatusData.count;i++)
                    {
                        DatabaseObjectInitialiser.getDB().updateChatStatus(updateStatusData[i]["uniqueid"] as! String, requestid1: updateStatusData[i]["request_id"] as! String, status1: updateStatusData[i]["status"] as! String)
                    }
                    
                
                    Delegates.getInstance().UpdateChatDetailsDelegateCall()
                }
                else{
                    print("error in status Update")
                }
                
            }
            else
            {
                print(response.debugDescription)
                print("error: calling statusUpdate API failed")
            }
            
        }
    }

    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.viewfortableandtextfield.frame.origin.y -= keyboardSize.height
            // self.view.frame.origin.y -= keyboardSize.height
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.viewfortableandtextfield.frame.origin.y += keyboardSize.height
            //self.view.frame.origin.y += keyboardSize.height
        }
    }
    
    public override func viewWillAppear(animated: Bool) {
        print("getting channel name, message id is \(messagechannel_id)")
        var gotname=DatabaseObjectInitialiser.getDB().getChannelName(messagechannel_id)
        if(gotname != nil && gotname != "")
        {
        navigationBarTitleForChat.title = gotname
        }
        retrieveFromDatabase({result->() in
            
            dispatch_async(dispatch_get_main_queue())
            {
                
                self.tblForGroupChat.reloadData()
                if(self.messages.count>1)
                {
                    var indexPath = NSIndexPath(forRow:self.messages.count-1, inSection: 0)
                    self.tblForGroupChat.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
                    
                }
            }
        })
    }
    public override func viewDidLoad() {
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        
        
        Delegates.getInstance().delegateChatDetails1=self
        print("team id is \(team_id)")
        print("messageid is \(messagechannel_id)")
        
        messages=NSMutableArray()
        
        var requestIDsObject=DatabaseObjectInitialiser.getDB().getSingleRequestIDsList(team_id,messagechannel_id:messagechannel_id)
        print("requestIDsObject \(requestIDsObject)")
        request_id=requestIDsObject["request_id"] as! String
        //request_id=DatabaseObjectInitialiser.getDB().getSingleRequestIDs(team_id,messagechannel_id:messagechannel_id)
        
        print("req id is \(request_id)")
        print("reqid list is \(DatabaseObjectInitialiser.getDB().getSingleRequestIDs)")
        
       /* retrieveFromDatabase({result->() in
            
            dispatch_async(dispatch_get_main_queue())
            {
                
                self.tblForGroupChat.reloadData()
                if(self.messages.count>1)
                {
                    var indexPath = NSIndexPath(forRow:self.messages.count-1, inSection: 0)
                    self.tblForGroupChat.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
                    
                }
            }
        })*/
        
        
        
        
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
    
    
    
    func textFieldShouldReturn (textField: UITextField!) -> Bool{
        txtFieldPost.resignFirstResponder()
        
        var duration : NSTimeInterval = 0
        
        /* UIView.animateWithDuration(duration, delay: 0, options:[], animations: {
         self.viewForContent.contentOffset = CGPointMake(0, 0)
         
         }, completion:{ (true)-> Void in
         self.showKeyboard=false
         })
         */
        return true
        
        
    }
    
    @IBAction func btnSendTapped(sender: AnyObject) {
        
        
        ///  sqliteDB.SaveChat("\(selectedContact)", from1: username!, owneruser1: username!, fromFullName1: displayname, msg1: txtFldMessage.text!, date1: nil, uniqueid1: uniqueID, status1: statusNow, type1: "chat", file_type1: "", file_path1: "")
        
        
        // sqliteDB.SaveChat("\(selectedContact)", from1: "\(username!)",owneruser1: "\(username!)", fromFullName1: "\(loggedFullName!)", msg1: "\(txtFldMessage.text!)",date1: nil,uniqueid1: uniqueID, status1: statusNow)
        
        /*socketObj.socket.emitWithAck("im",["room":"globalchatroom","stanza":imParas])(timeoutAfter: 150000)
         {data in
         
         
         }*/
        
        
        var status="pending"
        var chatdata=[String:AnyObject]()
        //Session has been assigned
        
        var requestIDsObject=DatabaseObjectInitialiser.getDB().getSingleRequestIDsList(team_id,messagechannel_id:messagechannel_id)
        print("requestIDsObject[agent_id] as! String is \(requestIDsObject["agent_id"] as! String)")
        
        var stringAngentsToField=""
        if((requestIDsObject["agent_id"] as! String) != "")
        {
            print("agents id is available \(requestIDsObject["agent_id"] as! String)")
            var agentIDsArrayList=(requestIDsObject["agent_id"] as! String).componentsSeparatedByString(",")
            var agentEmailsArrayList=(requestIDsObject["agent_email"] as! String).componentsSeparatedByString(",")
            var agentNamesArrayList=(requestIDsObject["agent_name"] as! String).componentsSeparatedByString(",")
            
            chatdata["to"]=agentNamesArrayList
            chatdata["agentemail"]=agentEmailsArrayList
            chatdata["agentid"]=agentIDsArrayList
            chatdata["toagent"]=agentEmailsArrayList
            
            stringAngentsToField=agentNamesArrayList.joinWithSeparator(",")
            
        }
            //Session has not yet been assigned
        else{
            stringAngentsToField="All Agents"
            chatdata["to"]="All Agents"
        }
        chatdata["from"]=DatabaseObjectInitialiser.getInstance().customerid
        
        
        var emailfield=""
        if((DatabaseObjectInitialiser.getInstance().optionalDataList["email"]) != nil)
        {
            print("email field not nil it exists")
            emailfield=DatabaseObjectInitialiser.getInstance().optionalDataList["email"] as! String
            chatdata["visitoremail"]=DatabaseObjectInitialiser.getInstance().optionalDataList["email"]
        }
        chatdata["type"]="message"
        //generate uniqueid
        
        
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
        var uniqueid="h \(uid) \(year) \(month) \(day) \(hr) \(min) \(sec)"
        
        
        
        //var uniqueid="aaaaaaaa"
        chatdata["uniqueid"]=uniqueid
        chatdata["msg"]=txtFieldPost.text
        chatdata["datetime"]=NSDate().debugDescription
        chatdata["request_id"]=request_id
        chatdata["messagechannel"]=messagechannel_id
        chatdata["companyid"]=DatabaseObjectInitialiser.getInstance().clientid
        chatdata["is_seen"]="no"
       // chatdata["time"]=NSDate().description
        chatdata["fromMobile"]="yes"
        
        //currently status is pending
        chatdata["status"]=status
        
        var customername=""
        if((DatabaseObjectInitialiser.getInstance().optionalDataList["customerName"]) != nil)
        {
            print("customerName field not nil it exists")
            customername=DatabaseObjectInitialiser.getInstance().optionalDataList["customerName"] as! String
            chatdata["customername"]=DatabaseObjectInitialiser.getInstance().optionalDataList["customerName"]
            
            
        }
       /*
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone=NSTimeZone.localTimeZone()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        var dateFormatted=dateFormatter.dateFromString(chatdata["datetime"] as! String)
        
        */
        //cant store array, change it to string field 'stringAngentsToField'
        DatabaseObjectInitialiser.getDB().storeChat(stringAngentsToField,from1:chatdata["from"] as! String,visitoremail1:emailfield,type1:chatdata["type"] as! String,uniqueid1:chatdata["uniqueid"] as! String,msg1:chatdata["msg"] as! String,datetime1:NSDate(),request_id1:chatdata["request_id"] as! String,messagechannel1:chatdata["messagechannel"] as! String,companyid1:chatdata["companyid"] as! String,is_seen1:chatdata["is_seen"] as! String,fromMobile1:chatdata["fromMobile"] as! String,status1: status,customername1: customername)
        
        
        
        
        /*   'to' : 'All Agents',
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
        
        //////////////socket.emit()
        
        //////// === commenting old socket logic...
        //DatabaseObjectInitialiser.getInstance().socketObj.socket.emit("send:messageToAgent",chatdata)
        
        sendChatOnServer(chatdata)
        
        /////////////api/userchats/create
        saveChatOnServer(chatdata)
        
        
        self.addMessage("\(txtFieldPost.text!) (\(status))", ofType: "2",date:NSDate().description, uniqueid: uniqueid)
        txtFieldPost.text = "";
        tblForGroupChat.reloadData()
        if(messages.count>1)
        {
            
            var indexPath = NSIndexPath(forRow:messages.count-1, inSection: 0)
            tblForGroupChat.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
            
        }
    }
    
    func makeChatStanzaAndSaveInDB(type1:String,msg1:String,status1:String,filetype1:String,filepath1:String)->[String:AnyObject]
    {
        
        var status="pending"
        var chatdata=[String:AnyObject]()
        //Session has been assigned
        
        var requestIDsObject=DatabaseObjectInitialiser.getDB().getSingleRequestIDsList(team_id,messagechannel_id:messagechannel_id)
        print("requestIDsObject[agent_id] as! String is \(requestIDsObject["agent_id"] as! String)")
        
        var stringAngentsToField=""
        if((requestIDsObject["agent_id"] as! String) != "")
        {
            print("agents id is available \(requestIDsObject["agent_id"] as! String)")
            var agentIDsArrayList=(requestIDsObject["agent_id"] as! String).componentsSeparatedByString(",")
            var agentEmailsArrayList=(requestIDsObject["agent_email"] as! String).componentsSeparatedByString(",")
            var agentNamesArrayList=(requestIDsObject["agent_name"] as! String).componentsSeparatedByString(",")
            
            chatdata["to"]=agentNamesArrayList
            chatdata["agentemail"]=agentEmailsArrayList
            chatdata["agentid"]=agentIDsArrayList
            chatdata["toagent"]=agentEmailsArrayList
            
            stringAngentsToField=agentNamesArrayList.joinWithSeparator(",")
            
        }
            //Session has not yet been assigned
        else{
            stringAngentsToField="All Agents"
            chatdata["to"]="All Agents"
        }
        chatdata["from"]=DatabaseObjectInitialiser.getInstance().customerid
        
        
        var emailfield=""
        if((DatabaseObjectInitialiser.getInstance().optionalDataList["email"]) != nil)
        {
            print("email field not nil it exists")
            emailfield=DatabaseObjectInitialiser.getInstance().optionalDataList["email"] as! String
            chatdata["visitoremail"]=DatabaseObjectInitialiser.getInstance().optionalDataList["email"]
        }
        chatdata["type"]=type1
        //generate uniqueid
        
        
        
        
        var uniqueid=generateUniqueID()
        
        //var uniqueid="aaaaaaaa"
        chatdata["uniqueid"]=uniqueid
        chatdata["msg"]=msg1
        chatdata["datetime"]=NSDate().debugDescription
        chatdata["request_id"]=request_id
        chatdata["messagechannel"]=messagechannel_id
        chatdata["companyid"]=DatabaseObjectInitialiser.getInstance().clientid
        chatdata["is_seen"]="no"
        // chatdata["time"]=NSDate().description
        chatdata["fromMobile"]="yes"
        
        //currently status is pending
        chatdata["status"]=status1
        
        var customername=""
        if((DatabaseObjectInitialiser.getInstance().optionalDataList["customerName"]) != nil)
        {
            print("customerName field not nil it exists")
            customername=DatabaseObjectInitialiser.getInstance().optionalDataList["customerName"] as! String
            chatdata["customername"]=DatabaseObjectInitialiser.getInstance().optionalDataList["customerName"]
            
            
        }
        
        DatabaseObjectInitialiser.getDB().storeChat(stringAngentsToField,from1:chatdata["from"] as! String,visitoremail1:emailfield,type1:chatdata["type"] as! String,uniqueid1:chatdata["uniqueid"] as! String,msg1:chatdata["msg"] as! String,datetime1:NSDate(),request_id1:chatdata["request_id"] as! String,messagechannel1:chatdata["messagechannel"] as! String,companyid1:chatdata["companyid"] as! String,is_seen1:chatdata["is_seen"] as! String,fromMobile1:chatdata["fromMobile"] as! String,status1: status,customername1: customername)
        
        
        DatabaseObjectInitialiser.getDB().storeFiles(requestIDsObject["agent_name"] as! String, from1: chatdata["from"] as! String, date1: NSDate(), uniqueid1: chatdata["uniqueid"] as! String, type1: "file", filename1: filename, filesize1: "1", filetype1: filetype1, filepath1: filepath1, requestid1: chatdata["request_id"] as! String)
        
        return chatdata
    }
    
    
    func generateUniqueID()->String
    {
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
        var uniqueid="h \(uid) \(year) \(month) \(day) \(hr) \(min) \(sec)"
        return uniqueid
        
    }
    func saveChatOnServer(chatdata:[String:AnyObject])
    {
        
        print("call endpoint,saving chat data is \(chatdata.description)")
        var header:[String:String]=["kibo-app-id":DatabaseObjectInitialiser.getInstance().appid,"kibo-app-secret":DatabaseObjectInitialiser.getInstance().secretid,"kibo-client-id":DatabaseObjectInitialiser.getInstance().clientid]
        var hhh=["headers":"\(header)"]
        print("header is \(header.description)")
        
        var url=Constants.mainURL+Constants.saveChat
        
        Alamofire.request(.POST,"\(url)",parameters: chatdata,headers:header,encoding: .JSON).response{
            request, response_, data, error in
            
            print(response_.debugDescription)
            if(response_?.statusCode==200 || response_?.statusCode==201)
            {
                print("saved chat success")
                //update status locally from pending to sent
                DatabaseObjectInitialiser.getDB().updateChatStatus(chatdata["uniqueid"] as! String,requestid1: chatdata["request_id"] as! String, status1: "sent")
                
               // updateUI:
                Delegates.getInstance().UpdateChatDetailsDelegateCall()

                
            }
            else{
                print("error: save chat on kibosupport failed \(response_.debugDescription)")
            }
            if(error != nil)
            {
                print(response_!.description)
                print(data!.description)
                print(".......")
            }
            
            
        }
        
    }
    
    
    func sendChatOnServer(chatdata:[String:AnyObject])
    {
        
        print("call endpoint, sending chat, data is \(chatdata.description)")
        var header:[String:String]=["kibo-app-id":DatabaseObjectInitialiser.getInstance().appid,"kibo-app-secret":DatabaseObjectInitialiser.getInstance().secretid,"kibo-client-id":DatabaseObjectInitialiser.getInstance().clientid]
        var hhh=["headers":"\(header)"]
        print("header is \(header.description)")
        
        var url=Constants.sendChat
        
        Alamofire.request(.POST,"\(url)",parameters: chatdata,headers:header,encoding: .JSON).response{
            request, response_, data, error in
            
            
            print("sending chat")
            if(error != nil)
            {
                print("error sending chat \(error.debugDescription)")
            }
            if(error==nil)
            {
                print("chat sent to kiboengage")
                print(response_!.debugDescription)
                print(data.debugDescription)
            }
            //print(response)
            
            //   print(response_!.description)
            // print(data!.description)
            //print(".......")
            
            
        }
        
    }
    
    func addMessage(message: String, ofType msgType:String, date:String, uniqueid:String) {
        messages.addObject(["message":message, "type":msgType, "date":date, "uniqueid":uniqueid])
    }
    
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var messageDic = messages.objectAtIndex(indexPath.row) as! [String : String];
        
        let msg = messageDic["message"] as NSString!
        let msgType = messageDic["type"]! as NSString
        
        let sizeOFStr = self.getSizeOfString(msg)
        
        return sizeOFStr.height + 70
    }
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func getSizeOfString(postTitle: NSString) -> CGSize {
        
        
        // Get the height of the font
        let constraintSize = CGSizeMake(170, CGFloat.max)
        
        //let constraintSize = CGSizeMake(220, CGFloat.max)
        
        
        
        /*let attributes = [NSFontAttributeName:UIFont.systemFontOfSize(11.0)]
         let labelSize = postTitle.boundingRectWithSize(constraintSize,
         options: NSStringDrawingOptions.UsesLineFragmentOrigin,
         attributes: attributes,
         context: nil)*/
        
        let labelSize = postTitle.boundingRectWithSize(constraintSize,
                                                       options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                                                       attributes:[NSFontAttributeName : UIFont.systemFontOfSize(11.0)],
                                                       context: nil)
        ////print("size is width \(labelSize.width) and height is \(labelSize.height)")
        return labelSize.size
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cell : UITableViewCell!
        
        print("cellForRowAtIndexPath called \(indexPath)")
        var messageDic = messages.objectAtIndex(indexPath.row) as! [String : String];
        NSLog(messageDic["message"]!, 1)
        let msgType = messageDic["type"] as NSString!
        let msg = messageDic["message"] as NSString!
        let date2=messageDic["date"] as NSString!
        let sizeOFStr = self.getSizeOfString(msg)
        let uniqueidDictValue=messageDic["uniqueid"] as NSString!
        /////////print("sizeOFStr for \(msg) is \(sizeOFStr)")
        //// print("sizeOfstr is width \(sizeOFStr.width) and height is \(sizeOFStr.height)")
        
        //var sizeOFStr=msg.boundingRectWithSize(CGSizeMake(220.0,CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: nil, context: nil).size
        /*
         
         Messagesize = [message.userMessage boundingRectWithSize:CGSizeMake(220.0f, CGFLOAT_MAX)
         options:NSStringDrawingUsesLineFragmentOrigin
         attributes:@{NSFontAttributeName:fontArray[1]}
         context:nil].size;
         
         
         Timesize = [@"Time" boundingRectWithSize:CGSizeMake(220.0f, CGFLOAT_MAX)
         options:NSStringDrawingUsesLineFragmentOrigin
         attributes:@{NSFontAttributeName:fontArray[2]}
         context:nil].size;
         
         
         size.height = Messagesize.height + Namesize.height + Timesize.height + 48.0f;
         */
        
        if (msgType.isEqualToString("1")){
            
            print("yessssss 1")
            
            cell = tblForGroupChat.dequeueReusableCellWithIdentifier("ChatSentCell")! as UITableViewCell
            // let nameLabel = cell.viewWithTag(15) as! UILabel
            let textLable = cell.viewWithTag(12) as! UILabel
            let chatImage = cell.viewWithTag(1) as! UIImageView
            let profileImage = cell.viewWithTag(2) as! UIImageView
            let timeLabel = cell.viewWithTag(11) as! UILabel
            
            
            chatImage.frame = CGRectMake(chatImage.frame.origin.x, chatImage.frame.origin.y, ((sizeOFStr.width + 100)  > 200 ? (sizeOFStr.width + 100) : 200), sizeOFStr.height + 40)
            ///// chatImage.image = UIImage(named: "chat_receive")?.stretchableImageWithLeftCapWidth(40,topCapHeight: 20);
            //******
            
            
            textLable.frame = CGRectMake(textLable.frame.origin.x, textLable.frame.origin.y, textLable.frame.size.width, sizeOFStr.height)
            ////// profileImage.center = CGPointMake(profileImage.center.x, textLable.frame.origin.y + textLable.frame.size.height - profileImage.frame.size.height/2 + 10)
            profileImage.center = CGPointMake(profileImage.center.x, textLable.frame.origin.y + textLable.frame.size.height - profileImage.frame.size.height/2+20)
            
            
            
            // nameLabel.text="Sojharo"
            
            
            textLable.text=msg.description
            //return cell
        }
        //  return cell
        
        /*  if(indexPath.row==0)
         {
         var cell = tblForGroupChat.dequeueReusableCellWithIdentifier("ChatSentCell")! as UITableViewCell
         let nameLabel = cell.viewWithTag(15) as! UILabel
         nameLabel.text="Sojharo"
         return cell
         }*/
        if (msgType.isEqualToString("2")){
            print("yessss 2")
            cell = tblForGroupChat.dequeueReusableCellWithIdentifier("ChatReceivedCell")! as UITableViewCell
            
            let deliveredLabel = cell.viewWithTag(13) as! UILabel
            let textLable = cell.viewWithTag(12) as! UILabel
            let timeLabel = cell.viewWithTag(11) as! UILabel
            let chatImage = cell.viewWithTag(1) as! UIImageView
            
            let distanceFactor = (197.0 - sizeOFStr.width) < 107 ? (197.0 - sizeOFStr.width) : 107
            //// //print("distanceFactor for \(msg) is \(distanceFactor)")
            
            chatImage.frame = CGRectMake(20 + distanceFactor, chatImage.frame.origin.y, ((sizeOFStr.width + 107)  > 207 ? (sizeOFStr.width + 107) : 200), sizeOFStr.height + 40)
            ////    //print("chatImage.x for \(msg) is \(20 + distanceFactor) and chatimage.wdith is \(chatImage.frame.width)")
            
            
            textLable.hidden=false
            
            ////////  chatImage.image = UIImage(named: "chat_send")?.stretchableImageWithLeftCapWidth(40,topCapHeight: 20);
            //*********
            // textLable.text = "\(msg)"
            textLable.frame = CGRectMake(36 + distanceFactor, textLable.frame.origin.y, textLable.frame.size.width, sizeOFStr.height)
            ///  //print("textLable.x for \(msg) is \(textLable.frame.origin.x) and textLable.width is \(textLable.frame.width)")
            
            ////profileImage.center = CGPointMake(profileImage.center.x, textLable.frame.origin.y + textLable.frame.size.height - profileImage.frame.size.height/2 + 10)
            
            timeLabel.frame = CGRectMake(36 + distanceFactor, timeLabel.frame.origin.y, timeLabel.frame.size.width, timeLabel.frame.size.height)
            deliveredLabel.frame = CGRectMake(deliveredLabel.frame.origin.x, textLable.frame.origin.y + textLable.frame.size.height + 15, deliveredLabel.frame.size.width, deliveredLabel.frame.size.height)
            
            
            textLable.text=msg.description
            //  return cell
            
        }
        
        return cell
        
    }
    
    func refreshChatsUI(message: String, data: AnyObject!) {
        
        retrieveFromDatabase({result->() in
            
            // dispatch_async(dispatch_get_main_queue())
            // {
            
            self.tblForGroupChat.reloadData()
            
            /* var offsetY = CGFloat.init(0)
             var indexPath = NSIndexPath(forRow:self.messages.count-1, inSection: 0)
             
             for (var i = 0; i <= indexPath.row; i++) {
             offsetY += (self.tblForGroupChat.delegate?.tableView!(self.tblForGroupChat, heightForRowAtIndexPath: indexPath))!
             //[tableView.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
             }
             
             
             UIView.animateWithDuration(0, delay: 0, options:[], animations: {
             self.tblForGroupChat.contentOffset = CGPointMake(0, offsetY)
             
             }, completion:{ (true)-> Void in
             //self.showKeyboard=false
             })
             */
            
            if(self.messages.count>1)
            {
                var indexPath = NSIndexPath(forRow:self.messages.count-1, inSection: 0)
                self.tblForGroupChat.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
                
            }
            // }
        })
        
    }
    
    
    @IBAction func btnFileSharePressed(sender: AnyObject) {
        
        
        let shareMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        shareMenu.modalPresentationStyle=UIModalPresentationStyle.OverCurrentContext
        let photoAction = UIAlertAction(title: "Photo/Video Library", style: UIAlertActionStyle.Default,handler: { (action) -> Void in
            
            var picker=UIImagePickerController.init()
            picker.delegate=self
            
            picker.allowsEditing = true;
            //picker.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            // if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary))
            //  {
            
            //savedPhotosAlbum
            // picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            //}
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            ////picker.mediaTypes=[kUTTypeMovie as NSString as String,kUTTypeMovie as NSString as String]
            //[self presentViewController:picker animated:YES completion:NULL];
            dispatch_async(dispatch_get_main_queue())
            { () -> Void in
                //  picker.addChildViewController(UILabel("hiiiiiiiiiiiii"))
                
                self.presentViewController(picker, animated: true, completion: nil)
                
            }
            
            
        })
        let documentAction = UIAlertAction(title: "Share Document", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            
            //print(NSOpenStepRootDirectory())
            ///var UTIs=UTTypeCopyPreferredTagWithClass("public.image", kUTTypeImage)?.takeRetainedValue() as! [String]
            
            //let importMenu = UIDocumentMenuViewController(documentTypes: [kUTTypeText as NSString as String, kUTTypeImage as String,"com.adobe.pdf","public.jpeg","public.html","public.content","public.data","public.item",kUTTypeBundle as String],
            //   inMode: .Import)
            
            let importMenu = UIDocumentMenuViewController(documentTypes: [kUTTypeText as NSString as String,"com.adobe.pdf","public.html",/*"public.content",*/"public.text",/*kUTTypeBundle as String,"com.apple.rtfd"*/"com.adobe.pdf","com.microsoft.word.doc","org.openxmlformats.wordprocessingml.document"],
                inMode: .Import)
            ///////let importMenu = UIDocumentMenuViewController(documentTypes: UTIs, inMode: .Import)
            importMenu.delegate = self
            
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.presentViewController(importMenu, animated: true, completion: nil)
                
                
            }
            
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:nil)
        shareMenu.addAction(photoAction)
        shareMenu.addAction(documentAction)
        shareMenu.addAction(cancelAction)
        
        
        
        self.presentViewController(shareMenu, animated: true, completion: {
            
        })
        
        
        
        
        
        
        
        
        //................................
        
        /*
         //socketObj.socket.emit("logClient","\(username!) is sharing file with \(iamincallWith)")
         //print(NSOpenStepRootDirectory())
         ///var UTIs=UTTypeCopyPreferredTagWithClass("public.image", kUTTypeImage)?.takeRetainedValue() as! [String]
         
         let importMenu = UIDocumentMenuViewController(documentTypes: [kUTTypeText as NSString as String, kUTTypeImage as String,"com.adobe.pdf","public.jpeg","public.html","public.content","public.data","public.item",kUTTypeBundle as String],
         inMode: .Import)
         ///////let importMenu = UIDocumentMenuViewController(documentTypes: UTIs, inMode: .Import)
         importMenu.delegate = self
         if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary))
         {
         importMenu.addOptionWithTitle("Photots and Movies", image: nil, order: UIDocumentMenuOrder.First) {
         var picker=UIImagePickerController.init()
         picker.delegate=self
         
         picker.allowsEditing = true;
         // if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary))
         //  {
         picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
         //}
         
         //[self presentViewController:picker animated:YES completion:NULL];
         dispatch_async(dispatch_get_main_queue()) { () -> Void in
         self.presentViewController(picker, animated: true, completion: nil)
         
         
         }
         
         
         }
         }
         dispatch_async(dispatch_get_main_queue()) { () -> Void in
         self.presentViewController(importMenu, animated: true, completion: nil)
         
         
         }
         */
        }
        
        public func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
            
            
            
            //  var filesizenew=""
            
            
            let imageUrl          = editingInfo![UIImagePickerControllerReferenceURL] as! NSURL
            let imageName         = imageUrl.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first as String!
            let photoURL          = NSURL(fileURLWithPath: documentDirectory)
            let localPath         = photoURL.URLByAppendingPathComponent(imageName!)
            let image             = editingInfo![UIImagePickerControllerOriginalImage]as! UIImage
            let data              = UIImagePNGRepresentation(image)
            
            if let imageURL = editingInfo![UIImagePickerControllerReferenceURL] as? NSURL {
                let result = PHAsset.fetchAssetsWithALAssetURLs([imageURL], options: nil)
                
                
                self.filename = result.firstObject?.filename ?? ""
                
                // var myasset=result.firstObject as! PHAsset
                ////print(myasset.mediaType)
                
                
                
            }
            
            
            let shareMenu = UIAlertController(title: nil, message: " Send \" \(filename) \" to Agent ? ", preferredStyle: .ActionSheet)
            shareMenu.modalPresentationStyle=UIModalPresentationStyle.OverCurrentContext
            let confirm = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default,handler: { (action) -> Void in
                
               // socketObj.socket.emit("logClient","IPHONE-LOG: \(username!) selected image ")
                //print("file gotttttt")
                var furl=NSURL(string: localPath.URLString)
                
                //print(furl!.pathExtension!)
                //print(furl!.URLByDeletingPathExtension?.lastPathComponent!)
                var ftype=furl!.pathExtension!
                var fname=furl!.URLByDeletingPathExtension?.lastPathComponent!
                
                
                let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
                let docsDir1 = dirPaths[0]
                var documentDir=docsDir1 as NSString
                var filePathImage2=documentDir.stringByAppendingPathComponent(self.filename)
                var fm=NSFileManager.defaultManager()
                
                var fileAttributes:[String:AnyObject]=["":""]
                do {
                    /// let fileAttributes : NSDictionary? = try NSFileManager.defaultManager().attributesOfItemAtPath(furl!.path!)
                    ///    let fileAttributes : NSDictionary? = try NSFileManager.defaultManager().attributesOfItemAtPath(imageUrl.path!)
                    let fileAttributes : NSDictionary? = try NSFileManager.defaultManager().attributesOfItemAtPath(filePathImage2)
                    if let _attr = fileAttributes {
                       ////////////////============ self.fileSize1 = _attr.fileSize();
                        //print("file size is \(self.fileSize1)")
                        //// ***april 2016 neww self.fileSize=(fileSize1 as! NSNumber).integerValue
                    }
                } catch {
                    print("IPHONE-LOG: error: \(error)")
                    //print("Error:+++ \(error)")
                }
                
                
                //print("filename is \(self.filename) destination path is \(filePathImage2) image name \(imageName) imageurl \(imageUrl) photourl \(photoURL) localPath \(localPath).. \(localPath.absoluteString)")
                
                var s=fm.createFileAtPath(filePathImage2, contents: nil, attributes: nil)
                
                //  var written=fileData!.writeToFile(filePathImage2, atomically: false)
                
                //filePathImage2
                
                data!.writeToFile(filePathImage2, atomically: true)
                // data!.writeToFile(localPath.absoluteString, atomically: true)
                
                
               
                //var uniqueID=randNum5+year
                //print("unique ID is \(uniqueID)")
                
                //var loggedid=_id!
                //^^var firstNameSelected=selectedUserObj["firstname"]
                //^^^var lastNameSelected=selectedUserObj["lastname"]
                //^^^var fullNameSelected=firstNameSelected.string!+" "+lastNameSelected.string!
                //var imParas=["from":"\(username!)","to":"\(self.selectedContact)","fromFullName":"\(displayname)","msg":"\(self.txtFldMessage.text!)","uniqueid":"\(uniqueID)"]
                
                
                
                var mime=UtilityFunctions.init().MimeType(ftype)
                print("mime is \(mime)")
                var filemsgbody="\(mime);\(self.filename)"
                var chatdata=self.makeChatStanzaAndSaveInDB("file", msg1: self.filename, status1: "pending",filetype1: ftype,filepath1: filePathImage2)
                
               /* var stringAngentsToField=chatdata["to"]
                //chatdata["agentemail"]
                var emailfield=chatdata["visitoremail"]
                var status=chatdata["status"]
                

                DatabaseObjectInitialiser.getDB().storeChat(stringAngentsToField,from1:chatdata["from"] as! String,visitoremail1:emailfield,type1:chatdata["type"] as! String,uniqueid1:chatdata["uniqueid"] as! String,msg1:chatdata["msg"] as! String,datetime1:NSDate(),request_id1:chatdata["request_id"] as! String,messagechannel1:chatdata["messagechannel"] as! String,companyid1:chatdata["companyid"] as! String,is_seen1:chatdata["is_seen"] as! String,fromMobile1:chatdata["fromMobile"] as! String,status1: status,customername1: customername)
                */
                
                
                
                /*   'to' : 'All Agents',
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
                
                //////////////socket.emit()
                
                //////// === commenting old socket logic...
                //DatabaseObjectInitialiser.getInstance().socketObj.socket.emit("send:messageToAgent",chatdata)
                
                ////==auto on server after file aved self.sendChatOnServer(chatdata)
                
                /////////////api/userchats/create
                //============self.saveChatOnServer(chatdata)
                
                
                self.addMessage("\(self.filename)", ofType: "2",date:NSDate().description, uniqueid: chatdata["uniqueid"] as! String)
                self.txtFieldPost.text = "";
                self.tblForGroupChat.reloadData()
                if(self.messages.count>1)
                {
                    
                    var indexPath = NSIndexPath(forRow:self.messages.count-1, inSection: 0)
                    self.tblForGroupChat.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
                    
                }

                
                //make chat and store chat ================
                
                
                /*
                var imParas=["from":"\(username!)","to":"\(self.selectedContact)","fromFullName":"\(displayname)","msg":self.filename,"uniqueid":uniqueID,"type":"file","file_type":"image"]
                //print("imparas are \(imParas)")
                
                
                var statusNow="pending"
                //}
                
                ////sqliteDB.SaveChat("\(selectedContact)", from1: username!, owneruser1: username!, fromFullName1: displayname!, msg1: fname!+"."+ftype, date1: nil, uniqueid1: uniqueID, status1: statusNow, type1: "chat", file_type1: "", file_path1: "")
                // sqliteDB.SaveChat("\(selectedContact)", from1: "\(username!)",owneruser1: "\(username!)", fromFullName1: "\(loggedFullName!)", msg1: "\(txtFldMessage.text!)",date1: nil,uniqueid1: uniqueID, status1: statusNow)
                
                
                
                //------
                
                DatabaseObjectInitialiser.getDB().storeChat(String, from1: <#T##String#>, visitoremail1: <#T##String#>, type1: <#T##String#>, uniqueid1: <#T##String#>, msg1: <#T##String#>, datetime1: <#T##NSDate#>, request_id1: <#T##String#>, messagechannel1: <#T##String#>, companyid1: <#T##String#>, is_seen1: <#T##String#>, fromMobile1: <#T##String#>, status1: <#T##String#>, customername1: <#T##String#>)
                sqliteDB.SaveChat(self.selectedContact, from1: username!, owneruser1: username!, fromFullName1: displayname, msg1: self.filename, date1: nil, uniqueid1: uniqueID, status1: statusNow, type1: "file", file_type1: "image", file_path1: filePathImage2)
                */
                
                //do when upload finish
                //think about pending file
                /* socketObj.socket.emitWithAck("im",["room":"globalchatroom","stanza":imParas])(timeoutAfter: 150000)
                 {data in
                 
                 //print("chat ack received  \(data)")
                 statusNow="sent"
                 var chatmsg=JSON(data)
                 //print(data[0])
                 //print(chatmsg[0])
                 sqliteDB.UpdateChatStatus(chatmsg[0]["uniqueid"].string!, newstatus: chatmsg[0]["status"].string!)
                 
                 self.retrieveChatFromSqlite(self.selectedContact)
                 //self.tblForGroupChat.reloadData()
                 
                 
                 
                 }
                 */
                
                //sqliteDB.SaveChat(self.selectedContact, from1: username!, owneruser1: username!, fromFullName1: displayname, msg1: self.filename, date1: nil, uniqueid1: uniqueID, status1: "pending", type1: "image", file_type1: ftype, file_path1: filePathImage2)
                
               //==done above== sqliteDB.saveFile(self.selectedContact, from1: username!, owneruser1: username!, file_name1: self.filename, date1: nil, uniqueid1: uniqueID, file_size1: "\(self.fileSize1)", file_type1: ftype, file_path1: filePathImage2, type1: "image")
                
               //uncomment later self.addUploadInfo(self.selectedContact,uniqueid1: uniqueID, rowindex: self.messages.count, uploadProgress: 0.0, isCompleted: false)
                
                
                UtilityFunctions.init().uploadFile(chatdata, filePath1: filePathImage2, file_name1: self.filename, file_type1: ftype)
               
                
                /////managerFile.uploadFile(filePathImage2, to1: self.selectedContact, from1: username!, uniqueid1: uniqueID, file_name1: self.filename, file_size1: "\(self.fileSize1)", file_type1: ftype,type1:"image")
                //print("alamofire upload calledddd")
                
                ///sqliteDB.saveChatImage(self.selectedContact, from1: username!, owneruser1: username!, fromFullName1: displayname, msg1: self.filename, date1: nil, uniqueid1: uniqueID, status1: "pending", type1: "document",file_type1: ftype, file_path1: filePathImage2)
                
                self.retrieveFromDatabase({(result)-> () in
                    self.tblForGroupChat.reloadData()
                    
                    if(self.messages.count>1)
                    {
                        var indexPath = NSIndexPath(forRow:self.messages.count-1, inSection: 0)
                        
                        self.tblForGroupChat.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
                    }
                })
                
                /////// self.addMessage(filePathImage2, ofType: "3", date: nil)
                ////print(result.firstObject?.keys)
                //filename = result.firstObject?.fileSize.debugDescription
                /* PHImageManager.defaultManager().requestImageDataForAsset(result.firstObject as! PHAsset, options: PHImageRequestOptions.init(), resultHandler: { (imageData, dataUTI, orientation, infoDict) in
                 infoDict?.keys.elements.forEach({ (infoKeys) in
                 //print("---+++---")
                 //print(dataUTI)
                 ////print(infoKeys.debugDescription)
                 })
                 
                 
                 })*/
                // filename = result.firstObject?.
                
                
                
                
                
                
                self.dismissViewControllerAnimated(true, completion:{ ()-> Void in
                    
                  /*  if(self.showKeyboard==true)
                    {var duration : NSTimeInterval = 0
                        
                        
                        UIView.animateWithDuration(duration, delay: 0, options:[], animations: {
                            self.chatComposeView.frame = CGRectMake(self.chatComposeView.frame.origin.x, self.chatComposeView.frame.origin.y + self.keyheight-self.chatComposeView.frame.size.height-3, self.chatComposeView.frame.size.width, self.chatComposeView.frame.size.height)
                            self.tblForGroupChat.frame = CGRectMake(self.tblForGroupChat.frame.origin.x, self.tblForGroupChat.frame.origin.y, self.tblForGroupChat.frame.size.width, self.tblForGroupChat.frame.size.height + self.keyFrame.size.height-49);
                            }, completion: nil)
                        self.showKeyboard=false
                        
                    }*/
                    
                    if(self.messages.count>1)
                    {
                        var indexPath = NSIndexPath(forRow:self.messages.count-1, inSection: 0)
                        
                        self.tblForGroupChat.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
                    }
                    
                });
                
                
                
                
                /*if (controller.documentPickerMode == UIDocumentPickerMode.Import) {
                 NSLog("Opened ", url.path!);
                 //print("picker url is \(url)")
                 
                 
                 */
                
                
                
                
                
                //    urlLocalFile=localPath
                /////let text2 = fm.contentsAtPath(filePath)
                //////////print(text2)
                ///////////print(JSON(text2!))
                ///mdata.fileContents=fm.contentsAtPath(filePathImage)!
                //    self.fileContents=NSData(contentsOfURL: localPath)
                //   self.filePathImage=localPath.URLString
                //var filecontentsJSON=JSON(NSData(contentsOfURL: url)!)
                ////print(filecontentsJSON)
                // //print("file url is \(self.filePathImage) file type is \(ftype)")
                //    var filename=fname!+"."+ftype
                // socketObj.socket.emit("logClient","\(username!) is sending file \(fname)")
                
                // var mjson="{\"file_meta\":{\"name\":\"\(filename)\",\"size\":\"\(self.fileSize1.description)\",\"filetype\":\"\(ftype)\",\"browser\":\"firefox\",\"uname\":\"\(username!)\",\"fid\":\(self.myfid),\"senderid\":\(currentID!)}}"
                /// var fmetadata="{\"eventName\":\"data_msg\",\"data\":\(mjson)}"
                
                
                //----------sendDataBuffer(fmetadata,isb: false)
                
                
                //  socketObj.socket.emit("conference.chat", ["message":"You have received a file. Download and Save it.","username":username!])
                
                /*  let alert = UIAlertController(title: "Success", message: "Your file has been successfully sent", preferredStyle: UIAlertControllerStyle.Alert)
                 alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                 self.presentViewController(alert, animated: true, completion: nil)*/
                
                
                //mdata.sharefile(url)
                // }
                
            })
            
            let notConfirm = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                
            })
            
            shareMenu.addAction(confirm)
            shareMenu.addAction(notConfirm)
            
            self.dismissViewControllerAnimated(true, completion:{ ()-> Void in
                
                /*if(self.showKeyboard==true)
                {var duration : NSTimeInterval = 0
                    
                    
                    UIView.animateWithDuration(duration, delay: 0, options:[], animations: {
                        self.chatComposeView.frame = CGRectMake(self.chatComposeView.frame.origin.x, self.chatComposeView.frame.origin.y + self.keyheight-self.chatComposeView.frame.size.height-3, self.chatComposeView.frame.size.width, self.chatComposeView.frame.size.height)
                        self.tblForGroupChat.frame = CGRectMake(self.tblForGroupChat.frame.origin.x, self.tblForGroupChat.frame.origin.y, self.tblForGroupChat.frame.size.width, self.tblForGroupChat.frame.size.height + self.keyFrame.size.height-49);
                        }, completion: nil)
                    self.showKeyboard=false
                    
                }
                */
                self.tblForGroupChat.reloadData()
                if(self.messages.count>1)
                {
                    var indexPath = NSIndexPath(forRow:self.messages.count-1, inSection: 0)
                    self.tblForGroupChat.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
                    
                }
                
                self.presentViewController(shareMenu, animated: true) {
                    
                    
                }
                
            });
            
            
            
            /* self.presentViewController(shareMenu, animated: true) {
             
             
             }*/
            
        }
        public func imagePickerControllerDidCancel(picker: UIImagePickerController) {
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.dismissViewControllerAnimated(true, completion: { ()-> Void in
                   /*
                    if(self.showKeyboard==true)
                    {var duration : NSTimeInterval = 0
                        
                        
                        UIView.animateWithDuration(duration, delay: 0, options:[], animations: {
                            self.chatComposeView.frame = CGRectMake(self.chatComposeView.frame.origin.x, self.chatComposeView.frame.origin.y + self.keyheight-self.chatComposeView.frame.size.height-3, self.chatComposeView.frame.size.width, self.chatComposeView.frame.size.height)
                            self.tblForGroupChat.frame = CGRectMake(self.tblForGroupChat.frame.origin.x, self.tblForGroupChat.frame.origin.y, self.tblForGroupChat.frame.size.width, self.tblForGroupChat.frame.size.height + self.keyFrame.size.height-49);
                            }, completion: nil)
                        self.showKeyboard=false*/
                        
                })}
    }
    public func documentPicker(controller: UIDocumentPickerViewController, didPickDocumentAtURL url: NSURL) {
        
        
        
        
        
        //print("yess pickeddd document")
        var furl=NSURL(string: url.URLString)
        
        
        //METADATA FILE NAME,TYPE
        //print(furl!.pathExtension!)
        //print(furl!.URLByDeletingPathExtension?.lastPathComponent!)
        var ftype=furl!.pathExtension!
        var fname=furl!.URLByDeletingPathExtension?.lastPathComponent!
        ////var fname=furl!.URLByDeletingPathExtension?.URLString
        //var attributesError=nil
        var fileAttributes:[String:AnyObject]=["":""]
        
        shareMenu = UIAlertController(title: nil, message: " Send \" \(fname!) .\(ftype)\" to sumaira ? ", preferredStyle: .ActionSheet)
        // shareMenu.modalPresentationStyle=UIModalPresentationStyle.OverCurrentContext
        let confirm = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default,handler: { (action) -> Void in
            
            
            
            
            
            if (controller.documentPickerMode == UIDocumentPickerMode.Import) {
                //  NSLog("Opened ", url.path!);
                //print("picker url is \(url)")
                //print("opened \(url.path!)")
                
                
                url.startAccessingSecurityScopedResource()
                let coordinator = NSFileCoordinator()
                var error:NSError? = nil
                //var downloadedalready=false
                do{
                    var downloadkeyresult=try furl!.resourceValuesForKeys([NSURLUbiquitousItemDownloadingStatusKey])
                    /// var downloadkeyresult=try url.resourceValuesForKeys([NSURLUbiquitousItemDownloadingStatusKey])
                    //print("... ... \(downloadkeyresult.debugDescription)")
                    //////var downloadedalready=try NSFileManager.defaultManager().startDownloadingUbiquitousItemAtURL(furl!)
                    
                    ////// //print("downloadedalready is \(downloadedalready)")
                    //   if(downloadedalready != nil)
                    //{
                    
                    if(downloadkeyresult.count>0)
                    {
                        var downloadedalready=try NSFileManager.defaultManager().startDownloadingUbiquitousItemAtURL(furl!)
                        
                        
                    }
                    coordinator.coordinateReadingItemAtURL(url, options: [], error: &error) { (url) -> Void in
                        
                        //print("error is \(error)")
                        
                        // do something with it
                        let fileData = NSData(contentsOfURL: url)
                        /////////////////////////print(fileData?.description)
                      //  socketObj.socket.emit("logClient","IPHONE-LOG: \(username!) selected file ")
                        //print("file gotttttt")
                        
                        do {
                            let fileAttributes : NSDictionary? = try NSFileManager.defaultManager().attributesOfItemAtPath(furl!.path!)
                            
                            if let _attr = fileAttributes {
                                self.fileSize1 = _attr.fileSize();
                                //print("file size is \(self.fileSize1)")
                                //// ***april 2016 neww self.fileSize=(fileSize1 as! NSNumber).integerValue
                            }
                        } catch {
                           // socketObj.socket.emit("logClient","IPHONE-LOG: error: \(error)")
                            //print("Error:.... \(error)")
                        }
                        
                        self.urlLocalFile=url
                        /////let text2 = fm.contentsAtPath(filePath)
                        //////////print(text2)
                        ///////////print(JSON(text2!))
                        ///mdata.fileContents=fm.contentsAtPath(filePathImage)!
                        self.fileContents=NSData(contentsOfURL: url)
                        self.filePathImage=url.URLString
                        //var filecontentsJSON=JSON(NSData(contentsOfURL: url)!)
                        ////print(filecontentsJSON)
                        //print("file url is \(self.filePathImage) file type is \(ftype)")
                        
                        
                        
                        
                        
                        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
                        let docsDir1 = dirPaths[0]
                        var documentDir=docsDir1 as NSString
                        var filePathImage2=documentDir.stringByAppendingPathComponent(fname!+"."+ftype)
                        var fm=NSFileManager.defaultManager()
                        
                        /*var fileAttributes:[String:AnyObject]=["":""]
                         do {
                         /// let fileAttributes : NSDictionary? = try NSFileManager.defaultManager().attributesOfItemAtPath(furl!.path!)
                         let fileAttributes : NSDictionary? = try NSFileManager.defaultManager().attributesOfItemAtPath(imageUrl.path!)
                         
                         if let _attr = fileAttributes {
                         self.fileSize1 = _attr.fileSize();
                         //print("file size is \(self.fileSize1)")
                         //// ***april 2016 neww self.fileSize=(fileSize1 as! NSNumber).integerValue
                         }
                         } catch {
                         socketObj.socket.emit("logClient","IPHONE-LOG: error: \(error)")
                         //print("Error:+++ \(error)")
                         }*/
                        
                        
                        //  //print("filename is \(self.filename) destination path is \(filePathImage2) image name \(imageName) imageurl \(imageUrl) photourl \(photoURL) localPath \(localPath).. \(localPath.absoluteString)")
                        
                        var s=fm.createFileAtPath(filePathImage2, contents: nil, attributes: nil)
                        
                        //  var written=fileData!.writeToFile(filePathImage2, atomically: false)
                        
                        //filePathImage2
                        //var data=NSData(contentsOfFile: self.filePathImage)
                        fileData!.writeToFile(filePathImage2, atomically: true)
                        
                        
                        
                        
                        
                        /*
                         var filename=fname!+"."+ftype
                         socketObj.socket.emit("logClient","\(username!) is sending file \(fname)")
                         
                         var mjson="{\"file_meta\":{\"name\":\"\(filename)\",\"size\":\"\(self.fileSize1.description)\",\"filetype\":\"\(ftype)\",\"browser\":\"firefox\",\"uname\":\"\(username!)\",\"fid\":\(self.myfid),\"senderid\":\(currentID!)}}"
                         var fmetadata="{\"eventName\":\"data_msg\",\"data\":\(mjson)}"
                         */
                        
                        //----------sendDataBuffer(fmetadata,isb: false)
                        
                        
                        
                        
                        
                        //====UNCOMMENT LATER ========
                        //======================================
                        
                        
                        
                        /*let calendar = NSCalendar.currentCalendar()
                        let comp = calendar.components([.Hour, .Minute], fromDate: NSDate())
                        let year = String(comp.year)
                        let month = String(comp.month)
                        let day = String(comp.day)
                        let hour = String(comp.hour)
                        let minute = String(comp.minute)
                        let second = String(comp.second)
                        
                        
                        var randNum5=self.randomStringWithLength(5) as! String
                        var uniqueID=randNum5+year+month+day+hour+minute+second
                        
                        
                        
                        //var uniqueID=randNum5+year
                        //print("unique ID is \(uniqueID)")
                        
                        //^^var firstNameSelected=selectedUserObj["firstname"]
                        //^^^var lastNameSelected=selectedUserObj["lastname"]
                        //^^^var fullNameSelected=firstNameSelected.string!+" "+lastNameSelected.string!
                        var imParas=["from":"\(username!)","to":"\(self.selectedContact)","fromFullName":"\(displayname)","msg":fname!+"."+ftype,"uniqueid":uniqueID,"type":"file","file_type":"document"]
                        //print("imparas are \(imParas)")
                        //print(imParas, terminator: "")
                        //print("", terminator: "")
                        ///=== code for sending chat here
                        ///=================
                        
                        //socketObj.socket.emit("logClient","IPHONE-LOG: \(username!) is sending chat message")
                        //////socketObj.socket.emit("im",["room":"globalchatroom","stanza":imParas])
                        var statusNow=""
                        /*if(isSocketConnected==true)
                         {
                         statusNow="sent"
                         
                         }
                         else
                         {
                         */
                        statusNow="pending"
                        //}
                        
                        ////sqliteDB.SaveChat("\(selectedContact)", from1: username!, owneruser1: username!, fromFullName1: displayname!, msg1: fname!+"."+ftype, date1: nil, uniqueid1: uniqueID, status1: statusNow, type1: "chat", file_type1: "", file_path1: "")
                        // sqliteDB.SaveChat("\(selectedContact)", from1: "\(username!)",owneruser1: "\(username!)", fromFullName1: "\(loggedFullName!)", msg1: "\(txtFldMessage.text!)",date1: nil,uniqueid1: uniqueID, status1: statusNow)
                        
                        
                        
                        //------
                        sqliteDB.SaveChat(self.selectedContact, from1: username!, owneruser1: username!, fromFullName1: displayname, msg1: fname!+"."+ftype, date1: nil, uniqueid1: uniqueID, status1: statusNow, type1: "file", file_type1: "document", file_path1: filePathImage2)
                        
                        
                        
                        
                        //emit when uploaded
                        
                        /* socketObj.socket.emitWithAck("im",["room":"globalchatroom","stanza":imParas])(timeoutAfter: 150000)
                         {data in
                         
                         //print("chat ack received  \(data)")
                         statusNow="sent"
                         var chatmsg=JSON(data)
                         //print(data[0])
                         //print(chatmsg[0])
                         sqliteDB.UpdateChatStatus(chatmsg[0]["uniqueid"].string!, newstatus: chatmsg[0]["status"].string!)
                         
                         self.retrieveChatFromSqlite(self.selectedContact)
                         //self.tblForGroupChat.reloadData()
                         
                         
                         
                         }*/
                        
                        
                        sqliteDB.saveFile(self.selectedContact, from1: username!, owneruser1: username!, file_name1: fname!+"."+ftype, date1: nil, uniqueid1: uniqueID, file_size1: "\(self.fileSize1)", file_type1: ftype, file_path1: filePathImage2, type1: "document")
                        
                        
                        self.addUploadInfo(self.selectedContact,uniqueid1: uniqueID, rowindex: self.messages.count, uploadProgress: 0.0, isCompleted: false)
                        
                        managerFile.uploadFile(filePathImage2, to1: self.selectedContact, from1: username!, uniqueid1: uniqueID, file_name1: fname!+"."+ftype, file_size1: "\(self.fileSize1)", file_type1: ftype, type1:"document")
                        
                        ////  sqliteDB.saveChatImage(self.selectedContact, from1: username!, owneruser1: username!, fromFullName1: "fafa", msg1: fname!+"."+ftype, date1: nil, uniqueid1: uniqueID, status1: "pending", type1: "document", file_type1: ftype, file_path1: filePathImage2)
                        
                        //// sqliteDB.saveChatImage(self.selectedContact, from1: username!,fromFullName1: displayname, owneruser1:username!, msg1: fname!+"."+ftype, date1: nil, uniqueid1: uniqueID, status1: "pending", type1: "doc",file_type1: ftype, file_path1: filePathImage2)
                        selectedText = filePathImage2
                        
                        
                        */
                        
                        ////  self.retrieveChatFromSqlite(self.selectedContact)
                        self.retrieveFromDatabase({(result)-> () in
                            self.tblForGroupChat.reloadData()
                            
                            if(self.messages.count>1)
                            {
                                var indexPath = NSIndexPath(forRow:self.messages.count-1, inSection: 0)
                                
                                self.tblForGroupChat.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
                            }
                        })
                        
                        ////  sqliteDB.SaveChat(self.selectedContact, from1: username!, owneruser1: username!, fromFullName1: displayname, msg1: filename, date1: nil, uniqueid1: uniqueID, status1: "pending")
                        
                        /////socketObj.socket.emit("conference.chat", ["message":"You have received a file. Download and Save it.","username":username!])
                        
                        /* let alert = UIAlertController(title: "Success", message: "Your file has been successfully sent", preferredStyle: UIAlertControllerStyle.Alert)
                         alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                         self.presentViewController(alert, animated: true, completion: nil)
                         
                         */
                    }
                    //       }
                    url.stopAccessingSecurityScopedResource()
                    //mdata.sharefile(url)
                }
                    
                    
                    
                catch
                {
                    //print("eeee \(error)")
                }
            }
        })
        
        
        let notConfirm = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
            
        })
        
        shareMenu.addAction(confirm)
        shareMenu.addAction(notConfirm)
        
        self.presentViewController(shareMenu, animated: true, completion: {
            
        })
        
        
        
    }
    
    
    
    public func documentMenu(documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        
        documentPicker.delegate = self
        presentViewController(documentPicker, animated: true, completion: nil)
        
        
    }
    
    
    
    public func documentMenuWasCancelled(documentMenu: UIDocumentMenuViewController) {
        
        
    }

    
    
    }
