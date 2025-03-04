//
//  NetworkManager.swift
//  GamesAPI
//
//  Created by Abdulkerim Can on 23.02.2025.
//

import Foundation

final class NetworkManager {
    
    enum NetworkError: Error {
        case dataTaskFailed
    }
    
    enum HttpMethod: String, CodingKey {
        case get = "GET"
        case post = "POST"
    }
    
    static let shared = NetworkManager()
    
    private let headers: [String: String] = [
        "Content-Type": "application/json",
        "Authorization": "bearer access_token",
        "Client-ID": "client_id"
    ]
    
    private init() {}
    
    func request<T: Decodable> (_ endpoint: Endpoint, method: HttpMethod,completion: @escaping (Result<T, Error>) -> Void) {
        let url = endpoint.url
        var request = URLRequest(url: url)
        request.httpBody = endpoint.body
        request.httpMethod = method.stringValue
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(NetworkError.dataTaskFailed))
                return
            }
            
            do {
                let data = try JSONDecoder().decode(T.self, from: data)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
