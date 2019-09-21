//
//  Settings.swift
//  SettingsDemo
//
//  Created by vinmac on 19/09/19.
//  Copyright © 2019 vinmac. All rights reserved.
//

import Foundation

//Settings model with default values
class Settings {
    var airplaneMode: String = "Off"
    var wiFi: String = "Network 1"
    var bluetooth: String = "Off"
    var mobileData: String = "On"
    var carrier: String = "Carrier 1"
    var notifications: String = "Off"
    var dnd: String = "Off"
    
    private init() {}
    static var shared = Settings()
}

class SettingFeature {
    init(name: String, value: String) {
        self.name = name
        self.value = value
    }
    var name: String
    var value: String
    
    
}



