//
//  BulkSMSViewController.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 20/10/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import UIKit

class BulkSMSViewController: UIViewController {

    var messages:NSMutableArray!
    
    @IBOutlet weak var tbl_BulkSMS: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        messages=NSMutableArray()
        // Do any additional setup after loading the view.
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
      //  print("channels count is \(channelsList.count)")
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
         let cell=tbl_channels.dequeueReusableCellWithIdentifier("channelsCell") as! ChannelsCell
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
