//
//  SurveyQuestions.swift
//  YouTellMeApp
//
//  Created by Utphala on 7/16/17.
//  Copyright © 2017 Utphala. All rights reserved.
//
// https://stackoverflow.com/questions/25621120/simple-and-clean-way-to-convert-json-string-to-object-in-swift

import Foundation

class SurveyQuestions {
    var title : String = ""
    var surveyID = ""
    var questions = [Question]()
    
    // Constructor to take raw data and convert/deserialize into SurveyQuestions object.
    init(json jsonData : Data) {
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: []) as! [String:Any]
        self.title = (dict!["Title"] as AnyObject? as? String) ?? ""
        let queDicts = (dict!["questions"] as AnyObject? as? NSArray) ?? NSArray()
        for optQueDict in queDicts {
            let temp = (optQueDict as? NSDictionary) ?? nil
            if temp == nil {
                continue
            }
            let queDict = temp!
            let que = String(describing: queDict["question"]!)
            let opt1 = String(describing: queDict["opt1"]!)
            let opt2 = String(describing: queDict["opt2"]!)
            let opt3 = String(describing: queDict["opt3"]!)
            let opt4 = String(describing: queDict["opt4"]!)
            self.questions.append(Question(question: que, opt1: opt1, opt2: opt2, opt3: opt3, opt4: opt4))
            print("Got: \(title), \(opt1) \(opt2) \(opt3) \(opt4)")
        }
    }
    
    init() {
        // Make xcode happy
    }
}
