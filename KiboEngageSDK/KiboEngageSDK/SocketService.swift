//
//  SocketService.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 10/09/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import Foundation
class SocketService{
    
    
    var socket:SocketIOClient
    
    /*
     var delegateChat:UpdateChatDelegate!
     //var areYouFreeForCall:Bool
     var isBusy:Bool
     var delegate:SocketClientDelegate!
     var delegateWebRTC:SocketClientDelegateWebRTC!
     var delegateWebRTCVideo:SocketClientDelegateWebRTCVideo!
     var delegateSocketConnected:SocketConnecting!
     */
    //var areYouFreeForCall:Bool
    
    
    init(url:String){
        socket=SocketIOClient(socketURL: "\(url)", options: [.Log(false)])
        //areYouFreeForCall=true
       // isBusy=false
       self.socket.on("connect") {data, ack in
            //isSocketConnected=true
            print("connected to socket")
           //// ChatSessions.init().createChatSessions()
        
            //if(globalChatRoomJoined==false)
            //{
           /* let _id = Expression<String>("_id")
            let phone = Expression<String>("phone")
            let username1 = Expression<String>("username")
            let status = Expression<String>("status")
            let firstname = Expression<String>("firstname")
            //country_prefix
            //national_number
            
            
            let tbl_accounts = sqliteDB.accounts
            do{for account in try sqliteDB.db.prepare(tbl_accounts) {
                if(socketObj != nil)
                {
                    socketObj.socket.emit("logClient","IPHONE-LOG:username:\(account[phone]) _id: \(account[_id]) ,status: \(account[status]),display_name: \(account[firstname])")
                }
                print("username:\(account[phone]) _id: \(account[_id]) ,status: \(account[status]),display_name: \(account[firstname])")
                username=account[phone]
                //  if(socketObj != nil)
                // {
                socketObj.socket.emit("join global chatroom", ["room": "globalchatroom", "user":["username":"\(account[phone])","_id":"\(account[_id])","status":"\(account[status])","display_name":"\(account[firstname])","phone":"\(account[phone])"]])
                //WORKINGGG
                //  }
                globalChatRoomJoined=true
                //  if(socketObj != nil)
                // {
                self.socket.emit("logClient","IPHONE-LOG: \(username!) is joining room room:globalchatroom")
                ////}
                }
                */
            }
   
            
            //self.socket.emit("join global chatroom",["room": "globalchatroom", "user": json.object])
            
            //print(json["_id"])
            
            
            
            
            //}
           // self.delegateSocketConnected?.socketConnected()
            
        //}
        //self.socket.reconnects=true
        self.socket.connect()
       // print("socketObj value is \(socketObj)")
        //%%%%%%%%% self.socket.reconnects=false
        /*self.socket.connect()
         socketConnected=true
         self.addHandlers()
         self.addWebRTCHandlers()
         
         */
        //self.delegate=SocketClientDelegate()
    }
    /*
     func connect()
     {
     
     self.socket.on("connect") {data, ack in
     NSLog("connected to socket")
     
     
     }
     self.socket.on("disconnect") {data, ack in
     NSLog("disconnected from socket")
     //self.socket.emit("message", ["msg":"hangup"])
     
     }
     //connection.status
     self.socket.on("connection.status") {data, ack in
     NSLog("disconnected from socket")
     print(data?.debugDescription)
     // self.socket.emit("message", ["msg":"hangup"])
     
     }
     /* socket.on("youareonline") {data,ack in
     
     print("you onlineeee \(ack)")
     glocalChatRoomJoined = true
     }*/
     //self.socket.connect()
     //addHandlers()
     
     }
     */
    
    func addHandlers(){
        print("adding socket handlerssss", terminator: "")
        
        /*self.socket.on("connect") {data, ack in
         isSocketConnected=true
         NSLog("connected to socket")
         self.delegateSocketConnected?.socketConnected()
         
         }*/
        
        self.socket.on("disconnect") {data, ack in
            //NSLog("disconnected from socket")
            print("disconnected from socket")
            /////socketObj.socket.emit("logClient","IPHONE-LOG: kibo disconnected from socket. conneted again")
           // meetingStarted=false
            //isSocketConnected=false
            //globalChatRoomJoined=false
            //self.socket.reconnects=true
            // self.socket.connect()
            //self.socket.emit("message", ["msg":"hangup"])
            
        }
        //joined
        self.socket.on("joined") {data, ack in
            //NSLog("disconnected from socket")
            print("joined room and got data as \(data.debugDescription)")
        }
        
        self.socket.on("empty") {data, ack in
            //NSLog("disconnected from socket")
            print("received empty \(data.debugDescription)")
        }
    }
}