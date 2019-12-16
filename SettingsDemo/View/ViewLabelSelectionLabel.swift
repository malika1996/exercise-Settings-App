//
//  ViewLabelSelectionLabel.swift
//  SettingsDemo
//
//  Created by vinmac on 18/09/19.
//  Copyright © 2019 vinmac. All rights reserved.
//

import UIKit

class ViewLabelSelectionLabel: UITableViewCell {

    @IBOutlet weak var coloredView: UIView!
    @IBOutlet weak var lblSettingName: UILabel!
    @IBOutlet weak var lblSelectedChoice: UILabel!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var leadingConstraintOfLblSettingName: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraintOfLine: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.coloredView.layer.cornerRadius = 5.0
//        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
    }
}
