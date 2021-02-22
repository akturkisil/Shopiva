//
//  OrderCell.swift
//  Shopiva
//
//  Created by Işıl Aktürk on 2.02.2021.
//

import UIKit

class OrderCell: UITableViewCell {
    
    @IBOutlet weak var orderImageView: UIImageView!
    @IBOutlet weak var orderNameLabel: UILabel!
    @IBOutlet weak var orderPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
