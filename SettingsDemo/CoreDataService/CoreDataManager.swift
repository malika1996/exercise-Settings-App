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
    
    private init() {}
    
    static var coreDataManager = CoreDataManager()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let settingEntityName = "Settings"
    lazy var context = appDelegate.persistentContainer.viewContext
    
    func saveDataToDisk() {
        
        let entity = NSEntityDescription.entity(forEntityName: self.settingEntityName, in: context)
        let setting = NSManagedObject(entity: entity!, insertInto: context)
        
        setting.setValue(Settings.shared.airplaneMode, forKey: "airplaneMode")
        setting.setValue(Settings.shared.wiFi, forKey: "wiFi")
        setting.setValue(Settings.shared.bluetooth, forKey: "bluetooth")
        setting.setValue(Settings.shared.mobileData, forKey: "mobileData")
        setting.setValue(Settings.shared.carrier, forKey: "carrier")
        setting.setValue(Settings.shared.notifications, forKey: "notifications")
        setting.setValue(Settings.shared.dnd, forKey: "dnd")

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
                    Settings.shared.airplaneMode = airplaneMode
                }
                if let wiFi = settings.value(forKey: "wiFi") as? String {
                    Settings.shared.wiFi = wiFi
                }
                if let bluetooth = settings.value(forKey: "bluetooth") as? String {
                    Settings.shared.bluetooth = bluetooth
                }
                if let mobileData = settings.value(forKey: "mobileData") as? String {
                    Settings.shared.mobileData = mobileData
                }
                if let carrier = settings.value(forKey: "carrier") as? String {
                    Settings.shared.carrier = carrier
                }
                if let notifications = settings.value(forKey: "notifications") as? String {
                    Settings.shared.notifications = notifications
                }
                if let dnd = settings.value(forKey: "dnd") as? String {
                    Settings.shared.dnd = dnd
                }
            }
        } catch {
            print("Failed")
        }
    }
}
