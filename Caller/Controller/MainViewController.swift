//
//  MainViewController.swift
//  Caller
//
//  Created by Meng Li on 2022/12/24.
//

import RxSwift

final class MainViewController: BaseViewController<MainViewModel> {

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private lazy var consumeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.rx.tap
            .bind { [unowned self] in
                self.viewModel.consume()
            }
            .disposed(by: disposeBag)
        return button
    }()
    
    override func subviews() -> [UIView] {
        return [
            messageLabel,
            consumeButton,
        ]
    }
    
    override func bind() -> [Disposable] {
        return [
            viewModel.message ~> messageLabel.rx.text,
            viewModel.comsumeTitle ~> consumeButton.rx.title(),
            viewModel.consumeColor ~> consumeButton.rx.backgroundColor,
        ]
    }
    
    override func createConstraints() {
        messageLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.top.equalTo(view.safeArea.top).offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        consumeButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(view.safeArea.bottom).offset(-20)
        }
    }
}

