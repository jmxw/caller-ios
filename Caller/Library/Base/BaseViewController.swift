//
//  BaseViewController.swift
//  Caller
//
//  Created by Meng Li on 2022/12/24.
//

import RxAlertViewable
import RxCocoa
import RxController
import RxSwift

class BaseViewController<ViewModel: BaseViewModel>: RxViewController<ViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        disposeBag ~ [
            viewModel.alert ~> rx.alert,
            viewModel.actionSheet ~> rx.actionSheet,
        ]
    }
}

extension BaseViewController: RxAlertViewable {}
