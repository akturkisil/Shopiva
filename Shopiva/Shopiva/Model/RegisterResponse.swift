//
//  RegisterResponse.swift
//  Shopiva
//
//  Created by Işıl Aktürk on 31.01.2021.
//

import Foundation

struct RegisterResponse: Codable {
    let user: [RegisterUserResponse]
}

struct RegisterUserResponse: Codable {
    let durum: Bool
    let kullaniciId: String
    let mesaj: String
}
