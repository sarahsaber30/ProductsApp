//
//  NetworkError.swift
//  ProductsApp
//
//  Created by Sarah Saber on 01/10/2024.
//

enum NetworkError: Error, Equatable {
    case badURL
    case serverError(String)
    case decodingError
    case unknown
}

