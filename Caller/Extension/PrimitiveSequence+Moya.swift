//
//  PrimitiveSequence+Moya.swift
//  Caller
//
//  Created by Meng Li on 2022/12/24.
//

import Moya
import RxSwift
import RxCocoa

extension PrimitiveSequence where Trait == SingleTrait, Element == Moya.Response {

    public func mapResponse<D: Decodable>(_ type: D.Type, using decoder: JSONDecoder) -> Single<D> {
        flatMap { response -> Single<D> in
            switch response.statusCode {
            case 200:
                return .just(try response.map(
                    type,
                    atKeyPath: nil,
                    using: decoder,
                    failsOnEmptyData: false)
                )
            case 401:
                return .error(ApiError.invalidateAccessToken)
            default:
                let errorResponse = try response.map(ApiErrorResponse.self)
                return .error(ApiError.fromCode(errorResponse.errorCode))
            }
        }
    }
    
    public func mapResponse<D: Decodable>(_ type: D.Type) -> Single<D> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return mapResponse(type, using: decoder)
    }
    
}
