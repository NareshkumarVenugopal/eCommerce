//
//  ProductModel.swift
//  iKart
//
//  Created by Jasmin Infotech Private Limited on 27/11/24.
//


struct ProductListResponse: Codable {
    let total: Int
    let skip: Int
    let limit: Int
    let products: [Product]
}

struct Product: Codable {
    let id: Int
    let title: String
    let images: [String]
    let description: String
    let category: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let tags: [String]
    let sku: String
    let weight: Int
    let dimensions: Dimensions
    let warrentyInformation: String?
    let shippingInformation:String?
    let availabilityStatus: String?
    let reviews: [Review]
    
    var formattedTags: String {
        tags.joined(separator: ", ")
    }
}


struct Dimensions: Codable{
    let width: Double
    let height: Double
    let depth: Double
    var formattedDimensions: String {
        "\(Int(width))*\(Int(height))*\(Int(depth))"
    }
}

struct Review: Codable {
    let rating: Int
    let comment: String
    let date: String
    let reviewerName: String
    let reviewerEmail: String
}
