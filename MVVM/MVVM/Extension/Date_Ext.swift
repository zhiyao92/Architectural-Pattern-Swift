//
//  Date_Ext.swift
//  MVVM
//
//  Created by Kelvin Tan on 03/06/2021.
//

import Foundation

extension Date {
    public var formattedString: String? {
        let shortDateFormatter = DateFormatter()
        shortDateFormatter.timeZone = TimeZone.current
        shortDateFormatter.dateStyle = .medium
        return shortDateFormatter.string(from: self)
    }
}
