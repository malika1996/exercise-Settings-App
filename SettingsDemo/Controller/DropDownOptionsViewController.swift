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
    
    var delegate: SettingsViewController?
    var displayDataType: DisplayDataType?
    var listItems: [String]?
    var currentSetting: String?
    var selectedOption: String?
    
    let standaloneItem = UINavigationItem()
    
    let navigationBar = UINavigationBar()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ViewLabelSwitchCell", bundle: nil), forCellReuseIdentifier: "ViewLabelSwitchCell")
        }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        if let currentSetting = self.currentSetting, let selectedOption = self.selectedOption {
//            self.delegate?.sendSelectedOption(settingName: currentSetting, selectedOption: selectedOption)
//            self.navigationController?.popViewController(animated: true)
//        }
//    }
    
 
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
//        let cell = self.tableView.cellForRow(at: indexPath)
//        cell!.accessoryType = .checkmark
        if let currentSetting = self.currentSetting, let selectedOption = self.selectedOption {
            self.delegate?.sendSelectedOption(settingName: currentSetting, selectedOption: selectedOption)
//            self.navigationController?.popViewController(animated: true)
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
    
    @objc func switchStateChanged(_ mySwitch: UISwitch) {
        if mySwitch.isOn {
            self.selectedOption = "On"
        } else {
            self.selectedOption = "Off"
        }
        if let currentSetting = self.currentSetting, let selectedOption = self.selectedOption {
            self.delegate?.sendSelectedOption(settingName: currentSetting, selectedOption: selectedOption)
//            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
//func placeNavigationBar(){
//
//    let item = UINavigationItem()
//    let headerView = UILabel()
//    item.titleView = headerView
//    item.title = "Genkalfkdlkf"
//    let navigationBar = UINavigationBar()
//    navigationBar.isTranslucent = true
//    navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
//    navigationBar.barStyle = .black
//    navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//
//    navigationBar.heightAnchor.constraint(equalToConstant: 55)
//
//    view.addSubview(navigationBar)
//    navigationBar.translatesAutoresizingMaskIntoConstraints = false
//    navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//    navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//    navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//    navigationBar.bottomAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
//
//    navigationBar.items = [item]
//}
