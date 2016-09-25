//
//  ViewController.swift
//  kiboLiveChat
//
//  Created by Cloudkibo on 08/09/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import UIKit
import KiboEngageSDK

class ViewController: UIViewController {

    @IBAction func showTeams(sender: AnyObject) {
   
       
       let s = UIStoryboard (
name: "SDKstoryboard", bundle: NSBundle(forClass: TeamsViewController.self)
        )
        
        let vc = s.instantiateInitialViewController()! as! TeamsViewController
        
        self.presentViewController(vc, animated: true, completion: nil)
 
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var teamsList=Teams.init()
        teamsList.fetchTeams()
        var messgeChannelsList=MessageChannels.init()
        messgeChannelsList.fetchMessageChannels()
        //var chatsSessions=ChatSessions.init()
        //chatsSessions.createChatSessions()

    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

