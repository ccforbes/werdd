//
//  WordsTableViewController.swift
//  Werdd
//
//  Created by Chris Forbes on 11/16/23.
//

import UIKit

class WordsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let words = Words()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.wordsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = words.wordsList[indexPath.row].name
        content.secondaryText = words.wordsList[indexPath.row].definition
        cell.contentConfiguration = content
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
