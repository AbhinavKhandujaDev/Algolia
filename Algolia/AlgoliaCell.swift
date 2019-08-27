//
//  AlgoliaCell.swift
//  Algolia
//
//  Created by abhinav khanduja on 27/08/19.
//  Copyright © 2019 abhinav khanduja. All rights reserved.
//

import UIKit

class AlgoliaCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
