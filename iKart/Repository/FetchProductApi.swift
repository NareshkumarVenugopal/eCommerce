//
//  fetchProductApi.swift
//  iKart
//
//  Created by Jasmin Infotech Private Limited on 27/11/24.
//


import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                return
            }

            do {
                // Decode the response into the ProductListResponse model
                let decodedResponse = try JSONDecoder().decode(ProductListResponse.self, from: data)
                // Return the products array
                completion(.success(decodedResponse.products))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
