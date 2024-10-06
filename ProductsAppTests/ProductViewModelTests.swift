////
////  File.swift
////  ProductsAppTests
////
////  Created by Sarah Saber on 05/10/2024.
////
//
//
//import XCTest
//import Combine
//@testable import ProductsApp
//
//class ProductViewModelTests: XCTestCase {
//    var viewModel: ProductViewModel!
//    var mockProductService: MockProductService!
//    var cancellables: Set<AnyCancellable>!
//    
//    override func setUp() {
//        super.setUp()
//        mockProductService = MockProductService()
//        viewModel = ProductViewModel(productService: mockProductService)
//        cancellables = Set<AnyCancellable>()
//    }
//    
//    override func tearDown() {
//        cancellables = nil
//        super.tearDown()
//    }
//
//    func testLoadProductsSuccess() {
//        // Given
//        let mockProducts = [Product(id: 1, title: "Mock Product", description: "Mock Description", category: "beauty", price: 10.0, ...)]
//        mockProductService.stubbedProducts = ProductResponse(products: mockProducts)
//        
//        // When
//        viewModel.loadProducts()
//        
//        // Then
//        viewModel.$products.sink { products in
//            XCTAssertEqual(products.count, 1)
//            XCTAssertEqual(products.first?.title, "Mock Product")
//        }.store(in: &cancellables)
//    }
//}



//import XCTest
//import Combine
//@testable import ProductsApp
//
//class ProductViewModelTests: XCTestCase {
//    var viewModel: ProductViewModel!
//    var mockProductService: MockProductService!
//    var cancellables: Set<AnyCancellable>!
//    
//    override func setUp() {
//        super.setUp()
//        mockProductService = MockProductService()
//        viewModel = ProductViewModel(productService: mockProductService) // Inject the mock service
//        cancellables = Set<AnyCancellable>()
//    }
//    
//    override func tearDown() {
//        cancellables = nil
//        super.tearDown()
//    }
//
//    func testLoadProductsSuccess() {
//        // Given
//        let mockProducts = [Product(id: 1, title: "Mock Product", description: "Mock Description", category: "beauty", price: 10.0)]
//        mockProductService.stubbedProducts = ProductResponse(from: mockProducts) // Provide mock data
//        
//        // When
//        viewModel.loadProducts()
//        
//        // Then
//        viewModel.$products.sink { products in
//            XCTAssertEqual(products.count, 1)
//            XCTAssertEqual(products.first?.title, "Mock Product")
//        }.store(in: &cancellables)
//    }
//}


import XCTest
import Combine
@testable import ProductsApp

class ProductViewModelTests: XCTestCase {
    var viewModel: ProductViewModel!
    var mockProductService: MockProductService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockProductService = MockProductService()
        viewModel = ProductViewModel(productService: mockProductService)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }

    func testLoadProductsSuccess() {
        // Given
//        let mockProducts = [
//            Product(
//                id: 1,
//                title: "Mock Product",
//                description: "Mock Description",
//                category: "beauty",
//                price: 10.0,
//                discountPercentage: 5.0,
//                rating: 4.5,
//                stock: 100,
//                brand: "https://example.com/mock-thumbnail.jpg"
//            )
//        ]
        
//        let mockProducts = [
//            Product(
//                id: 1,
//                title: "Mock Product",
//                description: "Mock Description",
//                category: "beauty",
//                price: 10.0,
//                discountPercentage: 5.0,
//                rating: 4.5,
//                stock: 100,
//                brand: "MockBrand",
//                thumbnail: "https://example.com/mock-thumbnail.jpg",
//                images: ["https://example.com/mock-image1.jpg", "https://example.com/mock-image2.jpg"],
//                tags: ["mock", "sample"],
//                sku: "MOCKSKU12345",
//                weight: 1.2, // Assuming weight is in kilograms
//                dimensions: "10x5x3", // Assuming a string format for dimensions
//                warrantyInformation: "1 year warranty",
//                shippingInformation: "Ships in 2-3 days",
//                availabilityStatus: "In Stock",
//                reviews: [],
//                returnPolicy: "30 days return policy",
//                minimumOrderQuantity: 1,
//                meta: ["key": "value"] // Assuming meta is a dictionary
//            )
//        ]

        

        let mockProducts = [
            Product(
                id: 1,
                title: "Mock Product",
                description: "Mock Description",
                category: "beauty",
                price: 10.0,
                discountPercentage: 5.0,
                rating: 4.5,
                stock: 100,
                tags: ["mock", "sample"], // Place 'tags' before 'brand'
                brand: "MockBrand", sku: "MOCKSKU12345",
                weight: 1,
                dimensions: Dimensions(width: 5.0, height: 3.0,depth: 1.0),
                warrantyInformation: "1 year warranty",
                shippingInformation: "Ships in 2-3 days",
                availabilityStatus: "In Stock", // Make sure 'brand' comes after 'tags'
                reviews: ["https://example.com/mock-image1.jpg", "https://example.com/mock-image2.jpg"],
                returnPolicy: [],
                minimumOrderQuantity: "30 days return policy",
                images: 1, thumbnail: <#String#>,
            )
        ]

        
        mockProductService.stubbedProducts = ProductResponse(from: mockProducts)
        
        // When
        viewModel.loadProducts()
        
        // Then
        viewModel.$products.sink { products in
            XCTAssertEqual(products.count, 1)
            XCTAssertEqual(products.first?.title, "Mock Product")
        }.store(in: &cancellables)
    }
}
