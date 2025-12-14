//
//  DateFormatter+API.swift
//  Calendar
//
//  Created by Bakhtovar Umarov on 12/13/25.
//

import Foundation

public extension DateFormatter {
    static let api: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        df.locale = Locale(identifier: "en_US_POSIX")
        return df
    }()
}
