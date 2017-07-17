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
    var responses: [Int] = []
    
    @IBOutlet var questionbox: UILabel!
    @IBOutlet var buttonOpt1: UIButton!
    @IBOutlet var buttonOpt2: UIButton!
    @IBOutlet var buttonOpt3: UIButton!
    @IBOutlet var buttonOpt4: UIButton!

    func getSurveyData() {
        BackendServiceClient().getSurveyQuestions(surveyID: surveyID, notificationCallback: {question, isSuccess in
            if isSuccess {
                self.surveyQuestion = question;
                self.surveyQuestion.surveyID = self.surveyID
                DispatchQueue.main.async {
                    // Update UI in main thread and not in background callback thread.
                    self.nextQuestion()
                }
            } else {
                // Failed
                DispatchQueue.main.async {
                    self.concludeSurvey(message: "Sorry, failed to pull survey data, please retry later", btnMsg: "Exit!")
                }
            }
        })
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
            concludeSurvey(message: "There are no questions available for this survey! Strange! Please retry later.", btnMsg: "Exit!")
            return
        }

        if questionIndex >= self.surveyQuestion.questions.count {
            concludeSurvey(message: "Done with all the questions! Thanks for your time.", btnMsg: "Submit!")
            questionIndex = questionIndex + 1
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
        responses += [1]
        nextQuestion()
    }

    @IBAction func button2Press(_ sender: Any) {
        responses += [2]
        nextQuestion()
    }

    @IBAction func button3Press(_ sender: Any) {
        responses += [3]
        nextQuestion()
    }

    func submitResult() {
        BackendServiceClient().submitSurvey(surveyID: self.surveyQuestion.surveyID, responses: self.responses, callback: {isSuccess in
            if isSuccess {
                DispatchQueue.main.async {
                    self.concludeSurvey(message: "Successfully saved response! Thank you!", btnMsg: "Exit")
                    sleep(1)
                    self.performSegue(withIdentifier: "to_home_page", sender: "")
                }
                
            } else {
                DispatchQueue.main.async {
                    self.concludeSurvey(message: "Failed to save response! Please retry!", btnMsg: "Retry")
                }
            }
        })
        return;
    }

    @IBAction func button4Press(_ sender: Any) {
        if questionIndex > self.surveyQuestion.questions.count {
            submitResult()
            concludeSurvey(message: "Your responses saved! Thank you!", btnMsg: "Done!")
            return;
        }
        nextQuestion()
        if responses.count < self.surveyQuestion.questions.count {
            responses += [4]
        }
    }
    
    // Helper method to update the messaging to the user and buttons
    func concludeSurvey(message msg: String, btnMsg buttonMsg: String) {
        // Disable first 3 buttons
        for button in [buttonOpt1, buttonOpt2, buttonOpt3] {
            button!.isHidden = true;
        }
        // Change the last button to submit
        buttonOpt4.setTitle(buttonMsg, for: .normal)
        
        // Change text to appropriate message
        questionbox.text = msg
    }
}
