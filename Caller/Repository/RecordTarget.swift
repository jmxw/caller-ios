//
//  RecordTarget.swift
//  Caller
//
//  Created by Meng Li on 2022/12/24.
//

import Moya

enum RecordTarget {
    case consume
}

extension RecordTarget: TargetType {
    var baseURL: URL {
        URL(string: "https://beta-caller-api.syhjq.top")!
    }
    
    var path: String {
        switch self {
        case .consume:
            return "/v1/record"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .consume:
            return .get
        }
    }
    
    var task: Moya.Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        nil
    }
}
