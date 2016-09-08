//
//  ChannelsViewController.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 08/09/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import UIKit

class ChannelsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var btnback: UIBarButtonItem!
    @IBOutlet weak var tbl_channels: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        return 6
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(indexPath.row==0)
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
