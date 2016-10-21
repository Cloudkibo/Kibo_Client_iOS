//
//  BulkSMSViewController.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 20/10/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import UIKit

class BulkSMSViewController: UIViewController {

   // var messages:NSMutableArray!
    var bulkSMSObjectList=[[String:AnyObject]]()
    @IBOutlet weak var tbl_BulkSMS: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //messages=NSMutableArray()
        
       bulkSMSObjectList = DatabaseObjectInitialiser.getDB().getBulkSMSobjectList()
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var sizeOFStr=CGSize()
        var heightrow=CGFloat()
        if((bulkSMSObjectList[indexPath.row]["hasImage"] as! String) == "true")
        {
         let cell=tbl_BulkSMS.dequeueReusableCellWithIdentifier("bulkSMSwithImageCell") as! bulkSMSwithImageCell
            
            cell.lbl_content_bulkSMS_withimage.text=bulkSMSObjectList[indexPath.row]["description"] as! String
            
            cell.lbl_title_BulkSMS_withimage.text=bulkSMSObjectList[indexPath.row]["title"] as! String

            
       // cell.lbl_content_bulkSMS_withimage.text="asdfafd adfadf adfadf adfadfad fadfasdf adfasdf adfadf adfasadfjk adnfjkasdnf ajsdfnkajdf kajnfjadnfjakdfn ajdknfakasdf akasdfnaskf jkadnfkajdfn 111 222 333 444 555 666 777 888 999 000 asdfafd adfadf adfadf adfadfad fadfasdf adfasdf adfadf adfasadfjk adnfjkasdnf ajsdfnkajdf kajnfjadnfjakdfn ajdknfakasdf akasdfnaskf jkadnfkajdfn 111 222 333 444 555 666 777 888 999 000"
        
       sizeOFStr=getSizeOfString(cell.lbl_content_bulkSMS_withimage.text!)
            heightrow=sizeOFStr.height+282
        }
        else{
            let cell=tbl_BulkSMS.dequeueReusableCellWithIdentifier("bulkSMScell") as! bulkSMScell
            // cell
           
            cell.lbl_bulkSMScontent.text=bulkSMSObjectList[indexPath.row]["description"] as! String

            cell.lbl_bulkSMStitle.text=bulkSMSObjectList[indexPath.row]["title"] as! String
            //cell.lbl_bulkSMScontent.text="asdfafd adfadf adfadf adfadfad fadfasdf adfasdf adfadf adfasadfjk adnfjkasdnf ajsdfnkajdf kajnfjadnfjakdfn ajdknfakasdf akasdfnaskf jkadnfkajdfn 111 222 333 444 555 666 777 888 999 000 asdfafd adfadf adfadf adfadfad fadfasdf adfasdf adfadf adfasadfjk adnfjkasdnf ajsdfnkajdf kajnfjadnfjakdfn ajdknfakasdf akasdfnaskf jkadnfkajdfn 111 222 333 444 555 666 777 888 999 000"
            
            
           sizeOFStr=getSizeOfString(cell.lbl_bulkSMScontent.text!)
            heightrow=sizeOFStr.height
            
        }
        
