//
//  todoListTableViewCell.swift
//  todoList
//
//  Created by Toan on 5/23/20.
//  Copyright © 2020 Toan. All rights reserved.
//

import UIKit

class todoListTableViewCell: UITableViewCell {

    @IBOutlet weak var sdtLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var Userimage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
