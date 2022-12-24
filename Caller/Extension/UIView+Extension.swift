//
//  UIView+Extension.swift
//  Caller
//
//  Created by Meng Li on 2022/12/24.
//

import SnapKit
import RxSwift
import RxCocoa

extension UIView {
    
    var safeArea: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.snp
        }
        return snp
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    enum BorderPosition {
        case top
        case left
        case right
        case bottom
    }
    
    func addBorder(width: CGFloat, color: UIColor, position: BorderPosition) {
        let border = UIView()
        border.backgroundColor = color
        addSubview(border)
        switch position {
        case .top:
            border.snp.makeConstraints {
                $0.left.top.right.equalToSuperview()
                $0.height.equalTo(width)
            }
        case .left:
            border.snp.makeConstraints {
                $0.left.top.bottom.equalToSuperview()
                $0.width.equalTo(width)
            }
        case .right:
            border.snp.makeConstraints {
                $0.right.top.bottom.equalToSuperview()
                $0.width.equalTo(width)
            }
        case .bottom:
            border.snp.makeConstraints {
                $0.left.bottom.right.equalToSuperview()
                $0.height.equalTo(width)
            }
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension Reactive where Base: UIView {
    var backgroundColor: Binder<UIColor> {
        Binder(base) { view, color in
            view.backgroundColor = color
        }
    }
}

