//
//  UpdateCartViewModel.swift
//  iKart
//
//  Created by Jasmin Infotech Private Limited on 28/11/24.
//

import Foundation
import Combine

class CartManager {
    static let shared = CartManager()
    @Published var cartCount: Int = 0
    private var cartItems: [Product] = []
    
    init() {}
    
    func addToCart() {
        cartCount += 1
    }
    
    func removeFromCart() {
        if cartCount > 0 {
            cartCount -= 1
        }
    }
    
    func addToCart(product: Product) {
        cartItems.append(product)
        cartCount = cartItems.count
    }
    
    func getCartItems() -> [Product] {
        return cartItems
    }
    
    func clearCart() {
        cartItems.removeAll()
    }
}

