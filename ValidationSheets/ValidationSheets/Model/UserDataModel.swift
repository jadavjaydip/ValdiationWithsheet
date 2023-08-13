//
//  UserDataModel.swift
//  ValidationSheets
//
//  Created by J  on 13/08/23.
//

import Foundation

//MARK: UserData Model
struct UserDataModel {
    let id: String = UUID().uuidString
    let type: UserValidationCrips
    var isSelected: Bool = false
}

//MARK: UserValidatonRuls
enum UserValidationRuls: String, CaseIterable {
    
    case atleastOneLowerCase = "(?=.*[a-z])"
    case atleastOneNumber = "(?=.*[0-9])"
    case length = "/^.{8,26}$/"
    case repeatRestriction = "([a-zA-Z0-9])\\1{1,}"
    case passUserNameMatch = ""
        
    
}

//MARK: UserValidationCrips
enum UserValidationCrips: String, CaseIterable {
    
    case atleastOneLowerCase = "Use at least 1 lowercase character"
    case atleastOneNumber = "Use at least 1 numeric character"
    case length = "Between 8 & 20 characters"
    case repeatRestriction = "Same number"
    //case passwordMatchusername = "Password should not match with username"
    case validated
    
    static var cripList: [String] {
        return UserValidationCrips.allCases.map({$0.rawValue})
    }

}

//MARK: CaseInterable Extention
extension CaseIterable where Self: Equatable {
    public func origin() -> Self.AllCases.Index {
        return Self.allCases.firstIndex(of:self)!
    }
}
