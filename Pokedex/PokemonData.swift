//
//  PokemonData.swift
//  Pokedex
//
//  Created by Nicholas Mercadante on 4/22/20.
//  Copyright © 2020 Nicholas Mercadante. All rights reserved.
//

import Foundation

class PokemonData {
    private struct Returned: Codable {
        var count: Int
        var next: String
        var results: [Pokemon]
    }
    var count = 0
    var url = "https://pokeapi.co/api/v2/pokemon/"
    var pokeArray: [Pokemon] = []

    func getData(completed: @escaping ()->()) {
    let urlString = url
    print("🕸 We are accessing the url \(urlString)")
    
 
    guard let url = URL(string: urlString) else {
        print("😡 ERROR: Could not create a URL from \(urlString)")
        completed()
        return
    }
    
   
    let session = URLSession.shared
    
    
    let task = session.dataTask(with: url) { (data, response, error) in
        if let error = error {
            print("😡 ERROR: \(error.localizedDescription)")
        }
        do {
           let returned = try JSONDecoder().decode(Returned.self, from: data!)
           print("😎 Here is what was returned: \(returned)")
           self.url = returned.next
           self.count = returned.count
            for index in 0..<returned.results.count {
                self.pokeArray.append(returned.results[index])
                  
            }
        } catch {
            print("😡 JSON ERROR: \(error.localizedDescription)")
        }
        completed()
    }
       task.resume()
}
}
