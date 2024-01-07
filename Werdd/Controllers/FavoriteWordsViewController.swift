//
//  FavoriteWordsViewController.swift
//  Werdd
//
//  Created by Chris Forbes on 1/4/24.
//

import UIKit

class FavoriteWordsViewController: UIViewController {
    
    private var favoriteWords: [FavoriteWord]?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(FavoriteWordsTableViewCell.self, forCellReuseIdentifier: FavoriteWordsTableViewCell.id)
        return tableView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupUI()
        fetchFavoriteWords()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func setupUI() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func fetchFavoriteWords() {
        DataManager.fetchAllFavoriteWords { favoriteWords in
            self.favoriteWords = favoriteWords
        }
    }
    
    private func deleteFavoritedWord(_ word: FavoriteWord, atIndexPath indexPath: IndexPath) {
        do {
            try DataManager.deleteFavoriteWord(word: word)
            favoriteWords?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            print("Unable to remove word from list")
        }
    }

}

extension FavoriteWordsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteWords?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favoriteWord = favoriteWords?[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteWordsTableViewCell.id, for: indexPath) as! FavoriteWordsTableViewCell
        cell.update(favoriteWord: favoriteWord)
        return cell
    }
    
}

extension FavoriteWordsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Delete", message: "Are you sure you want to delete?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Delete", style: .default) { _ in
            guard let favoriteWord = self.favoriteWords?[indexPath.row] else { return }
            self.deleteFavoritedWord(favoriteWord, atIndexPath: indexPath)
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
