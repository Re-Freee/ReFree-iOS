//
//  Alert.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/31.
//

import UIKit

enum Alert {
    static func checkAlert(
        viewController: UIViewController,
        title: String,
        message: String
    ) {
        let alert = AlertView(
            title: title,
            description: message,
            alertType: .check
        )
        viewController.view.addSubview(alert)
    }
    
    static func erroAlert(
        viewController: UIViewController,
        errorMessage: String
    ) {
        let alert = AlertView(
            title: "오류!",
            description: errorMessage,
            alertType: .check
        )
        viewController.view.addSubview(alert)
    }
}
