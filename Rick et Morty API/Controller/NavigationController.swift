//
//  NavigationController.swift
//  Rick et Morty API
//
//  Created by Thierry Huu on 19/10/2018.
//  Copyright © 2018 Thierry Huu. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = .darkGray
        navigationBar.tintColor = .white
        
        let image = UIImage(named: "Rick_and_Morty_logo")
        let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0,
            y: 0,
            width: navigationBar.frame.width / 2,
            height: navigationBar.frame.height)
        imageView.center.x = navigationBar.center.x
        navigationBar.addSubview(imageView)
    }
}
