//
//  DisplayBrightnessViewController.swift
//  SettingsDemo
//
//  Created by vinmac on 19/09/19.
//  Copyright © 2019 vinmac. All rights reserved.
//

import UIKit

class DisplayBrightnessViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var displaySettingsOptionsArray = [
        ["Brightness slider control"],
        ["Night Shift"],
        ["Auto Lock"],
        ["Text Size", "Bold Text"],
        ["View"],
        []
    ]
    
    var headerViewTitle = ["BRIGHTNESS","", "", "", "DISPLAY ZOOM", "Choose a view from iPhone. Zoomed shows larger controls. Standard shows more content."]
    
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
                if indexPath.row == self.displaySettingsOptionsArray[indexPath.section].count-1 {
                    cell.line.isHidden = true
                } else {
                    cell.line.isHidden = false
                }
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
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.section {
//        case 1:
//            if indexPath.row == 0 {
//                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DropDownOptionsViewController") as? DropDownOptionsViewController {
////                    vc.delegate = self
//                    vc.displayDataType = DisplayDataType.listType
////                    vc.currentSetting = Setting.Blutooth.rawValue
//                    vc.listItems = ["Network 1", "Network 2", "Network 3", "Network 4", "Network 5"]
//                    self.present(vc, animated: true, completion: nil)
//                    //                    self.splitViewController?.viewControllers[1] = vc
//                    //                    self.navigationController?.pushViewController(vc, animated: true)
//                }
//            }
//        default:
//            break
//        }
//    }
    
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
}
