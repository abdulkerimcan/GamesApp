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
    private let headers: [String: String] = [
        "Content-Type": "application/json",
        "Authorization": "bearer d83sf9j3lmrm53vas7z5d5av56b108",
        "Client-ID": "6dnm26u74o0s2ae0fwuhp7iq4nfngg"
    ]
    private var downloadTasks = [URL: URLSessionDataTask]()
    
    private init() {
        
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
        
        if let existingTask = downloadTasks[url] {
            existingTask.cancel()
            downloadTasks.removeValue(forKey: url)
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            defer { self.downloadTasks.removeValue(forKey: url) }
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
            guard let data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "ImageManager", code: 1, userInfo: nil)))
                }
                return
            }
            
            let key = url.absoluteString as NSString
            self.imageCache.setObject(image, forKey: key)
        }
        
        downloadTasks[url] = task
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
