//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Nicholas Mercadante on 4/22/20.
//  Copyright © 2020 Nicholas Mercadante. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = pokemon.name
               weightLabel.text = ""
               heightLabel.text = ""
        
            updateUserInterface()
           
        // Do any additional setup after loading the view.
    }
    
    func updateUserInterface(){
        let pokeDetail = PokeDetail()
        pokeDetail.url = pokemon.url
        pokeDetail.getData {
            DispatchQueue.main.async {
                self.weightLabel.text = "\(pokeDetail.weight)"
                self.heightLabel.text = "\(pokeDetail.height)"
                
                guard let url = URL(string: pokeDetail.imageURL) else {
                    self.imageView.image = UIImage(systemName: "person.crop.circle.badge.xmark")
                    return
                }
                do {
                    let data = try Data(contentsOf: url)
                    self.imageView.image = UIImage(data: data)
                } catch {
                    print("ERROR: error thrown trying to get image from URL \(url)")
                }
            }
        }
    }

}
