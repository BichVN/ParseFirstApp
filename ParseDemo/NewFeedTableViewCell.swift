//
//  NewFeedTableViewCell.swift
//  ParseFirstApp
//
//  Created by Bich Vu Ngoc on 12/23/27 H.
//  Copyright © 27 Heisei abearablecode. All rights reserved.
//

import UIKit
import Parse

class NewFeedTableViewCell: UITableViewCell {

    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var timestampLabel: UILabel!
    @IBOutlet var postTextView: UITextView!
    @IBOutlet weak var commentTextView: UITextView!
    
    @IBAction func commentTappedAction(sender: AnyObject) {
        let comment:PFObject = PFObject(className: "Comment")
        comment["content"] = commentTextView.text
        comment["user"] = PFUser.currentUser()
        comment.saveInBackground()
    }
    override init(style: UITableViewCellStyle,
        reuseIdentifier: String?){
            super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
