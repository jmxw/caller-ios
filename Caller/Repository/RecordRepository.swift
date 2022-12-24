//
//  RecordRepository.swift
//  Caller
//
//  Created by Meng Li on 2022/12/24.
//

import RxSwift

final class RecordRepository: BaseRepository<RecordTarget> {
    static let shared = RecordRepository()
    
    private override init() {}
    
    func consume() -> Single<ConsumeRecordResponse> {
        return provider.rx.request(.consume)
            .mapResponse(ConsumeRecordResponse.self)
    }
}
