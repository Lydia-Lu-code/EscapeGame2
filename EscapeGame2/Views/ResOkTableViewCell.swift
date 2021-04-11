//
//  ResOkTableViewCell.swift
//  EscapeGame2
//
//  Created by 維衣 on 2021/2/22.
//

import UIKit

class ResOkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var res_RoomEscape: UILabel!
    @IBOutlet weak var res_RoomName: UILabel!
    @IBOutlet weak var res_RoomPeople: UILabel!
    @IBOutlet weak var res_RoomPhone: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
