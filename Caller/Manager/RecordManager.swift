//
//  RecordManager.swift
//  Caller
//
//  Created by Meng Li on 2022/12/24.
//

import RxSwift
import RxCocoa

final class RecordManager {
    static let shared = RecordManager()
    
    private let isConsumingRelay = BehaviorRelay<Bool>(value: false)
    private let timerSubject = PublishSubject<Void>()
    private let recordSubject = BehaviorSubject<Record?>(value: nil)
    private let disposeBag = DisposeBag()
    
    private init() {
        Observable<Int>
            .interval(
                RxTimeInterval.seconds(10),
                scheduler: MainScheduler.instance
            )
            .startWith(0)
            .map { _ in }
            .bind(to: timerSubject)
            .disposed(by: disposeBag)
        
        timerSubject
            .withLatestFrom(isConsumingRelay)
            .filter { $0 }
            .flatMapLatest { _ in
                RecordRepository.shared.consume().map { $0.record }
            }
            .asDriver(onErrorJustReturn: nil)
            .drive(recordSubject)
            .disposed(by: disposeBag)
        
    }
    
    func observeIsConsuming() -> Observable<Bool> {
        isConsumingRelay.asObservable()
    }
    
    func toggleIsConsuming() {
        isConsumingRelay.accept(!isConsumingRelay.value)
    }
    
    func observeRecord() -> Observable<Record?> {
        recordSubject.asObservable()
    }
}
