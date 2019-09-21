//
//  SimpleTextViewController.swift
//  SettingsDemo
//
//  Created by vinmac on 20/09/19.
//  Copyright © 2019 vinmac. All rights reserved.
//

import UIKit

class SimpleTextViewController: UIViewController {

    @IBOutlet weak var lblDescription: UILabel!
    var descriptionText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblDescription.text = self.descriptionText ?? "General Screen"

        // Do any additional setup after loading the view.
    }

}
