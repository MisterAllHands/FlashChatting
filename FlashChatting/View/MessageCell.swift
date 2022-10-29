//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by TTGMOTSF on 19/10/2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var meImageView: UIImageView!
    @IBOutlet weak var youImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.layer.cornerRadius = mainView.frame.size.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
