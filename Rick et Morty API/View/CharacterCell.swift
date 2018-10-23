//
//  CharacterCell.swift
//  Rick et Morty API
//
//  Created by Thierry Huu on 21/10/2018.
//  Copyright © 2018 Thierry Huu. All rights reserved.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var characterIV: UIImageView!
    
    var character: Character!
    
    func setupCell(_ character: Character) {
        self.character = character
        self.nameLbl.text = self.character.name
        self.characterIV.download(self.character.image)
        holderView.layer.cornerRadius = 25
        holderView.clipsToBounds = true
    }
}
