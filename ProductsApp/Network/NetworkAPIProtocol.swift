//
//  NetworkAPIProtocol.swift
//  ProductsApp
//
//  Created by Sarah Saber on 06/10/2024.
//

import Foundation
import Combine

protocol NetworkAPIProtocol {
    func request<T: Decodable>(url: URL, responseType: T.Type) -> AnyPublisher<T, NetworkError>
}
