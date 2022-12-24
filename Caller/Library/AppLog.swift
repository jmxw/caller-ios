//
//  AppLog.swift
//  Caller
//
//  Created by Meng Li on 2022/12/24.
//

enum AppLog {
    enum Level: Int {
        case debug = 0
        case info
        case warning
        case error
        case none

        var header: String {
            switch self {
            case .debug: return "R[D]"
            case .info: return "R[I]"
            case .warning: return "R[W]"
            case .error: return "R[E]"
            case .none: return ""
            }
        }

        var isEnabled: Bool {
            return self.rawValue >= AppLog.enabledLogLevel.rawValue
        }
    }

    struct AppLogData {
        var level: Level
        var message: String
    }

    static var enabledLogLevel: Level = .debug

    static func debug(_ item: Any, tags: String...) {
        output(logLevel: .debug, item: item, tags: tags)
    }

    static func info(_ item: Any, tags: String...) {
        output(logLevel: .info, item: item, tags: tags)
    }

    static func warning(_ item: Any, tags: String...) {
        output(logLevel: .warning, item: item, tags: tags)
    }

    static func error(_ item: Any, tags: String...) {
        output(logLevel: .error, item: item, tags: tags)
    }
}

private extension AppLog {
    static func output(logLevel: Level, item: Any, tags: [String]) {
        #if DEBUG
        if !logLevel.isEnabled { return }

        let message = String(describing: item)
        let logText = createLogText(logLevel: logLevel, tags: tags, message: message)

        print(logText)

        if logLevel != .debug {
            notify(AppLogData(level: logLevel, message: message))
        }
        #endif
    }
}

#if DEBUG
private extension AppLog {
    static let bundleName: String = {
        guard let bundleName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String else {
            fatalError()
        }
        return bundleName
    }()

    static let timestampDateformatter: DateFormatter = {
        let lastUpdateDateFormatter = DateFormatter()
        lastUpdateDateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss.SSSZ"
        return lastUpdateDateFormatter
    }()

    static func createLogText(logLevel: Level, tags: [String], message: String) -> String {
        let prefix: String = {
            let timestamp = timestampDateformatter.string(from: Date())
            let processId = Int(getpid())
            let threadNumber = Int(pthread_mach_thread_np(pthread_self()))
            return "\(timestamp) \(bundleName)[\(processId):\(threadNumber)]"
        }()
        let tagsFormatted = logLevel.header + tags.map { "[\($0)]" }.joined()
        return "\(prefix) \(tagsFormatted) \(message)"
    }

    static func notify(_ logData: AppLogData) {
        let center = NotificationCenter.default
        let notification = Notification(name: Notification.Name.Debug.AppLogNotification, object: logData, userInfo: nil)
        center.post(notification)
    }
}

extension Notification.Name {
    enum Debug {
        static let AppLogNotification = Notification.Name("debug.appLogNotification")
    }
}
#endif
