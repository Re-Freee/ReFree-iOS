//
//  Identifiable.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/11.
//

import Foundation

protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String { return "\(self)" }
}
