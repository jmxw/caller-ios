//
//  MainViewModel.swift
//  Caller
//
//  Created by Meng Li on 2022/12/24.
//

import RxCocoa
import RxSwift

final class MainViewModel: BaseViewModel {
    private let isConsumingRelay = BehaviorRelay<Bool>(value: false)
    
    var message: Observable<String> {
        .just("暂无消息")
    }
    
    var comsumeTitle: Observable<String?> {
        isConsumingRelay.map {
            $0 ? "Stop" : "Start"
        }
    }
    
    var consumeColor: Observable<UIColor> {
        isConsumingRelay.map {
            $0 ? .red : .blue
        }
    }
    
    func consume() {
        isConsumingRelay.accept(!isConsumingRelay.value)
    }
}
