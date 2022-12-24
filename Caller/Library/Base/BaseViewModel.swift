//
//  BaseViewModel.swift
//  Caller
//
//  Created by Meng Li on 2022/12/24.
//

import RxSwift
import RxAlertViewable
import RxController

class BaseViewModel: RxViewModel {
    
    let alert = PublishSubject<RxAlert>()
    let actionSheet = PublishSubject<RxActionSheet>()
    
}
