//
//  SurveyPointer.swift
//  YouTellMeApp
//
//  Created by Utphala on 7/16/17.
//  Copyright © 2017 Utphala. All rights reserved.
//

import Foundation

class SurveyPointer {
    let title:String
    let id: String
    
    init(surveyTitle title: String, surveyID id: String) {
        self.id = id
        self.title = title
    }
}
