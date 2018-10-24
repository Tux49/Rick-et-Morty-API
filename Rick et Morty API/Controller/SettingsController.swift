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
        
        setupSwitch()
        setupNameLabel()
    }
    
    func setupSwitch() {
        statusSwitch.setOn(UserDefaultsHelper().getStatus(), animated: true)
        statusLbl.text = "Status: " + UserDefaultsHelper().getStatusString()
    }
    
    func setupNameLabel() {
        let name = UserDefaultsHelper().getName()
        if name == "" {
            nameTextField.placeholder = "Entrez un prénom"
        } else {
            nameTextField.text = name
        }
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        UserDefaultsHelper().setStatus(bool: sender.isOn)
        setupSwitch()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        UserDefaultsHelper().setName(string: nameTextField.text)
        navigationController?.popViewController(animated: true)
    }
    
}
