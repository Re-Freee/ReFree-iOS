//
//  UIFont+Pretendard.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/14.
//

import UIKit

extension UIFont {
    static let pretendard = Pretendard()
    
    struct Pretendard {
        // Basic
        let basic8 = UIFont(name: PretendardStyle.basic.name, size: 8)
        let basic10 = UIFont(name: PretendardStyle.basic.name, size: 10)
        let basic12 = UIFont(name: PretendardStyle.basic.name, size: 12)
        let basic16 = UIFont(name: PretendardStyle.basic.name, size: 16)
        let basic18 = UIFont(name: PretendardStyle.basic.name, size: 18)
        let basic20 = UIFont(name: PretendardStyle.basic.name, size: 20)
        let basic22 = UIFont(name: PretendardStyle.basic.name, size: 22)
        let basic24 = UIFont(name: PretendardStyle.basic.name, size: 24)
        let basic30 = UIFont(name: PretendardStyle.basic.name, size: 30)
        
        // Bold
        let bold8 = UIFont(name: PretendardStyle.bold.name, size: 8)
        let bold10 = UIFont(name: PretendardStyle.bold.name, size: 10)
        let bold12 = UIFont(name: PretendardStyle.bold.name, size: 12)
        let bold15 = UIFont(name: PretendardStyle.bold.name, size: 15)
        let bold16 = UIFont(name: PretendardStyle.bold.name, size: 16)
        let bold18 = UIFont(name: PretendardStyle.bold.name, size: 18)
        let bold20 = UIFont(name: PretendardStyle.bold.name, size: 20)
        let bold22 = UIFont(name: PretendardStyle.bold.name, size: 22)
        let bold24 = UIFont(name: PretendardStyle.bold.name, size: 24)
        let bold30 = UIFont(name: PretendardStyle.bold.name, size: 30)
        
        // ExtraBold
        let extraBold8 = UIFont(name: PretendardStyle.extraBold.name, size: 8)
        let extraBold10 = UIFont(name: PretendardStyle.extraBold.name, size: 10)
        let extraBold12 = UIFont(name: PretendardStyle.extraBold.name, size: 12)
        let extraBold16 = UIFont(name: PretendardStyle.extraBold.name, size: 16)
        let extraBold18 = UIFont(name: PretendardStyle.extraBold.name, size: 18)
        let extraBold20 = UIFont(name: PretendardStyle.extraBold.name, size: 20)
        let extraBold22 = UIFont(name: PretendardStyle.extraBold.name, size: 22)
        let extraBold24 = UIFont(name: PretendardStyle.extraBold.name, size: 24)
        let extraBold30 = UIFont(name: PretendardStyle.extraBold.name, size: 30)
        
        // ExtraLight
        let extraLight8 = UIFont(name: PretendardStyle.extraLight.name, size: 8)
        let extraLight10 = UIFont(name: PretendardStyle.extraLight.name, size: 10)
        let extraLight12 = UIFont(name: PretendardStyle.extraLight.name, size: 12)
        let extraLight16 = UIFont(name: PretendardStyle.extraLight.name, size: 16)
        let extraLight18 = UIFont(name: PretendardStyle.extraLight.name, size: 18)
        let extraLight20 = UIFont(name: PretendardStyle.extraLight.name, size: 20)
        let extraLight22 = UIFont(name: PretendardStyle.extraLight.name, size: 22)
        let extraLight24 = UIFont(name: PretendardStyle.extraLight.name, size: 24)
    }
    
    enum PretendardStyle {
        case basic
        case bold
        case extraBold
        case extraLight
        
        var name: String {
            switch self {
            case .basic: return "Pretendard-Black"
            case .bold: return "Pretendard-Bold"
            case .extraBold: return "Pretendard-ExtraBold"
            case .extraLight: return "Pretendard-ExtraLight"
            }
        }
    }
}
