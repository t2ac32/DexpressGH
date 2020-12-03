//
//  DoubleExtension.swift
//  DexpressGH
//
//  Created by Tracer on 28/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import Foundation

extension Double {
    func unitFormatted() -> String {
        if self >= 1000, self <= 999999 {
            return String(format: "%.1fk", locale: Locale.current, self/1000).replacingOccurrences(of: ".0", with: "")
        }
        if self >= 999999 {
            return String(format: "%.1fM", locale: Locale.current, self/1000000).replacingOccurrences(of: ".0", with: "")
        }
        return String(format: "%.0f", locale: Locale.current, self)
    }
}
