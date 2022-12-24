//
//  BaseRepository.swift
//  Caller
//
//  Created by Meng Li on 2022/12/24.
//

import Moya
import RxSwift

class BaseRepository<Target: TargetType> {
    var provider = MoyaProvider<Target>.withNetworkLoggerPlugin(otherPlugins: [])
}
