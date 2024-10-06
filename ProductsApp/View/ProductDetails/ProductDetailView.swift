//
//  ProductDetailView.swift
//  ProductsApp
//
//  Created by Sarah Saber on 05/10/2024.
//

import Foundation
import SwiftUI

struct ProductDetailView: View {
    let product: Product
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                VStack(alignment: .leading) {
                    Text(product.title)
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                    
                    Text("SKU: \(product.sku)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
                
                HStack (alignment: .center) {
                        Spacer()
                        AsyncImage(url: URL(string: product.thumbnail)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 300)
                                    .background(Color.white)
                                    .cornerRadius(12)
                            } else if phase.error != nil {
                                Image(systemName: "") // Placeholder for error
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 300)
                                    .background(Color.white)
                                    .cornerRadius(12)
                            } else {
                                ProgressView() // Loading indicator
                                    .frame(height: 300)
                                    .background(Color.white)
                                    .cornerRadius(12)
                            }
                        }
                        Spacer()
                }
                
                
                ProductCardView(product: product)
                                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Description")
                        .font(.system(size: 14))
                        .bold()
                    
                    Text(product.description) // Assuming 'description' exists in the Product model
                        .font(.body)
                        .foregroundColor(.gray)
                }
                .padding([.leading, .trailing, .bottom],24)
            }
        }
        .navigationBarTitle(Text(product.title), displayMode: .inline)
    }
}
