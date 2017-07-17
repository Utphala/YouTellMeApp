//
//  SurveyResponse.swift
//  YouTellMeApp
//
//  Created by Utphala on 7/16/17.
//  Copyright © 2017 Utphala. All rights reserved.
//

import Foundation

class SurveyResponse {
    let surveyID: String
    let responses: [Int]
    
    init(surveyID id : String, responses resp: [Int]) {
        self.surveyID = id
        self.responses = resp
    }
}
