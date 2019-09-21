//
//  CellularSettingViewController.swift
//  SettingsDemo
//
//  Created by vinmac on 19/09/19.
//  Copyright © 2019 vinmac. All rights reserved.
//

import UIKit

class CellularSettingViewController: UIViewController {
    
    var cellularSettingsOptionsArray = [
        ["Cellular Data", "Cellular Data Options"],
        []
    ]
    var delegate: SettingsViewController?
    
    var headerViewTitle = ["","Turn off cellular data to restrict all data to Wi-Fi, including email, web browsing, and push notifications"]
    var currentSetting: String?
    var selectedOption: String?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Cellular"
        self.tableView.register(UINib(nibName: "ViewLabelSwitchCell", bundle: nil), forCellReuseIdentifier: "ViewLabelSwitchCell")
        self.tableView.register(UINib(nibName: "ViewLabelSelectionLabel", bundle: nil), forCellReuseIdentifier: "ViewLabelSelectionLabel")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let currentSetting = self.currentSetting, let selectedOption = self.selectedOption {
            self.delegate?.sendSelectedOption(settingName: currentSetting, selectedOption: selectedOption)
        }
    }

}

extension CellularSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellularSettingsOptionsArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ViewLabelSwitchCell") as? ViewLabelSwitchCell else {return UITableViewCell()}
            cell.mySwitch.addTarget(self, action: #selector(switchStateChanged(_:)), for: .valueChanged)
            cell.mySwitch.setOn(Settings.shared.mobileData == "On" ? true : false, animated: true)
            cell.coloredView.isHidden = true
            cell.leadingConstraintOfLblSettingName.constant = 20
            cell.leadingConstraintOfLine.constant = 18
            cell.lblSettingName.text = self.cellularSettingsOptionsArray[indexPath.section][indexPath.row]
            return cell
        } else {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ViewLabelSelectionLabel") as? ViewLabelSelectionLabel else {return UITableViewCell()}
            cell.coloredView.isHidden = true
            cell.leadingConstraintOfLblSettingName.constant = 20
            cell.leadingConstraintOfLine.constant = 18
            cell.lblSettingName.text = self.cellularSettingsOptionsArray[indexPath.section][indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 100))
        headerView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.4196078431, green: 0.4156862745, blue: 0.4392156863, alpha: 1)
        label.frame = CGRect(x: 20, y: 0, width: headerView.frame.width - 40, height: headerView.frame.height)
        label.text = self.headerViewTitle[section]
        label.numberOfLines = 0
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 45
        } else {
            return 100
        }
    }
    
    @objc func switchStateChanged(_ mySwitch: UISwitch) {
        if mySwitch.isOn {
            self.selectedOption = "On"
        } else {
            self.selectedOption = "Off"
        }
    }
}
