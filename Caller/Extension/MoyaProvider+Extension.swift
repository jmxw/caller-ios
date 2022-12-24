//
//  MoyaProvider+Extension.swift
//  Caller
//
//  Created by Meng Li on 2022/12/24.
//

import Moya

extension MoyaProvider {
    static func withNetworkLoggerPlugin(otherPlugins: [PluginType] = []) -> MoyaProvider {
        var networkLoggerPlugins: [PluginType] = []
        
        #if DEBUG
        networkLoggerPlugins.append(NetworkLoggerPlugin(configuration: .init(logOptions: .formatRequestAscURL)))
        #endif
        
        return MoyaProvider(plugins: otherPlugins + networkLoggerPlugins)
    }
}
