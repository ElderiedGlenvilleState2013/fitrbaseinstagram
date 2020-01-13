//
//  FeedCell.swift
//  DogGram
//
//  Created by McKinney family  on 1/13/20.
//  Copyright © 2020 Elderied McKinney. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func likeButtonClicked(_ sender: Any) {
        
    }
    
}
