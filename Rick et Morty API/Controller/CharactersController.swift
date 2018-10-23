//
//  CharactersController.swift
//  Rick et Morty API
//
//  Created by Thierry Huu on 19/10/2018.
//  Copyright © 2018 Thierry Huu. All rights reserved.
//

import UIKit

class CharactersController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var nextPage = ""
    var characters: [Character] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getCharacters(url: APIHelper().charactersUrl)
    }

    func getCharacters(url: String) {
        APIHelper().getCharacters(url,
            completion: { (nextPage, characters, errorString) in
                if nextPage != nil {
                    self.nextPage = nextPage!
                }
                
                if errorString != nil {
                    print(errorString!)
                }
                
                if characters != nil {
                    self.characters.append(contentsOf: characters!)
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    // Optionnelle si 1 section
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let character = characters[indexPath.item]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as? CharacterCell {
            cell.setupCell(character)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let taille = collectionView.frame.width / 2 - 20
        return CGSize(width: taille, height: taille)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == characters.count - 1 {
            // Téléchargement de la page suivante
            if nextPage != "" {
                getCharacters(url: nextPage)
            }
        }
    }
}


