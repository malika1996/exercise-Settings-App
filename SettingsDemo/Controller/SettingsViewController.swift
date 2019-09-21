//
//  ViewController.swift
//  SettingsDemo
//
//  Created by vinmac on 18/09/19.
//  Copyright © 2019 vinmac. All rights reserved.
//

import UIKit

enum DisplayDataType: String {
    case switchType, listType
}
enum Section: Int {
    case NetworkSection = 0, Notifications, General
}
enum NetworkSection: Int {
    case AirplaneMode = 0, WiFi, Blutooth, MobileData, Carrier
}
enum NotificationsSection: Int {
    case Notifications = 0, DoNotDisturb
}

enum GeneralSection: Int {
    case General = 0, Wallpaper, DisplayBrightness
}

enum Setting: String {
    case AirplaneMode = "Airplane Mode",
        WiFi = "Wi-Fi",
        Blutooth = "Blutooth",
        MobileData = "Mobile Data",
        Carrier = "Carrier",
        Notifications = "Notifications",
        DoNotDisturb = "Do Not Disturb",
        General = "General",
        Wallpaper = "Wallpaper",
        DisplayBrightness = "Display & Brightness"
}

class SettingsViewController: UIViewController {
    
    // MARK: Private class properties
    private var settingsOptionsArray = [
        ["Airplane Mode", "Wi-Fi", "Blutooth", "Mobile Data", "Carrier"],
        ["Notifications", "Do Not Disturb"],
        ["General", "Wallpaper", "Display & Brightness"]
    ]
    private var data = [SettingFeature]()
    private var filtered:[SettingFeature] = []
    private var settings = Settings.shared
    private var searchActive : Bool = false

    // MARK: Private IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    // MARK: View controller life cycles methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ViewLabelSwitchCell", bundle: nil), forCellReuseIdentifier: "ViewLabelSwitchCell")
        self.tableView.register(UINib(nibName: "ViewLabelSelectionLabel", bundle: nil), forCellReuseIdentifier: "ViewLabelSelectionLabel")
        self.searchBar.delegate = self
        self.prepareSettingDataArray()
    }
    
    func prepareSettingDataArray() {
        let settingFeature1 = SettingFeature(name: "Airplane Mode", value: "Off")
        let settingFeature2 = SettingFeature(name: "Wi-Fi", value: "Network 1")
        let settingFeature3 = SettingFeature(name: "Blutooth", value: "Off")
        let settingFeature4 = SettingFeature(name: "Mobile Data", value: "On")
        let settingFeature5 = SettingFeature(name: "Carrier", value: "Carrier 1")
        let settingFeature6 = SettingFeature(name: "Notifications", value: "Off")
        let settingFeature7 = SettingFeature(name: "Do Not Disturb", value: "Off")
        let settingFeature8 = SettingFeature(name: "General", value: "")
        let settingFeature9 = SettingFeature(name: "Wallpaper", value: "")
        let settingFeature10 = SettingFeature(name: "Display & Brightness", value: "")
        
        self.data = [settingFeature1, settingFeature2, settingFeature3, settingFeature4, settingFeature5, settingFeature6, settingFeature7, settingFeature8, settingFeature9, settingFeature10]
    }
}

