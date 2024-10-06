//
//  ProductModel.swift
//  ProductsApp
//
//  Created by Sarah Saber on 01/10/2024.
//

import Foundation


// MARK: - ProductsModel
struct ProductResponse: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable, Identifiable, Equatable {
    let id: Int
    let title, description, category: String
    let price, discountPercentage, rating: Double
    let stock: Int
    let sku: String
    let weight: Int
    let dimensions: Dimensions
    let warrantyInformation, shippingInformation, availabilityStatus: String
    let reviews: [Review]
    let returnPolicy: String
    let minimumOrderQuantity: Int
    let images: [String]
    let thumbnail: String
}

struct Dimensions: Codable, Equatable {
    let width, height, depth: Double
}

struct Review: Codable, Equatable {
    let rating: Int
    let comment, date, reviewerName, reviewerEmail: String
}


