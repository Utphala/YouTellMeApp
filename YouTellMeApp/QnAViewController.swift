//
//  QnAViewController.swift
//  YouTellMeApp
//
//  Created by Utphala on 7/16/17.
//  Copyright © 2017 Utphala. All rights reserved.
//

import UIKit

class QnAViewController: UIViewController {
    var surveyID: String = "1"

    var questionIndex = 0
    var surveyQuestion: SurveyQuestions = SurveyQuestions()

    @IBOutlet var questionbox: UILabel!
    @IBOutlet var buttonOpt1: UIButton!
    @IBOutlet var buttonOpt2: UIButton!
    @IBOutlet var buttonOpt3: UIButton!
    @IBOutlet var buttonOpt4: UIButton!
    

    func getSurveyData() {
        let getSurveyURL: String = "http://192.168.86.19:8080/get_survey/\(surveyID)";
        print("Calling URL \(getSurveyURL)")
        guard let url = URL(string: getSurveyURL) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)

        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { data, response, error in
            do {
                
                let unwarpedData = data ?? Data()
                self.surveyQuestion = SurveyQuestions(json: unwarpedData)
                print("Survey Questions: \(self.surveyQuestion)")
                DispatchQueue.main.async {
                    self.nextQuestion()  // We load only once we have data
                }
            } catch {
                print("Failed to get SurveyQuestion!")
            }
        }
        task.resume()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        print("QnA is called!")
        getSurveyData()
        print("QnA received data!")
    }
    
    func nextQuestion() {
        if self.surveyQuestion.questions.isEmpty {
            // No questions were loaded - we could maybe retry- but will just notify user and quit
            questionbox.text = "There are no questions available for this survey! Strange! Please retry later."
            // Remove all buttons
            buttonOpt1.isHidden = true
            buttonOpt2.isHidden = true
            buttonOpt3.isHidden = true
            buttonOpt4.setTitle("Exit!", for: .normal)
            return
        }

        if questionIndex >= self.surveyQuestion.questions.count {
            questionbox.text = "Done with all the questions! Thanks for your time."
            // Remove all buttons
            buttonOpt1.isHidden = true
            buttonOpt2.isHidden = true
            buttonOpt3.isHidden = true
            buttonOpt4.setTitle("Submit!", for: .normal)
            return
        }
        print("Index: \(questionIndex)  and len: \(self.surveyQuestion.questions.count)")
        questionbox.text = self.surveyQuestion.questions[questionIndex].question
        
        buttonOpt1.setTitle(self.surveyQuestion.questions[questionIndex].option1, for: .normal)
        buttonOpt2.setTitle(self.surveyQuestion.questions[questionIndex].option2, for: .normal)
        buttonOpt3.setTitle(self.surveyQuestion.questions[questionIndex].option3, for: .normal)
        buttonOpt4.setTitle(self.surveyQuestion.questions[questionIndex].option4, for: .normal)
        questionIndex = questionIndex + 1
    }

    @IBAction func button1Press(_ sender: Any) {
        nextQuestion()
    }
    
    @IBAction func button2Press(_ sender: Any) {
        nextQuestion()
    }
    
    @IBAction func button3Press(_ sender: Any) {
        nextQuestion()
    }
    
    @IBAction func button4Press(_ sender: Any) {
        nextQuestion()
    }
    
}
