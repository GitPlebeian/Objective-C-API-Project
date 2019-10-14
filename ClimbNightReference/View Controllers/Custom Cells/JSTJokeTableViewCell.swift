//
//  JSTJokeTableViewCell.swift
//  ClimbNightReference
//
//  Created by Jackson Tubbs on 10/10/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

import UIKit

class JSTJokeTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var jokeLabel: UILabel!
    @IBOutlet weak var catagoryLabel: UILabel!
    
    // MARK: - Properties
    
    var joke: String? {
        didSet {
            updateJokeLabel()
        }
    }
    
    var catagory: String? {
        didSet {
            updateJokeCatagoryLabel()
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Custom Functions
    
    func updateJokeLabel() {
        guard let joke = joke else {return}
        jokeLabel.text = joke
    }
    
    func updateJokeCatagoryLabel() {
        guard let catagory = catagory else {return}
        catagoryLabel.text = "Catagory: \(catagory)"
    }
}
