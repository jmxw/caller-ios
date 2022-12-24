//
//  AppFlow.swift
//  Caller
//
//  Created by Meng Li on 2022/12/24.
//

import RxSwift
import RxFlow

enum AppStep: Step {
    case main
}

class AppFlow: Flow {
    
    var root: Presentable {
        return rootWindow
    }
    
    private let rootWindow: UIWindow
    
    private lazy var rootViewController = UIViewController()
    
    init(window: UIWindow) {
        rootWindow = window
        rootWindow.backgroundColor = .white
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let appStep = step as? AppStep else {
            return .none
        }
        switch appStep {
        case .main:
            let main = MainFlow()
            Flows.use(main, when: .ready) {
                self.rootWindow.rootViewController = $0
            }
            return .flow(main, with: MainStep.start)
        }
    }
}
