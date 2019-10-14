//
//  JSTMainViewController.swift
//  ClimbNightReference
//
//  Created by Jackson Tubbs on 10/10/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

import UIKit

class JSTMainViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var numberOfJokesSlider: UISlider!
    @IBOutlet weak var numberOfJokesLabel: UILabel!
    @IBOutlet weak var getJokesButton: UIButton!
    @IBOutlet weak var jokesTableView: UITableView!
    
    // MARK: - Properties
    
    var numberOfJokes = 50
    var jokes: [JSTJoke] = []
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        jokesTableView.delegate = self
        jokesTableView.dataSource = self
        updateVariables()
        updateViews()
    }
    
    // MARK: - Actions
    
    @IBAction func numberOfJokesValueChanged(_ sender: UISlider) {
        numberOfJokes = Int(round(sender.value))
        sender.value = Float(numberOfJokes)
        numberOfJokesLabel.text = "\(numberOfJokes)"
    }
    
    @IBAction func getJokesButtonTapped(_ sender: Any) {
        guard let firstNameText = firstNameTextField.text, firstNameText.isEmpty == false,
            let lastNameText = lastNameTextField.text, lastNameText.isEmpty == false else {return}
        getRidOfKeyboard()
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        JSTJokeController.fetchJokes(withFirstName: firstNameText, lastName: lastNameText, numberOfJokes: numberOfJokes, completion: { (jokes) in
            DispatchQueue.main.async {
                if let jokes = jokes {
                    self.jokes = jokes
                } else {
                    self.presentBasicAlert(title: "Error", message: "Big Error")
                }
                self.jokesTableView.reloadData()
            }
        })
    }
    
    // MARK: - Custom Functions
    
    func updateViews() {
        getJokesButton.layer.cornerRadius = getJokesButton.frame.height / 2
    }
    
    func updateVariables() {
        numberOfJokes = Int(round(numberOfJokesSlider.value))
        numberOfJokesLabel.text = "\(numberOfJokes)"
    }
    
    func getRidOfKeyboard() {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
    }
    
    func presentBasicAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okActions = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okActions)
        present(alertController, animated: true)
    }
}

extension JSTMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = jokesTableView.dequeueReusableCell(withIdentifier: "jokeCell", for: indexPath) as? JSTJokeTableViewCell else {return UITableViewCell()}
        cell.joke = jokes[indexPath.row].joke
        cell.catagory = jokes[indexPath.row].categories.first
        return cell
    }
}
