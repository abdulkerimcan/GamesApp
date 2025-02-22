//
//  ViewController.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 22.02.2025.
//

import UIKit

class HomeViewController: UIViewController, HomeViewProtocol {
    var presenter: HomePresenterProtocol!
    func handleOutput(_ MovieOutput: HomePresenterProtocolOutput) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }


}

