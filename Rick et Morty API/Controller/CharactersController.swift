//
//  CharactersController.swift
//  Rick et Morty API
//
//  Created by Thierry Huu on 19/10/2018.
//  Copyright © 2018 Thierry Huu. All rights reserved.
//

import UIKit

class CharactersController: UIViewController {

    var nextPage = ""
    var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCharacters()
    }

    func getCharacters() {
        APIHelper().getCharacters(APIHelper().charactersUrl,
            completion: { (nextPage, characters, errorString) in
                if nextPage != nil {
                    self.nextPage = nextPage!
                }
                
                if errorString != nil {
                    print(errorString!)
                }
                
                if characters != nil {
                    self.characters.append(contentsOf: characters!)
                }
        })
    }
}


