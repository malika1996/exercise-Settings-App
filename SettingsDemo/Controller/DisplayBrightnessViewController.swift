//
//  DisplayBrightnessViewController.swift
//  SettingsDemo
//
//  Created by vinmac on 19/09/19.
//  Copyright © 2019 vinmac. All rights reserved.
//

import UIKit

enum DisplayOptions: String {
    case NightShift = "Night Shift",
         AutoLock = "Auto Lock",
         TextSize = "Text Size",
         View = "View"
}

class DisplayBrightnessViewController: UIViewController {

    private var displaySettingsOptionsArray = [
        ["Brightness slider control"],
        ["Night Shift"],
        ["Auto Lock"],
        ["Text Size", "Bold Text"],
        ["View"],
        []
    ]
    private var headerViewTitle = ["BRIGHTNESS","", "", "", "DISPLAY ZOOM", "Choose a view from iPhone. Zoomed shows larger controls. Standard shows more content."]
    private var nightShift = "Off"
    private var autoLock = "1 Minute"
    private var viewStyle = "Standard"
    private var boldText = "On"
    
    @IBOutlet weak private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "SliderCell", bundle: nil), forCellReuseIdentifier: "SliderCell")
        self.tableView.register(UINib(nibName: "ViewLabelSwitchCell", bundle: nil), forCellReuseIdentifier: "ViewLabelSwitchCell")
        self.tableView.register(UINib(nibName: "ViewLabelSelectionLabel", bundle: nil), forCellReuseIdentifier: "ViewLabelSelectionLabel")
        self.navigationItem.title = "Display & Brightness"
    }
}

extension DisplayBrightnessViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.headerViewTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displaySettingsOptionsArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "SliderCell") as? SliderCell else {return UITableViewCell()}
            return cell
        case 1,2:
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ViewLabelSelectionLabel") as? ViewLabelSelectionLabel else {return UITableViewCell()}
            cell.coloredView.isHidden = true
            cell.leadingConstraintOfLblSettingName.constant = 20
            cell.leadingConstraintOfLine.constant = 18
            cell.lblSettingName.text = self.displaySettingsOptionsArray[indexPath.section][indexPath.row]
            if indexPath.section == 1 {
                cell.lblSelectedChoice.text = self.nightShift
            } else {
                cell.lblSelectedChoice.text = self.autoLock
            }
            return cell
        case 3:
            switch indexPath.row {
            case 0:
                guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ViewLabelSelectionLabel") as? ViewLabelSelectionLabel else {return UITableViewCell()}
                cell.lblSettingName.text = self.displaySettingsOptionsArray[indexPath.section][indexPath.row]
                cell.coloredView.backgroundColor = .random
                cell.lblSelectedChoice.isHidden = true
                cell.leadingConstraintOfLblSettingName.constant = 20
                cell.leadingConstraintOfLine.constant = 18
                return cell
            case 1:
                guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ViewLabelSwitchCell") as? ViewLabelSwitchCell else {return UITableViewCell()}
                cell.coloredView.isHidden = true
                cell.leadingConstraintOfLblSettingName.constant = 20
                cell.leadingConstraintOfLine.constant = 18
                cell.lblSettingName.text = self.displaySettingsOptionsArray[indexPath.section][indexPath.row]
                return cell
            default:
                break
            }
        case 4:
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ViewLabelSelectionLabel") as? ViewLabelSelectionLabel else {return UITableViewCell()}
            cell.coloredView.isHidden = true
            cell.leadingConstraintOfLblSettingName.constant = 20
            cell.leadingConstraintOfLine.constant = 18
            cell.lblSettingName.text = self.displaySettingsOptionsArray[indexPath.section][indexPath.row]
            cell.lblSelectedChoice.text = self.viewStyle
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            self.nightShiftRowAction()
        case 2:
            self.autoLockRowAction()
        case 3:
            if indexPath.row == 0 {
                self.textSizeAction()
            }
        case 4:
            self.viewStyleAction()
        default:
            break
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
        switch section {
        case 0,4,5:
            return 65
        default:
            return 45
        }
    }
    
    private func nightShiftRowAction() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DropDownOptionsViewController") as? DropDownOptionsViewController {
            vc.displayDataType = DisplayDataType.switchType
            vc.currentSetting = DisplayOptions.NightShift.rawValue
            vc.detailVCDelegate = self
            vc.navigationItem.title = DisplayOptions.NightShift.rawValue
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func autoLockRowAction() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DropDownOptionsViewController") as? DropDownOptionsViewController {
            vc.displayDataType = DisplayDataType.listType
            vc.listItems = ["1 Minute", "5 Minutes", "10 Minutes", "15 Minutes"]
            vc.currentSetting = DisplayOptions.AutoLock.rawValue
            vc.detailVCDelegate = self
            vc.navigationItem.title = DisplayOptions.AutoLock.rawValue
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func textSizeAction() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DropDownOptionsViewController") as? DropDownOptionsViewController {
            vc.displayDataType = DisplayDataType.listType
            vc.listItems = ["5 pts", "8 pts", "12 pts"]
            vc.currentSetting = DisplayOptions.TextSize.rawValue
            vc.navigationItem.title = DisplayOptions.TextSize.rawValue
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func viewStyleAction() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DropDownOptionsViewController") as? DropDownOptionsViewController {
            vc.displayDataType = DisplayDataType.listType
            vc.listItems = ["Horizontal", "Vertical"]
            vc.detailVCDelegate = self
            vc.currentSetting = DisplayOptions.View.rawValue
            vc.navigationItem.title = DisplayOptions.View.rawValue
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension DisplayBrightnessViewController: SelectedDataSendProtocol {
    func sendSelectedOption(settingName: String, selectedOption: String) {
        switch settingName {
        case DisplayOptions.NightShift.rawValue:
            self.nightShift = selectedOption
        case DisplayOptions.AutoLock.rawValue:
            self.autoLock = selectedOption
        case DisplayOptions.View.rawValue:
            self.viewStyle = selectedOption
        default:
            break
        }
        self.tableView.reloadData()
    }
}

