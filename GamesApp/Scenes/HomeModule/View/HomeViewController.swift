//
//  ViewController.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 22.02.2025.
//

import UIKit

class HomeViewController: UIViewController, HomeViewProtocol {
    var presenter: HomePresenterProtocol!
    var games: [Game] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.load()
        
        view.addSubview(tableView)
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
        ])
    }
    
    func handleOutput(_ MovieOutput: HomePresenterProtocolOutput) {
        switch MovieOutput {
        case .updateTitle(let newTitle):
            title = newTitle
        case .setLoading(let isLoading):
            isLoading ? startAnimating() : stopAnimating()
        case .showGames(let array):
            DispatchQueue.main.async {
                self.games = array
                self.tableView.reloadData()
            }
        }
    }
    
    private func startAnimating() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.spinner.startAnimating()
        }
    }
    
    private func stopAnimating() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.spinner.stopAnimating()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = games[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = game.name
        return cell
    }
}

