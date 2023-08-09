//
//  ValidationCheck.swift
//  ReFree
//
//  Created by 김형석 on 2023/08/08.
//

import Foundation

extension String {
    func validateEmail() -> Bool {
        let emailRegEx1 = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{3}"
        let emailRegEx2 = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2}+\\.[A-Za-z]{2}"
        
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx1).evaluate(with: self) || NSPredicate(format: "SELF MATCHES %@", emailRegEx2).evaluate(with: self)
    }
    
    func validateVerificationCode() -> Bool {
        // TODO: 인증코드 자리수에 맞춰 아래 정규식 수정
        let verificationCodeRegEx = "[A-Z0-9]{9}"
        
        return NSPredicate(format: "SELF MATCHES %@", verificationCodeRegEx).evaluate(with: self)
    }
    
    func validatePassword() -> Bool {
        let passwordRegEx = "[A-Z0-9a-z._%+-]{8,}"
        
        return NSPredicate(format: "SELF MATCHES %@", passwordRegEx).evaluate(with: self)
    }
}
