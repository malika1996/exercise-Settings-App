//
//  DropDownOptionsViewController.swift
//  SettingsDemo
//
//  Created by vinmac on 19/09/19.
//  Copyright © 2019 vinmac. All rights reserved.
//

import UIKit

protocol SelectedDataSendProtocol {
    func sendSelectedOption(settingName: String, selectedOption: String)
}

class DropDownOptionsViewController: UIViewController {
    
    weak var delegate: SettingsViewController?
    weak var detailVCDelegate: DisplayBrightnessViewController?
    var displayDataType: DisplayDataType?
    var listItems: [String]?
    var currentSetting: String?
    private var selectedOption: String?
    
    @IBOutlet weak private var tableView: UITableView!
    
    @objc func switchStateChanged(_ mySwitch: UISwitch) {
        if mySwitch.isOn {
            self.selectedOption = "On"
        } else {
            self.selectedOption = "Off"
        }
        if let currentSetting = self.currentSetting, let selectedOption = self.selectedOption {
            self.delegate?.sendSelectedOption(settingName: currentSetting, selectedOption: selectedOption)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ViewLabelSwitchCell", bundle: nil), forCellReuseIdentifier: "ViewLabelSwitchCell")
        }
}

extension DropDownOptionsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.displayDataType == DisplayDataType.switchType {
            return 1
        } else {
            return self.listItems?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.displayDataType == DisplayDataType.switchType {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ViewLabelSwitchCell") as? ViewLabelSwitchCell else {return UITableViewCell()}
            cell.mySwitch.addTarget(self, action: #selector(switchStateChanged(_:)), for: .valueChanged)
            cell.coloredView.isHidden = true
            cell.leadingConstraintOfLblSettingName.constant = 20
            cell.leadingConstraintOfLine.constant = 18
            cell.lblSettingName.text = self.currentSetting
            
            switch self.currentSetting! {
            case Setting.Blutooth.rawValue:
                cell.mySwitch.setOn(Settings.shared.bluetooth == "On" ? true : false, animated: true)
            case Setting.Notifications.rawValue:
                cell.mySwitch.setOn(Settings.shared.notifications == "On" ? true : false, animated: true)
            default:
                break
            }
            return cell
        } else {
            let cell = UITableViewCell()
            if let items = self.listItems {
                cell.textLabel?.text = items[indexPath.row]
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedOption = listItems?[indexPath.row]
        if let currentSetting = self.currentSetting, let selectedOption = self.selectedOption {
            if (self.navigationController?.viewControllers.count)! >= 2 &&  (self.navigationController?.viewControllers[(navigationController?.viewControllers.count)! - 2] as? DisplayBrightnessViewController) != nil {
                self.detailVCDelegate?.sendSelectedOption(settingName: currentSetting, selectedOption: selectedOption)
            } else {
                self.delegate?.sendSelectedOption(settingName: currentSetting, selectedOption: selectedOption)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}
