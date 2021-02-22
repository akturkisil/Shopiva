//
//  ProductsResponse.swift
//  Shopiva
//
//  Created by Işıl Aktürk on 31.01.2021.
//

import Foundation

struct ProductsResponse: Codable {
    let Products: [ProductstInfoResponse]
}

struct ProductstInfoResponse: Codable {
    let durum: Bool
    let mesaj: String
    let bilgiler: [Product]
}

struct Product: Codable {
    let productId: String
    let productName: String
    let description: String
    let price: String
    let images: [ProductImage]
}

struct ProductImage: Codable {
    let normal: String
    let thumb: String
}
