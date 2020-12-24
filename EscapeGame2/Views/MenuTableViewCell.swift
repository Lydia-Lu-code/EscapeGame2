//
//  MeunTableViewCell.swift
//  EscapeGame2
//
//  Created by 維衣 on 2020/12/21.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var picImage: UIImageView!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var accommodateLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
