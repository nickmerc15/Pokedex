//
//  ViewController.swift
//  Pokedex
//
//  Created by Nicholas Mercadante on 4/22/20.
//  Copyright © 2020 Nicholas Mercadante. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    
    var pokemonData = PokemonData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
       pokemonData.getData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }

    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonData.pokeArray.count
}
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
          cell.textLabel?.text = "\(indexPath.row + 1). \(pokemonData.pokeArray[indexPath.row].name )"
          return cell
      }
    
    
}
