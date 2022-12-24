//
//  AppDelegate.swift
//  Caller
//
//  Created by Meng Li on 2022/12/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxFlow
@_exported import RxBinding
import SnapKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    private let coordinator = FlowCoordinator()
    private let disposeBag = DisposeBag()
    private let window = UIWindow()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        coordinator.rx.didNavigate.subscribe(onNext: {
            AppLog.debug("did navigate to \($0) -> \($1)")
        }).disposed(by: disposeBag)
        
        coordinate {
            (AppFlow(window: $0), AppStep.main)
        }

        return true
    }

}

extension AppDelegate {
    private func coordinate(to: (UIWindow) -> (Flow, Step)) {
        let (flow, step) = to(window)
        coordinator.coordinate(flow: flow, with: OneStepper(withSingleStep: step))
        window.makeKeyAndVisible()
    }
    
    static var flowCoordinator: FlowCoordinator {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Delegate type must be AppDelegate!")
        }
        return delegate.coordinator
    }
}
