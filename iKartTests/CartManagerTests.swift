//
//  CartManagerTests.swift
//  iKartTests
//
//  Created by Jasmin Infotech Private Limited on 29/11/24.
//

import XCTest
@testable import iKart

final class CartManagerTests: XCTestCase {
    
    private var systemUndertest: CartManager!
    
    override func setUp() {
        super.setUp()
        systemUndertest = CartManager()
    }
    
    override func tearDown() {
        systemUndertest = nil
        super.tearDown()
    }
    
    func test_addTocart(){
        // Arrange
        let product = Product(
            id: 1,
            title: "SecretTemp Perfume",
            images: ["image1.jpg", "image2.jpg"],
            description: "A luxurious perfume with a secret scent.",
            category: "Fragrance",
            price: 99.99,
            discountPercentage: 15.0,
            rating: 4.5,
            stock: 100,
            tags: ["luxury", "perfume", "fragrance"],
            sku: "SKU12345",
            weight: 200,
            dimensions: Dimensions(width: 5, height: 5, depth: 10),
            warrentyInformation: "1-year warranty",
            shippingInformation: "Free shipping",
            availabilityStatus: "In Stock",
            reviews: []
        )
        let initialCartCount = systemUndertest.cartCount
        
        // Act
        systemUndertest.addToCart(product: product)
        
        // Assert
        XCTAssertEqual(systemUndertest.cartCount, initialCartCount + 1)
    }
    
}

