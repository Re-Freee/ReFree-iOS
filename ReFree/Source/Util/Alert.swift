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
        viewController.addsubViewToWindow(view: alert)
    }
    
    static func errorAlert(
        viewController: UIViewController,
        errorMessage: String
    ) {
        let alert = AlertView(
            title: "오류!",
            description: errorMessage,
            alertType: .check
        )
        viewController.addsubViewToWindow(view: alert)
    }
    
    static func checkAlert(
        targetView: UIView,
        title: String,
        message: String
    ) {
        let alert = AlertView(
            title: title,
            description: message,
            alertType: .check
        )
        targetView.addsubViewToWindow(view: alert)
    }
    
    static func errorAlert(
        targetView: UIView,
        errorMessage: String
    ) {
        let alert = AlertView(
            title: "오류!",
            description: errorMessage,
            alertType: .check
        )
        targetView.addsubViewToWindow(view: alert)
    }
}
