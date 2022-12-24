//
//  Record.swift
//  Caller
//
//  Created by Meng Li on 2022/12/24.
//

class Record: Decodable {
    let id: Int64
    let createAt: Date
    let message: String
}
