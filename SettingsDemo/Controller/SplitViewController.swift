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
    
//    func primaryViewController(forCollapsing splitViewController: UISplitViewController) -> UIViewController? {
//        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController {
//            return vc
//        }
//        return nil
//    }
    
//    func primaryViewController(forExpanding splitViewController: UISplitViewController) -> UIViewController? {
//        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController {
//            return vc
//        }
//        return nil
//    }
    
//    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool{
//        return true
//    }
    
}
