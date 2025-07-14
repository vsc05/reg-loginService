//
//  UserModel.swift
//  Pearl
//
//  Created by Lada Priora 2 on 01.06.2025.
//
import Foundation

struct UserData: Identifiable {
    var id: String = UUID().uuidString
    let email: String
    let password: String
    var name: String? = nil
}
