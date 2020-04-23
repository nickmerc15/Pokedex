//
//  PokeDetail.swift
//  Pokedex
//
//  Created by Nicholas Mercadante on 4/22/20.
//  Copyright © 2020 Nicholas Mercadante. All rights reserved.
//

import Foundation

class PokeDetail {
    
    private struct Returned: Codable {
        var height: Double
        var weight: Double
        var sprites: Sprites
    }
    
    private struct Sprites: Codable {
        var front_default: String
    }
    var height = 0.0
    var weight = 0.0
    var imageURL = ""
    
    
    var url = ""

    func getData(completed: @escaping ()->()) {
        let urlString = url
  
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            completed()
            return
        }
 
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            do {
                let returned = try JSONDecoder().decode(Returned.self, from: data!)
                self.height = returned.height
                self.weight = returned.weight
                self.imageURL = returned.sprites.front_default
            } catch {
                print("😡 JSON ERROR: \(error.localizedDescription)")
            }
            completed()
        }
        
        task.resume()
    }
}