// MARK: Tableview delegate methods
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.searchActive == true {
            return 1
        }
        return self.settingsOptionsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchActive == true {
            return self.filtered.count
        }
        return self.settingsOptionsArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.searchActive == true {
            let settingFeature = self.filtered[indexPath.row]
            switch settingFeature.name {
            case Setting.AirplaneMode.rawValue:
                guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ViewLabelSwitchCell") as? ViewLabelSwitchCell else {return UITableViewCell()}
                cell.lblSettingName.text = settingFeature.name
                cell.mySwitch.setOn(self.settings.airplaneMode == "On" ? true : false, animated: true)
                cell.mySwitch.tag = NetworkSection.AirplaneMode.rawValue
                cell.mySwitch.addTarget(self, action: #selector(switchStateChanged(_:)), for: .valueChanged)
                return cell
            case Setting.WiFi.rawValue, Setting.Blutooth.rawValue, Setting.Carrier.rawValue:
                guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ViewLabelSelectionLabel") as? ViewLabelSelectionLabel else {return UITableViewCell()}
                cell.lblSelectedChoice.isHidden = false
                cell.lblSettingName.text = settingFeature.name
                cell.coloredView.backgroundColor = .random
                if settingFeature.name == Setting.WiFi.rawValue {
                    cell.lblSelectedChoice.text = self.settings.wiFi
                } else if settingFeature.name == Setting.Blutooth.rawValue {
                    cell.lblSelectedChoice.text = self.settings.bluetooth
                } else if settingFeature.name == Setting.Carrier.rawValue {
                    cell.lblSelectedChoice.text = self.settings.carrier
                }
                return cell
            case Setting.MobileData.rawValue:
                guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ViewLabelSelectionLabel") as? ViewLabelSelectionLabel else {return UITableViewCell()}
                cell.lblSettingName.text = settingFeature.name
                cell.coloredView.backgroundColor = .random
                cell.lblSelectedChoice.isHidden = true
                return cell
            case Setting.Notifications.rawValue, "General", "Wallpaper", Setting.DisplayBrightness.rawValue, Setting.DoNotDisturb.rawValue:
                guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ViewLabelSelectionLabel") as? ViewLabelSelectionLabel else {return UITableViewCell()}
                cell.lblSettingName.text = settingFeature.name
                cell.coloredView.backgroundColor = .random
                cell.lblSelectedChoice.isHidden = true
                return cell
            default:
                break
            }
            
        } else { //When search is not active
            switch indexPath.section {
            case Section.NetworkSection.rawValue:
                switch indexPath.row {
                case NetworkSection.AirplaneMode.rawValue:
                    guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ViewLabelSwitchCell") as? ViewLabelSwitchCell else {return UITableViewCell()}
                    cell.lblSettingName.text = self.settingsOptionsArray[indexPath.section][indexPath.row]
                    cell.mySwitch.setOn(self.settings.airplaneMode == "On" ? true : false, animated: true)
                    cell.mySwitch.tag = NetworkSection.AirplaneMode.rawValue
                    cell.mySwitch.addTarget(self, action: #selector(switchStateChanged(_:)), for: .valueChanged)
                    return cell
                case NetworkSection.WiFi.rawValue, NetworkSection.Blutooth.rawValue, NetworkSection.Carrier.rawValue:
                    guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ViewLabelSelectionLabel") as? ViewLabelSelectionLabel else {return UITableViewCell()}
                    cell.lblSelectedChoice.isHidden = false
                    cell.lblSettingName.text = self.settingsOptionsArray[indexPath.section][indexPath.row]
                    
                    cell.coloredView.backgroundColor = .random
                    if indexPath.row == self.settingsOptionsArray[indexPath.section].count-1 {
                        cell.line.isHidden = true
                    } else {
                        cell.line.isHidden = false
                    }
                    if indexPath.row == NetworkSection.WiFi.rawValue {
                        cell.lblSelectedChoice.text = self.settings.wiFi
                    } else if indexPath.row == NetworkSection.Blutooth.rawValue {
                        cell.lblSelectedChoice.text = self.settings.bluetooth
                    } else {
                        cell.lblSelectedChoice.text = self.settings.carrier
                    }
                    
                    return cell
                case NetworkSection.MobileData.rawValue:
                    guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ViewLabelSelectionLabel") as? ViewLabelSelectionLabel else {return UITableViewCell()}
                    cell.lblSettingName.text = self.settingsOptionsArray[indexPath.section][indexPath.row]
                    cell.coloredView.backgroundColor = .random
                    cell.lblSelectedChoice.isHidden = true
                    return cell
                default:
                    break
                    
                }
            case Section.Notifications.rawValue, Section.General.rawValue:
                guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ViewLabelSelectionLabel") as? ViewLabelSelectionLabel else {return UITableViewCell()}
                cell.lblSettingName.text = self.settingsOptionsArray[indexPath.section][indexPath.row]
                cell.coloredView.backgroundColor = .random
                cell.lblSelectedChoice.isHidden = true
                return cell
            default:
                break
            }
            return UITableViewCell()
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.searchActive == true {
            let settingFeature = self.filtered[indexPath.row]
            switch settingFeature.name {
            case Setting.WiFi.rawValue:
                self.wiFiSettingAction()
            case Setting.Carrier.rawValue:
                self.carrierSettingAction()
            case Setting.MobileData.rawValue:
                self.mobileDataSettingAction()
            case Setting.Blutooth.rawValue:
                self.blutoothSettingAction()
            case Setting.Notifications.rawValue:
                self.notificationsSettingAction()
            case Setting.DoNotDisturb.rawValue:
                self.dndSettingAction()
            case Setting.General.rawValue:
                self.generalSettingAction()
            case Setting.Wallpaper.rawValue:
                self.wallpaperSettingAction()
            case Setting.DisplayBrightness.rawValue:
                self.displayBrightnessSettingAction()
            default:
                break
            }
        } else { //When search is not active
            switch indexPath.section {
                case Section.NetworkSection.rawValue:
                switch indexPath.row {
                    case NetworkSection.WiFi.rawValue:
                        self.wiFiSettingAction()
                    case NetworkSection.Carrier.rawValue:
                        self.carrierSettingAction()
                    case NetworkSection.MobileData.rawValue:
                        self.mobileDataSettingAction()
                    case NetworkSection.Blutooth.rawValue:
                        self.blutoothSettingAction()
                    default:
                        break
                    }
                case Section.Notifications.rawValue:
                switch indexPath.row {
                    case NotificationsSection.Notifications.rawValue:
                        self.notificationsSettingAction()
                    case NotificationsSection.DoNotDisturb.rawValue:
                        self.dndSettingAction()
                    default:
                        break
                }
                case Section.General.rawValue:
                    switch indexPath.row {
                    case GeneralSection.General.rawValue:
                        self.generalSettingAction()
                    case GeneralSection.Wallpaper.rawValue:
                        self.wallpaperSettingAction()
                    case GeneralSection.DisplayBrightness.rawValue:
                        self.displayBrightnessSettingAction()
                    default:
                        break
                    }
                default:
                break
            }
        }
    }
    
    // MARK: Cell actions methods
    func wiFiSettingAction() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DropDownOptionsViewController") as? DropDownOptionsViewController {
            vc.delegate = self
            vc.displayDataType = DisplayDataType.listType
            vc.listItems = ["Network 1", "Network 2", "Network 3", "Network 4", "Network 5"]
            vc.currentSetting = Setting.WiFi.rawValue
            vc.navigationItem.title = Setting.WiFi.rawValue
            if (self.splitViewController?.viewControllers.count)!<=1 {
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let navController = UINavigationController(rootViewController: vc)
                self.splitViewController?.viewControllers[1] = navController
            }
        }
    }
    
    func carrierSettingAction() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DropDownOptionsViewController") as? DropDownOptionsViewController {
            vc.delegate = self
            vc.displayDataType = DisplayDataType.listType
            vc.listItems = ["Carrier 1", "Carrier 2", "Carrier 3", "Carrier 4", "Carrier 5"]
            vc.currentSetting = Setting.Carrier.rawValue
            vc.navigationItem.title = Setting.Carrier.rawValue
            if (self.splitViewController?.viewControllers.count)!<=1 {
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let navController = UINavigationController(rootViewController: vc)
                self.splitViewController?.viewControllers[1] = navController
            }
        }
    }
    
    func mobileDataSettingAction() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CellularSettingViewController") as? CellularSettingViewController {
            vc.delegate = self
            vc.currentSetting = Setting.MobileData.rawValue
            vc.navigationItem.title = Setting.MobileData.rawValue
            if (self.splitViewController?.viewControllers.count)!<=1 {
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let navController = UINavigationController(rootViewController: vc)
                self.splitViewController?.viewControllers[1] = navController
            }
        }
    }
    
    func blutoothSettingAction() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DropDownOptionsViewController") as? DropDownOptionsViewController {
            vc.delegate = self
            vc.displayDataType = DisplayDataType.switchType
            vc.currentSetting = Setting.Blutooth.rawValue
            vc.navigationItem.title = Setting.Blutooth.rawValue
            if (self.splitViewController?.viewControllers.count)!<=1 {
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let navController = UINavigationController(rootViewController: vc)
                self.splitViewController?.viewControllers[1] = navController
            }
        }
    }
    
    func notificationsSettingAction() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DropDownOptionsViewController") as? DropDownOptionsViewController {
            vc.delegate = self
            vc.displayDataType = DisplayDataType.switchType
            vc.currentSetting = Setting.Notifications.rawValue
            vc.navigationItem.title = Setting.Notifications.rawValue
            if (self.splitViewController?.viewControllers.count)!<=1 {
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let navController = UINavigationController(rootViewController: vc)
                self.splitViewController?.viewControllers[1] = navController
            }
        }
    }
    
    func dndSettingAction() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DNDViewController") as? DNDViewController {
            vc.delegate = self
            vc.currentSetting = Setting.DoNotDisturb.rawValue
            vc.navigationItem.title = Setting.DoNotDisturb.rawValue
            if (self.splitViewController?.viewControllers.count)!<=1 {
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let navController = UINavigationController(rootViewController: vc)
                self.splitViewController?.viewControllers[1] = navController
            }
        }
    }
    
    func generalSettingAction() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SimpleTextViewController") as? SimpleTextViewController {
            vc.descriptionText = "General Screen"
            vc.navigationItem.title = Setting.General.rawValue
            if (self.splitViewController?.viewControllers.count)!<=1 {
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let navController = UINavigationController(rootViewController: vc)
                self.splitViewController?.viewControllers[1] = navController
            }
        }
    }
    
    func wallpaperSettingAction() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SimpleTextViewController") as? SimpleTextViewController {
            vc.descriptionText = "Wallpaper Screen"
            vc.navigationItem.title = Setting.Wallpaper.rawValue
            if (self.splitViewController?.viewControllers.count)!<=1 {
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let navController = UINavigationController(rootViewController: vc)
                self.splitViewController?.viewControllers[1] = navController
            }
        }
    }
    
    func displayBrightnessSettingAction() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DisplayBrightnessViewController") as? DisplayBrightnessViewController {
            vc.navigationItem.title = Setting.DisplayBrightness.rawValue
            if (self.splitViewController?.viewControllers.count)!<=1 {
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let navController = UINavigationController(rootViewController: vc)
                self.splitViewController?.viewControllers[1] = navController
            }
        }
    }
    
    @objc func switchStateChanged(_ mySwitch: UISwitch) {
        if mySwitch.tag == NetworkSection.AirplaneMode.rawValue {
            if mySwitch.isOn {
                Settings.shared.airplaneMode = "On"
            } else {
                Settings.shared.airplaneMode = "Off"
            }
        }
    }
}

