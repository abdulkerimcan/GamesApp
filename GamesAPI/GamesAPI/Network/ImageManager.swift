//
//  ImageManager.swift
//  GamesAPI
//
//  Created by Abdulkerim Can on 24.02.2025.
//

import UIKit

public final class ImageManager {
    public static let shared = ImageManager()
    private var imageCache = NSCache<NSString, UIImage>()
    
    private init() {
        imageCache.countLimit = 100
        imageCache.totalCostLimit = 50 * 1024 * 1024
    }
    
    private func fixProtocolRelativeURL(_ urlString: String) -> String {
        if urlString.hasPrefix("//") {
            return "https:" + urlString
        }
        return urlString
    }
    
    private func downloadImage(url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(.success(cachedImage))
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "ImageManager", code: 1, userInfo: nil)))
                }
                return
            }
            
            let key = url.absoluteString as NSString
            self.imageCache.setObject(image, forKey: key)
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }
        
        task.resume()
    }
    
    public func loadImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let fixedUrlString = fixProtocolRelativeURL(urlString)
        guard let url = URL(string: fixedUrlString) else {
            completion(.failure(NSError(domain: "GamesAPI.ImageManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        downloadImage(url: url, completion: completion)
    }
}
