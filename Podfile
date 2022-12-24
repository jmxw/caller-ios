use_frameworks!
platform :ios, '12.0'

target 'Caller' do
    pod 'Alamofire'
    pod 'Moya/RxSwift'
    pod 'R.swift'
    pod 'RxAlamofire'
    pod 'RxAlertViewable'
    pod 'RxBinding'
    pod 'RxCocoa'
    pod 'RxController'
    pod 'RxDataSourcesSingleSection'
    pod 'RxFlow'
    pod 'RxSwift'
    pod 'SnapKit'

    target 'CallerTests' do
        inherit! :search_paths
    end

    post_install do |installer|
      system("bash #{Pathname(installer.sandbox.root)}/RxController/rxtree/build_for_xcode.sh")
    end
end