    //var heightrow=cell.view_bulkSMS_withimage.frame.height
        print("view height is \(heightrow)")
        /*if(heightrow < 40)
        {
            print("inside row less")
            return 100
        }
        else{
 */
        return heightrow+70
        //}
        //return 300
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  print("channels count is \(channelsList.count)")
        return bulkSMSObjectList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if((bulkSMSObjectList[indexPath.row]["hasImage"] as! String) == "true")
         {
         let cell=tbl_BulkSMS.dequeueReusableCellWithIdentifier("bulkSMSwithImageCell") as! bulkSMSwithImageCell
        
            cell.lbl_content_bulkSMS_withimage.text=bulkSMSObjectList[indexPath.row]["description"] as! String
            
            cell.lbl_title_BulkSMS_withimage.text=bulkSMSObjectList[indexPath.row]["title"] as! String
            
        //cell.lbl_content_bulkSMS_withimage.text="asdfafd adfadf adfadf adfadfad fadfasdf adfasdf adfadf adfasadfjk adnfjkasdnf ajsdfnkajdf kajnfjadnfjakdfn ajdknfakasdf akasdfnaskf jkadnfkajdfn 111 222 333 444 555 666 777 888 999 000 asdfafd adfadf adfadf adfadfad fadfasdf adfasdf adfadf adfasadfjk adnfjkasdnf ajsdfnkajdf kajnfjadnfjakdfn ajdknfakasdf akasdfnaskf jkadnfkajdfn 111 222 333 444 555 666 777 888 999 000"
            
        var sizeOFStr=getSizeOfString(cell.lbl_content_bulkSMS_withimage.text!)
        //textsize.height+185
       cell.lbl_content_bulkSMS_withimage.frame = CGRectMake(cell.lbl_content_bulkSMS_withimage.frame.origin.x, cell.lbl_content_bulkSMS_withimage.frame.origin.y, ((sizeOFStr.width)  > 262 ? (sizeOFStr.width) : 262), sizeOFStr.height)
        cell.img_bulkSMS.frame=CGRectMake(cell.img_bulkSMS.frame.origin.x,(cell.lbl_content_bulkSMS_withimage.frame.origin.y) + (cell.lbl_content_bulkSMS_withimage.frame.height)+20, cell.img_bulkSMS.frame.width,cell.img_bulkSMS.frame.height)
        //cell.awakeFromNib()
        cell.view_bulkSMS_withimage.frame=CGRectMake(cell.view_bulkSMS_withimage.frame.origin.x,cell.view_bulkSMS_withimage.frame.origin.y,cell.view_bulkSMS_withimage.frame.width,cell.lbl_content_bulkSMS_withimage.frame.height+cell.img_bulkSMS.frame.height+cell.lbl_content_bulkSMS_withimage.frame.height+60)
        
        print("view height 2 is \(cell.view_bulkSMS_withimage.frame.height)")
        return cell
        }
        else
        {
            /*
             @IBOutlet weak var view_bulkSMS: UIView!
             @IBOutlet weak var lbl_bulkSMStitle: UILabel!
             @IBOutlet weak var lbl_bulkSMScontent: UILabel!

             
 */
            let cell=tbl_BulkSMS.dequeueReusableCellWithIdentifier("bulkSMScell") as! bulkSMScell
           // cell
          
            
            cell.lbl_bulkSMScontent.text=bulkSMSObjectList[indexPath.row]["description"] as! String
            
            cell.lbl_bulkSMStitle.text=bulkSMSObjectList[indexPath.row]["title"] as! String
         
            
            
          //  cell.lbl_bulkSMScontent.text="asdfafd adfadf adfadf adfadfad fadfasdf adfasdf adfadf adfasadfjk adnfjkasdnf ajsdfnkajdf kajnfjadnfjakdfn ajdknfakasdf akasdfnaskf jkadnfkajdfn 111 222 333 444 555 666 777 888 999 000 asdfafd adfadf adfadf adfadfad fadfasdf adfasdf adfadf adfasadfjk adnfjkasdnf ajsdfnkajdf kajnfjadnfjakdfn ajdknfakasdf akasdfnaskf jkadnfkajdfn 111 222 333 444 555 666 777 888 999 000"
            
            
            var sizeOFStr=getSizeOfString(cell.lbl_bulkSMScontent.text!)
            //textsize.height+185
            cell.lbl_bulkSMScontent.frame = CGRectMake(cell.lbl_bulkSMScontent.frame.origin.x, cell.lbl_bulkSMScontent.frame.origin.y, ((sizeOFStr.width)  > 262 ? (sizeOFStr.width) : 262), sizeOFStr.height)
          //  cell.img_bulkSMS.frame=CGRectMake(cell.img_bulkSMS.frame.origin.x,(cell.lbl_content_bulkSMS_withimage.frame.origin.y) + (cell.lbl_content_bulkSMS_withimage.frame.height)+20, cell.img_bulkSMS.frame.width,cell.img_bulkSMS.frame.height)
            //cell.awakeFromNib()
            cell.view_bulkSMS.frame=CGRectMake(cell.view_bulkSMS.frame.origin.x,cell.view_bulkSMS.frame.origin.y,cell.view_bulkSMS.frame.width,cell.lbl_bulkSMStitle.frame.height+cell.lbl_bulkSMScontent.frame.height+30)
            
            print("view height 2 is \(cell.view_bulkSMS.frame.height)")
     
            
            
            return cell
            
        }
    }
    func getSizeOfString(postTitle: NSString) -> CGSize {
        
        
        // Get the height of the font
        let constraintSize = CGSizeMake(262, CGFloat.max)
        
        //let constraintSize = CGSizeMake(220, CGFloat.max)
        
        
        
        /*let attributes = [NSFontAttributeName:UIFont.systemFontOfSize(11.0)]
         let labelSize = postTitle.boundingRectWithSize(constraintSize,
         options: NSStringDrawingOptions.UsesLineFragmentOrigin,
         attributes: attributes,
         context: nil)*/
        
        let labelSize = postTitle.boundingRectWithSize(constraintSize,
                                                       options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                                                       attributes:[NSFontAttributeName : UIFont.systemFontOfSize(17.0)],
                                                       context: nil)
        print("size is width \(labelSize.width) and height is \(labelSize.height)")
        return labelSize.size
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
