//
//  GameDetailContracts.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 5.03.2025.
//

import UIKit


protocol GameDetailPresenterProtocol: AnyObject {
    func load()
    func loadImage(urlString: String, indexPath: IndexPath)
}

protocol GameDetailPresenterDelegate: AnyObject {
    func setImage(image: UIImage, indexPath: IndexPath)
}

protocol GameDetailViewProtocol: AnyObject {
    func update(_ game: Game)
    func setImage(image: UIImage, indexPath: IndexPath)
}

protocol GameDetailInteractorProtocol: AnyObject {
    var delegate: GameDetailPresenterDelegate? { get set }
    func loadImage(urlString: String, indexPath: IndexPath)
}
