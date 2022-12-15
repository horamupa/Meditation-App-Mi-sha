import SwiftUI

extension Font {

    enum LabGrotesqueFont {
        case semibold
        case regular
        case bold
        case black
        case custom(String)
        case medium
        case thin

        var value: String {
            switch self {
            case .semibold:
                return "LabGrotesque-Medium"
            case .regular:
                return "LabGrotesque-Regular"
            case .bold:
                return "LabGrotesque-Bold"
            case .black:
                return "LabGrotesque-Black"
            case .medium:
                return "LabGrotesque-Medium"
            case .thin:
                return "LabGrotesque-Thin"

            case .custom(let name):
                return name
            }
        }
    }
    
    static func labGrotesque(_ type: LabGrotesqueFont, size: CGFloat = 26) -> Font {
        return .custom(type.value, size: size)
    }
    
    enum MeditationFont {
        case regular
        case bold
        case custom(String)
        case medium

        var value: String {
            switch self {
            case .regular:
                return "JekoRegular"
            case .bold:
                return "JekoBold"
            case .medium:
                return "JekoMedium"
            case .custom(let name):
                return name
            }
        }
    }
    
    static func meditation(_ type: MeditationFont, size: CGFloat = 26) -> Font {
        return .custom(type.value, size: size)
    }
}

