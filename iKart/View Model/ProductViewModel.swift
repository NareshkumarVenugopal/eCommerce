//
//  ProductViewModel.swift
//  iKart
//
//  Created by Jasmin Infotech Private Limited on 27/11/24.
//

import Foundation

class ProductViewModel {
    
    static let instance = ProductViewModel()
    var networkManager = NetworkManager.shared
    var products = [Product]()
    
    func fetchProducts(completion: @escaping () -> Void) {
        networkManager.fetchProducts { [weak self] result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self?.products = products
                    completion()  
                }
            case .failure(let error):
                print("Error fetching products: \(error)")
            }
        }
    }
}
