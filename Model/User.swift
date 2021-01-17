//
//  UserModel.swift
//  POSdan
//
//  Created by Dannover Arroyave on 2/01/21.
//
class User {
    
    var uid: String
    var email: String?
    var emailVerified: Bool
    var userName: String?
    var userAlertInfo: String?
    
    init(uid: String, email: String?, emailVerified: Bool, userName: String?,  userAlertInfo: String?) {
        self.uid = uid
        self.email = email
        self.emailVerified = emailVerified
        self.userName = userName
        self.userAlertInfo = userAlertInfo
    }
}
