// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation

enum Localizable {
    /// There was an error. Please try again later.
    case errorTryAgainLater
}

extension Localizable : CustomStringConvertible {
    var description : String { return self.string }

    var string : String {
        switch self {
        case .errorTryAgainLater:
            return Localizable.tr(key: "ERROR_TRY_AGAIN_LATER")
        }
    }

    private static func tr(key: String, _ args: CVarArg...) -> String {
        let format = NSLocalizedString(key, comment: "")
        return String(format: format, arguments: args)
    }
}

func localizable(from key: Localizable) -> String {
    return key.string
}