// MARK: Search bar delegate methods
extension SettingsViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.filtered = []
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var filteredDataSource : [SettingFeature] = []
        searchActive = false
        for settingFeature in data {
            if let searchText = self.searchBar.text {
                if settingFeature.name.lowercased().prefix(searchText.count) == searchText.lowercased() {
                    searchActive = true
                    filteredDataSource.append(settingFeature)
                }
            }
        }
        self.filtered = filteredDataSource
        searchBar.resignFirstResponder()
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.searchActive = false
            self.tableView.reloadData()
        }
    }
}

// MARK: Protocol conformation
extension SettingsViewController: SelectedDataSendProtocol {
    
    func sendSelectedOption(settingName: String, selectedOption: String) {
        switch settingName {
        case Setting.AirplaneMode.rawValue:
            self.settings.airplaneMode = selectedOption
        case Setting.WiFi.rawValue:
            self.settings.wiFi = selectedOption
        case Setting.Blutooth.rawValue:
            self.settings.bluetooth = selectedOption
        case Setting.MobileData.rawValue:
            self.settings.mobileData = selectedOption
        case Setting.Carrier.rawValue:
            self.settings.carrier = selectedOption
        case Setting.Notifications.rawValue:
            self.settings.notifications = selectedOption
        case Setting.DoNotDisturb.rawValue:
            self.settings.dnd = selectedOption
        default:
            break
        }
        self.tableView.reloadData()
    }
}

// MARK: UIColor extension
extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}


