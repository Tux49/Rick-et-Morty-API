//
//  SettingsController.swift
//  Rick et Morty API
//
//  Created by Thierry Huu on 23/10/2018.
//  Copyright © 2018 Thierry Huu. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var statusSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
    }
    
    @IBAction func saveAction(_ sender: Any) {
    }
    
}
