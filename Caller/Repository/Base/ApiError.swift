//
//  ApiError.swift
//  Caller
//
//  Created by Meng Li on 2022/12/24.
//

enum ApiError: Int, Error {
    case unknown = -99999
    case invalidateAccessToken = -99998
}

extension ApiError {
    static func fromCode(_ errorCode: Int) -> ApiError {
        ApiError(rawValue: errorCode) ?? .unknown
    }
}
