//
//  GameCollectionViewCell.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 24.02.2025.
//

import UIKit

final class GameCollectionViewCell: UICollectionViewCell {
    static let identifier = "GameCollectionViewCell"
    
    private let gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.1
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageView.layer.shadowRadius = 4
        imageView.backgroundColor = .systemGray6
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 2
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let platformsIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.isHidden = true
        imageView.image = UIImage(systemName: "gamecontroller")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(gameImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(platformsIconView)
        containerView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            gameImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            gameImageView.widthAnchor.constraint(equalToConstant: 100),
            gameImageView.heightAnchor.constraint(equalToConstant: 100),
            
            platformsIconView.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 16),
            platformsIconView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            platformsIconView.widthAnchor.constraint(equalToConstant: 16),
            platformsIconView.heightAnchor.constraint(equalToConstant: 16),
        
            titleLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: platformsIconView.trailingAnchor, constant: 8),
            subtitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            subtitleLabel.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 8)
        ])
        
        let separatorView = UIView()
        separatorView.backgroundColor = .systemGray5
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameImageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        platformsIconView.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
    }
    
    func configure(with game: Game) {
        titleLabel.text = game.name
        
        if let platforms = game.platforms, !platforms.isEmpty {
            let platformText = platforms.compactMap { $0.abbreviation }.joined(separator: ", ")
            subtitleLabel.text = platformText
            platformsIconView.isHidden = false
        }
    }
    
    func setImage(_ image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            UIView.transition(with: self.gameImageView,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                self.gameImageView.image = image
            }, completion: nil)
        }
    }
}
