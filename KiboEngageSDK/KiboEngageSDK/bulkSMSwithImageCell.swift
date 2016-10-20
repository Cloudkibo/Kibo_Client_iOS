//
//  bulkSMSwithImageCell.swift
//  KiboEngageSDK
//
//  Created by Cloudkibo on 20/10/2016.
//  Copyright © 2016 KiboEngage. All rights reserved.
//

import UIKit

class bulkSMSwithImageCell: UITableViewCell {
    @IBOutlet weak var lbl_title_BulkSMS_withimage: UILabel!

    @IBOutlet weak var lbl_content_bulkSMS_withimage: UILabel!
    @IBOutlet weak var img_bulkSMS: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
