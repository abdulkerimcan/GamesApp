//
//  GameDetailInteractor.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 5.03.2025.
//

import Foundation
import GamesAPI

final class GameDetailInteractor: GameDetailInteractorProtocol {
    weak var delegate: (any GameDetailPresenterDelegate)?
    private let service: GameServiceProtocol
    init(service: GameService) {
        self.service = service
    }
    func loadImage(urlString: String, indexPath: IndexPath) {
        service.loadImage(urlString: urlString) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let image):
                self.delegate?.setImage(image: image, indexPath: indexPath)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
