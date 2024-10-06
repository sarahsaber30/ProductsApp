//
//  ProductViewModel.swift
//  ProductsApp
//
//  Created by Sarah Saber on 01/10/2024.
//

import Foundation
import Combine

class ProductViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var selectedCategory: ProductCategoryEnum = .beauty
    
    @Published var isLoading = false
    var currentPage = 0
    var hasMorePages = true
    
    private var cancellables = Set<AnyCancellable>()
    private let productService: ProductService


    // Dependency injection for ProductService
    init(productService: ProductService = ProductService()) {
        self.productService = productService
    }
    
    func reset() {
        isLoading = false
        currentPage = 0
        hasMorePages = true
        products.removeAll()
    }
    
    func beautyButtonPressed() {
        loadFilteredProducts(.beauty)
    }
    
    func fragrancesButtonPressed() {
        loadFilteredProducts(.fragrances)
    }
    
    func loadFilteredProducts(_ category: ProductCategoryEnum){
        reset()
        selectedCategory = category
        loadProducts()
    }
    
    func loadProducts() {
        guard !isLoading && hasMorePages else { return }

        isLoading = true

        productService.fetchProducts(page: 0, category: selectedCategory)
        
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] products in
                self?.products.append(contentsOf: products.products)
                self?.currentPage += 1
                self?.hasMorePages = products.products.count > 0
            }
            .store(in: &cancellables)
    }

}
