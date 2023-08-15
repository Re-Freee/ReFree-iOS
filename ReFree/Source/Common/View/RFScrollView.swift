//
//  RFScrollView.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/15.
//

import UIKit

final class RFScrollView: UIScrollView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        endEditing(true)
    }
}
