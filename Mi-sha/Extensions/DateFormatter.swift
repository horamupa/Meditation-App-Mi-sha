//
//  DateFormatter.swift
//  Mi-sha
//
//  Created by MM on 11.12.2022.
//

import SwiftUI

extension DateComponentsFormatter {
    static var abbreviated: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour,.minute,.second]
        formatter.unitsStyle = .abbreviated
        return formatter
    }
    
    static var positional: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute,.second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }
}

