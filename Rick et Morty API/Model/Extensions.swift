//
//  Extensions.swift
//  Rick et Morty API
//
//  Created by Thierry Huu on 21/10/2018.
//  Copyright © 2018 Thierry Huu. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func download(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let imageData = data, let image = UIImage(data: imageData) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
