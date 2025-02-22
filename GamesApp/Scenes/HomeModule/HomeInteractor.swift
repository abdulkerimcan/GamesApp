//
//  HomeInteractor.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 22.02.2025.
//

import Foundation

final class HomeInteractor: HomeInteractorProtocol  {
    weak var delegate: HomeInteractorDelegate?
    
    func downloadGames() {
        delegate?.handleOutput(.setLoading(true))
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: .init(block: { [weak self] in
            guard let self = self else { return }
            self.delegate?.handleOutput(.setLoading(false))
            self.delegate?.handleOutput(.showGames)
        }))
    }
}
