//
//  CoreDataManager.swift
//  SettingsDemo
//
//  Created by vinmac on 20/09/19.
//  Copyright © 2019 vinmac. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    static var coreDataManager = CoreDataManager()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let settingEntityName = "Settings"
    lazy var context = appDelegate.persistentContainer.viewContext
    
    static var settings: [String: String] = [:]
    
    private init() {
        CoreDataManager.settings = [
            Setting.AirplaneMode.rawValue : "",
            Setting.WiFi.rawValue: "",
            Setting.Blutooth.rawValue : "",
            Setting.MobileData.rawValue: "",
            Setting.Carrier.rawValue: "",
            Setting.Notifications.rawValue: "",
            Setting.DoNotDisturb.rawValue: ""
        ]
    }
        
    func saveDataToDisk() {
        let entity = NSEntityDescription.entity(forEntityName: self.settingEntityName, in: context)
        let setting = NSManagedObject(entity: entity!, insertInto: context)
        
        setting.setValue(CoreDataManager.settings[Setting.AirplaneMode.rawValue], forKey: "airplaneMode")
        setting.setValue(CoreDataManager.settings[Setting.WiFi.rawValue], forKey: "wiFi")
        setting.setValue(CoreDataManager.settings[Setting.Blutooth.rawValue], forKey: "bluetooth")
        setting.setValue(CoreDataManager.settings[Setting.MobileData.rawValue], forKey: "mobileData")
        setting.setValue(CoreDataManager.settings[Setting.Carrier.rawValue], forKey: "carrier")
        setting.setValue(CoreDataManager.settings[Setting.Notifications.rawValue], forKey: "notifications")
        setting.setValue(CoreDataManager.settings[Setting.DoNotDisturb.rawValue], forKey: "dnd")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func fetchDataFromDisk() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.settingEntityName)
        do {
            let result = try context.fetch(request)
            for settings in result as! [NSManagedObject] {
                if let airplaneMode = settings.value(forKey: "airplaneMode") as? String {
                    CoreDataManager.settings[Setting.AirplaneMode.rawValue] = airplaneMode
                }
                if let wiFi = settings.value(forKey: "wiFi") as? String {
                    CoreDataManager.settings[Setting.WiFi.rawValue] = wiFi
                }
                if let bluetooth = settings.value(forKey: "bluetooth") as? String {
                    CoreDataManager.settings[Setting.Blutooth.rawValue] = bluetooth
                }
                if let mobileData = settings.value(forKey: "mobileData") as? String {
                    CoreDataManager.settings[Setting.MobileData.rawValue] = mobileData
                }
                if let carrier = settings.value(forKey: "carrier") as? String {
                    CoreDataManager.settings[Setting.Carrier.rawValue] = carrier
                }
                if let notifications = settings.value(forKey: "notifications") as? String {
                    CoreDataManager.settings[Setting.Notifications.rawValue] = notifications
                }
                if let dnd = settings.value(forKey: "dnd") as? String {
                    CoreDataManager.settings[Setting.DoNotDisturb.rawValue] = dnd
                }
            }
        } catch {
            print("Failed")
        }
    }
}
