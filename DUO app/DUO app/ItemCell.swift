//
//  ItemCell.swift
//  DUO app
//
//  Created by Student on 10/24/19.
//  Copyright © 2019 Angel & Esmee. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemQuantityLabel: UILabel!

    
    var item: Item?{
        didSet{
            guard let item = item else {return}
            itemNameLabel.text = item.Name
            itemQuantityLabel.text = String(Items.shared.GetQuantity(itemName: item.Name))
        }
    }
    
    public func getName() -> String
    {
        return item!.Name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
