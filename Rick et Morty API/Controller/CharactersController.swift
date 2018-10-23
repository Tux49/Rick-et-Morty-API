//
//  CharactersController.swift
//  Rick et Morty API
//
//  Created by Thierry Huu on 19/10/2018.
//  Copyright © 2018 Thierry Huu. All rights reserved.
//

import UIKit

class CharactersController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var detailView: DetailView!
    
    var nextPage = ""
    var characters: [Character] = []

    var cellImageFrame = CGRect()
    var detailImageFrame = CGRect()
    var imageDeTransition = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getCharacters(url: APIHelper().charactersUrl)
        
        detailView.alpha = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(animateOut), name: Notification.Name("close"), object: nil)
    }
    
    func animateIn(character: Character) {
        detailImageFrame = detailView.characterIV.convert(detailView.characterIV.bounds, to: view)
        detailView.setup(character: character)
        
        imageDeTransition = UIImageView(frame: cellImageFrame)
        imageDeTransition.download(character.image)
        imageDeTransition.layer.cornerRadius = 25
        imageDeTransition.contentMode = .scaleAspectFill
        imageDeTransition.clipsToBounds = true
        view.addSubview(imageDeTransition)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.imageDeTransition.frame = self.detailImageFrame
            self.imageDeTransition.layer.cornerRadius = self.detailImageFrame.height / 2
            self.collectionView.alpha = 0
        }) { (success) in
            self.detailView.alpha = 1
        }
    }

    @objc func animateOut() {
        UIView.animate(withDuration: 0.5, animations: {
            self.imageDeTransition.frame = self.cellImageFrame
            self.imageDeTransition.layer.cornerRadius = 25
            self.collectionView.alpha = 1
            self.detailView.alpha = 0
        }) { (success) in
            self.imageDeTransition.removeFromSuperview()
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let layout = collectionView.layoutAttributesForItem(at: indexPath) else { return }
        let frame = collectionView.convert(layout.frame, to: collectionView.superview)
        cellImageFrame = CGRect(x: frame.minX, y: frame.minY + 50, width: frame.width, height: frame.height - 50)
        
        let character = characters[indexPath.item]
        animateIn(character: character)
    }
}


