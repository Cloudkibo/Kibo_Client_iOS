//
//  ChatsDetailViewController.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 10/09/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//


import UIKit
import Alamofire

public class ChatsDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UpdateChatDetailsDelegate {
    
    
    
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
        var i=0
        for(i=0;i<chatsList.count;i++)
        {
            if(chatsList[i]["from"] as! String == DatabaseObjectInitialiser.getInstance().customerid)
            {
                //i sent so type is 2
                tempmessages.addObject(["message":chatsList[i]["msg"] as! String, "type":"2", "date":chatsList[i]["datetime"] as! String, "uniqueid":chatsList[i]["uniqueid"] as! String])
                
              //  tempmessages.addObject(chatsList[i]["msg"] as! String, ofType: "2",date:chatsList[i]["datetime"] as! String, uniqueid: chatsList[i]["uniqueid"] as! String)

                
            }
            else
            {
                
                tempmessages.addObject(["message":chatsList[i]["msg"] as! String, "type":"1", "date":chatsList[i]["datetime"] as! String, "uniqueid":chatsList[i]["uniqueid"] as! String])
               
                
                
            }
            
        }
        
            messages.setArray(tempmessages as [AnyObject])
        completion(result:true)
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
        chatdata["datetime"]=NSDate().description
        chatdata["request_id"]=request_id
        chatdata["messagechannel"]=messagechannel_id
        chatdata["companyid"]=DatabaseObjectInitialiser.getInstance().clientid
        chatdata["is_seen"]="no"
        chatdata["time"]=NSDate().description
        chatdata["fromMobile"]="yes"
        
        //currently status is pending
        chatdata["status"]=status
        
        
        //cant store array, change it to string field 'stringAngentsToField'
        DatabaseObjectInitialiser.getDB().storeChat(stringAngentsToField,from1:chatdata["from"] as! String,visitoremail1:emailfield,type1:chatdata["type"] as! String,uniqueid1:chatdata["uniqueid"] as! String,msg1:chatdata["msg"] as! String,datetime1:chatdata["datetime"] as! String,request_id1:chatdata["request_id"] as! String,messagechannel1:chatdata["messagechannel"] as! String,companyid1:chatdata["companyid"] as! String,is_seen1:chatdata["is_seen"] as! String,time1:chatdata["time"] as! String,fromMobile1:chatdata["fromMobile"] as! String,status1: status)
        
        
        
        
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
        
        
        self.addMessage(txtFieldPost.text!, ofType: "2",date:NSDate().description, uniqueid: uniqueid)
        txtFieldPost.text = "";
        tblForGroupChat.reloadData()
        if(messages.count>1)
        {
            
            var indexPath = NSIndexPath(forRow:messages.count-1, inSection: 0)
            tblForGroupChat.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
            
        }
        
        
        
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
            
            //print(response)
            if(response_?.statusCode==200)
            {
                //update status locally from pending to sent
                DatabaseObjectInitialiser.getDB().updateChatStatus(chatdata["uniqueid"] as! String,requestid1: chatdata["request_id"] as! String, status1: chatdata["status"] as! String)
                
               // updateUI:
                Delegates.getInstance().UpdateChatDetailsDelegateCall()

                
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
    
}
