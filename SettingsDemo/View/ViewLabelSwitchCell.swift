//
//  viewLabelSwitchCell.swift
//  SettingsDemo
//
//  Created by vinmac on 18/09/19.
//  Copyright © 2019 vinmac. All rights reserved.
//

import UIKit

class ViewLabelSwitchCell: UITableViewCell {

    @IBOutlet weak var coloredView: UIView!
    @IBOutlet weak var lblSettingName: UILabel!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var leadingConstraintOfLblSettingName: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraintOfLine: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.coloredView.layer.cornerRadius = 5.0
        self.selectionStyle = .none
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
