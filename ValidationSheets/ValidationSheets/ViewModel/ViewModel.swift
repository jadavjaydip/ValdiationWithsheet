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
    
    
}
