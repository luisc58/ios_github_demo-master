//
//  cellContent.swift
//  GithubDemo
//
//  Created by luis castillo on 2/15/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class cellContent: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var star: UILabel!

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var fork: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
