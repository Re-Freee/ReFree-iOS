//
//  Date+String.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/09.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: self)
    }
}

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        guard
            let date = dateFormatter.date(from: self)
        else {
            return Date()
        }
        return date
    }
}
