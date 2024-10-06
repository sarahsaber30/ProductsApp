//
//  ProductRowView.swift
//  ProductsApp
//
//  Created by Sarah Saber on 05/10/2024.
//

import Foundation
import SwiftUI

struct ProductRowView: View {
    let product: Product
    
    var body: some View {
        HStack(spacing: 18.0){
                AsyncImage(url: URL(string: product.thumbnail)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .frame(width: 60, height: 60)
                                .background(Color.white)
                                .cornerRadius(8)
                        } else if phase.error != nil {
                            Image(systemName: "") // Show a placeholder image
                                .resizable()
                                .frame(width: 60, height: 60)
                                .background(Color.white)
                                .cornerRadius(8)
                        } else {
                            ProgressView() // Show a loading indicator
                                .frame(width: 60, height: 60)
                                .background(Color.white)
                                .cornerRadius(8)
                        }
                    }
                
                VStack(alignment: .leading) {
                    
                    Text(product.category.capitalized)
                        .font(.system(size: 14))
                        .padding(5)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        
                    Spacer(minLength: 10)
                    
                    Text("EGP \(product.price, specifier: "%.2f")")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    HStack(spacing: 8) {
                        
                        Text("Sale")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        
                        Text("EGP \(product.discountPercentage, specifier: "%.2f")")
                            .font(.subheadline)
                            .strikethrough()
                            .foregroundColor(.gray)
                    }
                    
                    Text(product.title)
                        .font(.system(size: 14))
                    
                    Spacer(minLength: 10)
                    
                    HStack(spacing: 2) {
                        ForEach(0..<5) { index in
                            Image(systemName: index < Int(product.rating) ? "star.fill" : "star")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.yellow)
                        }
                    }
                }
                Spacer()
            }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}
