//
//  SplitViewController.swift
//  SettingsDemo
//
//  Created by vinmac on 20/09/19.
//  Copyright © 2019 vinmac. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.preferredDisplayMode = .allVisible

    }
}
