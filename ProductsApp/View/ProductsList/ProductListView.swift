//
//  ProductListView.swift
//  ProductsApp
//
//  Created by Sarah Saber on 01/10/2024.

import Foundation
import SwiftUI

struct ProductListView: View {
    @StateObject var viewModel = ProductViewModel()

    var body: some View {
        NavigationView {
            VStack(alignment: .leading,spacing: 18.0) {
                HStack {
                    Button("beauty") {
                        viewModel.beautyButtonPressed()
                    }.buttonStyle(CustomCategoryButtonStyle(isSelected: viewModel.selectedCategory == .beauty))

                    Button("fragrances") {
                        viewModel.fragrancesButtonPressed()
                    }.buttonStyle(CustomCategoryButtonStyle(isSelected: viewModel.selectedCategory == .fragrances))
                }
                .padding(.horizontal)
                
                Text("\(viewModel.products.count) results")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.leading)
                    .foregroundColor(.black.opacity(0.8))
                
                List {
                    ForEach(viewModel.products) { product in
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            ProductRowView(product: product)
                        }
                        .onAppear {
                            if product == viewModel.products.last {
                                viewModel.loadProducts()
                            }
                        }
                    }
                    
                    if viewModel.isLoading {
                        ProgressView("more products...")
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 12))
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Products")
            .font(.subheadline)
            
            .onAppear {
                viewModel.loadProducts()
            }
        }
    }
}
