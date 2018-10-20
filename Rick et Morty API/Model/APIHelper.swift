//
//  APIHelper.swift
//  Rick et Morty API
//
//  Created by Thierry Huu on 20/10/2018.
//  Copyright © 2018 Thierry Huu. All rights reserved.
//

import Foundation

class APIHelper {
    
    private let _baseUrl = "https://rickandmortyapi.com/api/"
    
    var charactersUrl: String {
        return _baseUrl + "character/"
    }
    
    func getCharacters(_ string: String) {
        if let url = URL(string: string) {
            let task = URLSession.shared.dataTask(with: url,
                completionHandler: { (data, response, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                    }
                    
                    if data != nil {
                        
                    }
            })
            task.resume()
        } else {
            print("URL invalide")
        }
    }
}
