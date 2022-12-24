//
//  MainFlow.swift
//  Caller
//
//  Created by Meng Li on 2022/12/24.
//

import RxFlow

enum MainStep: Step {
    case start
}

class MainFlow: Flow {
    
    var root: Presentable {
        return mainViewController
    }
    
    private lazy var mainViewController = MainViewController(viewModel: MainViewModel())
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MainStep else {
            return .none
        }
        switch step {
        case .start:
            let mainViewController = MainViewController(viewModel: .init())
            mainViewController.modalPresentationStyle = .fullScreen
            return .viewController(mainViewController)
        }
    }
    
}


