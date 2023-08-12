//
//  UserRepository.swift
//  ReFree
//
//  Created by 이주훈 on 2023/08/13.
//

import Foundation

struct UserRepository {
    enum UserRepositoryKey {
        static let userNickName = "userNickName"
    }
    
    func getUserNickName() -> String? {
        return UserDefaults.standard.string(forKey: UserRepositoryKey.userNickName)
    }
    
    func setUserNickName(nickName: String) {
        deleteUserNickName()
        UserDefaults.standard.set(nickName, forKey: UserRepositoryKey.userNickName)
    }
    
    func deleteUserNickName() {
        UserDefaults.standard.removeObject(forKey: UserRepositoryKey.userNickName)
    }
}
