//
//  APIHelper.swift
//  Rick et Morty API
//
//  Created by Thierry Huu on 20/10/2018.
//  Copyright © 2018 Thierry Huu. All rights reserved.
//

import Foundation

typealias APICompletion = (_ next: String?, _ characters: [Character]?, _ error: String?) -> Void

class APIHelper {
    
    private let _baseUrl = "https://rickandmortyapi.com/api/"
    
    var charactersUrl: String {
        return _baseUrl + "character/"
    }
    
    func urlAvecParam() -> String {
        var base = charactersUrl + "?"
        if UserDefaultsHelper().getName() != "" {
            base += "name=" + UserDefaultsHelper().getName() + "&"
            let status = UserDefaultsHelper().getStatus() ? "alive" : "dead"
            base += "status=" + status
        }
        return base
    }
    
    func getCharacters(_ string: String, completion: APICompletion?) {
        if let url = URL(string: string) {
            let task = URLSession.shared.dataTask(with: url,
                completionHandler: { (data, response, error) in
                    if error != nil {
                        completion?(nil, nil, error!.localizedDescription)
                    }
                    
                    if data != nil {
                        do {
                            let json = try JSONDecoder().decode(APIResult.self, from: data!)
                            completion?(json.info.next, json.results, nil)
                        } catch {
                            completion?(nil, nil, error.localizedDescription)
                        }
                    } else {
                        completion?(nil, nil, "Aucune data disponible")
                    }
            })
            
            task.resume()
        } else {
            completion?(nil, nil, "URL invalide")
        }
    }
}
