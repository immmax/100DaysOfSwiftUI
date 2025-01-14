//
//  ContentViewModel.swift
//  Edutainment
//
//  Created by Maxim Datskiy on 4/21/24.
//

import Foundation
import Observation

@Observable class ContentViewModel {
    var showingAlert = false
    
    var alertTitle = ""
    var alertMessage = ""
    
    var score = 0
    var questions = [String]()
}
