//
//  ApiErrorResponse.swift
//  Caller
//
//  Created by Meng Li on 2022/12/24.
//

class ApiErrorResponse: Decodable {
    let errorCode: Int
    let errorMsg: String
    let code: Int
    let timestamp: Int64
}
