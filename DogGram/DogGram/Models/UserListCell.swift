//
//  UserListCell.swift
//  DogGram
//
//  Created by Elderied McKinney on 5/26/20.
//  Copyright © 2020 Elderied McKinney. All rights reserved.
//

import UIKit

class UserListCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
