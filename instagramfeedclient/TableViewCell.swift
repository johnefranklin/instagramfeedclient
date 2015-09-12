//
//  TableViewCell.swift
//  Pods
//
//  Created by John Franklin on 9/10/15.
//
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var instafeedImageView: UIImageView!
    
    @IBOutlet weak var instafeedDescLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
