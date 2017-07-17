//
//  ServiceClient.swift
//  YouTellMeApp
//
//  Created by Utphala on 7/16/17.
//  Copyright © 2017 Utphala. All rights reserved.
//

// Restclient to talk the backend service.
import Foundation

class BackendServiceClient {
    let HTTP_OK: Int = 200
    
    let ENDPOINT: String = "http://192.168.86.38:8081";
    let GET_SURVEY_API = "get_survey";
    let SUBMIT_RESPONSE_API = "submit_survey"
    let LIST_SURVEY_API = "list_surveys"

    func getSurveyQuestions(surveyID id : String, notificationCallback callback: @escaping (SurveyQuestions, Bool) -> Void) {
        let getSurveyURL: String = "\(ENDPOINT)/\(GET_SURVEY_API)/\(id)";
        print("Calling URL \(getSurveyURL)")
        guard let url = URL(string: getSurveyURL) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { data, response, error in
            do {
                let returnCode:HTTPURLResponse = (response! as? HTTPURLResponse) ?? HTTPURLResponse()
                
                if returnCode.statusCode == self.HTTP_OK {
                    let unwarpedData = data ?? Data()
                    let surveyQuestion: SurveyQuestions = SurveyQuestions(json: unwarpedData)
                    print("Survey Questions: \(surveyQuestion)")
                    // Callback and notify requester
                    callback(surveyQuestion, true)
                } else {
                    callback(SurveyQuestions(), false)
                }
            }
        }
        task.resume()
    }


    func submitSurvey(surveyID id: String, responses resp: [Int], callback: @escaping (Bool) -> Void ) {
        let submitSurveyURL:String = "\(ENDPOINT)/\(SUBMIT_RESPONSE_API)";
        var userResponse = [String:Any]()
        userResponse["surveyID"] = id
        userResponse["responses"] = resp
        do {
            let data = try? JSONSerialization.data(withJSONObject: userResponse, options: [])
            print("TO URL: \(submitSurveyURL)")
            print("Submitting data: \(data)")
            guard let url = URL(string: submitSurveyURL) else {
                print("Error: cannot create URL")
                return
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = data

            let session = URLSession.shared
            let task = session.dataTask(with: urlRequest) { data, response, error in
                let returnCode:HTTPURLResponse = (response! as? HTTPURLResponse) ?? HTTPURLResponse()
                print("Response code from service: \(returnCode.statusCode)")
                if returnCode.statusCode == self.HTTP_OK {
                    callback(true)
                } else {
                    callback(false)
                }
            }
            task.resume()
        }
    }
    
    func listSurveys(callback: @escaping([SurveyPointer], Bool) -> Void) {
        let listSurveyURL:String = "\(ENDPOINT)/\(LIST_SURVEY_API)";
        print("Calling URL \(listSurveyURL)")
        guard let url = URL(string: listSurveyURL) else {
            print("Error: cannot create URL")
            return
        }

        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { data, response, error in
            do {
                let returnCode:HTTPURLResponse = (response! as? HTTPURLResponse) ?? HTTPURLResponse()

                if returnCode.statusCode == self.HTTP_OK {
                    let unwarpedData = data ?? Data()
                    var surveyPointers: [SurveyPointer] = [SurveyPointer]()

                    let rawPointers = try? JSONSerialization.jsonObject(with: unwarpedData, options: []) as! [[String:String]]
                    print("\(rawPointers)")
                    let pointersList = rawPointers!
                    for lsurveyPtr in pointersList {
                        let id = lsurveyPtr["id"]!
                        let title = lsurveyPtr["title"]!
                        surveyPointers.append(SurveyPointer(surveyTitle: title, surveyID: id))
                    }
                    callback(surveyPointers, true)
                } else {
                    callback([SurveyPointer](), false)
                }
            } catch {
                print("Failed to get SurveyQuestion!")
            }
        }
        task.resume()
    }
    
}