//
//  ViewModel.swift
//  ValidationSheets
//
//  Created by J  on 13/08/23.
//

import Foundation
import Combine

class ViewModel {
    
    @Published private(set) var userValidations = [UserDataModel]()
    
    @Published var userNameFiedl: String = ""
    var userNameAvailible: String = ""
    
    var userNameIsNotNil:AnyPublisher <Bool, Never> {
        $userNameFiedl
        .map({!$0.isEmpty})
        .eraseToAnyPublisher()
    }
    
    var isEnable: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($userNameFiedl, $userValidations)
            .map { (userName, validation) in
                return !userName.isEmpty && validation.allSatisfy({$0.isSelected})
            }
            .eraseToAnyPublisher()
    }
    
   
    init() {
        UserValidationCrips.allCases.filter({$0 != .validated}).forEach { validations in
            userValidations.append(UserDataModel(type: validations))
        }
        
    }
    
    func userNameValidation(userName: String) {
        var crips = [UserValidationCrips]()
        for ruls in UserValidationRuls.allCases {
            let reng = NSRange(location: 0, length: userName.count)
            let regex = try? NSRegularExpression(pattern: ruls.rawValue)
            if ruls == .length {
                if userName.count > 8 && userName.count < 20 {
                    crips.append(.length)
                }
            }
//            else if ruls == .passUserNameMatch {
//                if userName == userNameAvailible  && !userNameAvailible.isEmpty{
//                    crips.append(.passwordMatchusername)
//                }
//            }
            
           else if regex?.firstMatch(in: userName, range: reng) != nil {
                let dig = UserValidationCrips.cripList[ruls.origin()]
                crips.append(UserValidationCrips(rawValue: dig) ?? .validated)
            }
            self.userValidations = self.userValidations.compactMap({ validations in
                var userValida = validations
                if crips.contains(where: {$0 == validations.type}) {
                    userValida.isSelected = true
                }else {
                    userValida.isSelected = false
                }
                return userValida
            }).map({$0})
        }
    }
    
}
