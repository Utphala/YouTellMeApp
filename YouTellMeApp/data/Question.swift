//
//  Question.swift
//  YouTellMeApp
//
//  Created by Utphala on 7/16/17.
//  Copyright © 2017 Utphala. All rights reserved.
//

import Foundation

class Question {
    let question: String
    let option1: String
    let option2: String
    let option3: String
    let option4: String
    
    init(question que: String, opt1 opt1 : String, opt2 opt2: String, opt3 opt3: String, opt4 opt4: String) {
        self.question = que
        self.option1 = opt1
        self.option2 = opt2
        self.option3 = opt3
        self.option4 = opt4
    }
}
