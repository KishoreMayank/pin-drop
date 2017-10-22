//
//  PinOverviewCell.swift
//  Sweeper
//
//  Created by Raina Wang on 10/22/17.
//  Copyright © 2017 team11. All rights reserved.
//

import UIKit

class PinOverviewCell: UITableViewCell {
    @IBOutlet weak var rowNumberLabel: UILabel!
    @IBOutlet weak var pinImageView: UIImageView!
    @IBOutlet weak var pinBlurbLabel: UILabel!
    @IBOutlet weak var pinMsgLabel: UILabel!

    var pin: Pin! {
        didSet {
            pinImageView.setImageWith(pin.getImageUrl()!)
            pinMsgLabel.text = pin.message!
            pinBlurbLabel.text = pin.blurb!
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
