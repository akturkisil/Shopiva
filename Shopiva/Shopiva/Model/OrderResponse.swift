//
//  OrderResponse.swift
//  Shopiva
//
//  Created by Işıl Aktürk on 2.02.2021.
//

import Foundation

// MARK: - OrderList
struct OrderList: Codable {
    let orderList: [[OrderListElement]]
}

// MARK: - OrderListElement
struct OrderListElement: Codable {
    let urunAdi: String?
    let fiyat: String?
    let normal: String

    enum CodingKeys: String, CodingKey {
        case urunAdi = "urun_adi"
        case fiyat, normal
    }
}

