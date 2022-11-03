//
//  QuizScreenVC.swift
//  Quizo
//
//  Created by D M on 2022-10-25.
//

import UIKit
import Foundation

class QuizScreenVC: UIViewController {
    
    //MARK: Outlets
    //------------
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var questionNumberText: UILabel!
    @IBOutlet weak var optionOneText: UIButton!
    @IBOutlet weak var optionThreeText: UIButton!
    @IBOutlet weak var optionTwoText: UIButton!
    @IBOutlet weak var optionFourText: UIButton!
    @IBOutlet weak var errorMessageText: UILabel!
    
    //MARK: Properties
    //------------
    private var recievedQuestions:[QuestionList] = [QuestionList]()
    private let databaseHelper = DBHelper.getInstance()
    private var questionNo = 0
    private var correctAnswer = ""
    private var selectedOption = ""
    var userScore = 0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        recievedQuestions.append(contentsOf: databaseHelper.getAllQuestionData()!)
        self.questionList()
        
    }
    

    func questionList(){
        questionNo += 1
        if questionNo == 11{
            let gameAlert = UIAlertController(title: "Thank You!", message: "Great work!, let's head to score page", preferredStyle: UIAlertController.Style.alert)
            
            gameAlert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: {_ in
                guard let toScoreScreen = self.storyboard?.instantiateViewController(withIdentifier: "ScoreScreenVC") as? ScoreScreenVC else {
                    print("Score screen is not found")
                    return
        
                }
        
                self.navigationController?.pushViewController(toScoreScreen, animated: true)
                toScoreScreen.userScore = self.userScore
            }))
            self.present(gameAlert, animated: true, completion: nil)
        }
        else{
            if let currentQuestionData = recievedQuestions.first(where: {$0.questionID == questionNo}){
            
                //HTML Code fix for Questions
                let fixedQuestionText = currentQuestionData.question!.replacingOccurrences(of: "&quot;",with: "“")
                let fixedQuestionTextOne = fixedQuestionText.replacingOccurrences(of: "&#039;",with: "'")
                let fixedQuestionTextTwo = fixedQuestionTextOne.replacingOccurrences(of: "&amp;",with: "&")
                let specialQuestionCheck = fixedQuestionTextTwo.folding(options: .diacriticInsensitive, locale: nil)

                
                //HTML Code fix for Correct Answers
                let fixedAnswerText = currentQuestionData.correctAnswer!.replacingOccurrences(of: "&quot;",with: "“")
                let fixedAnswerTextOne = fixedAnswerText.replacingOccurrences(of: "&#039;",with: "'")
                let fixedAnswerTextTwo = fixedAnswerTextOne.replacingOccurrences(of: "&amp;",with: "&")
                let specialAnswerCheck = fixedAnswerTextTwo.folding(options: .diacriticInsensitive, locale: nil)
                
                questionNumberText.text = "Question: \(currentQuestionData.questionID)"
                questionText.text = "\(specialQuestionCheck)"
                correctAnswer = specialAnswerCheck
                print(correctAnswer)
                let randomNumber = Int.random(in: 1...4)
                
                currentQuestionData.incorrectAnswers!.forEach{_ in
                    //HTML Code fix for Incorrect Answers
                    
                    //For First Incorrect Answers
                    let firstIncorrectAnswer = currentQuestionData.incorrectAnswers![0].replacingOccurrences(of: "&#039;",with: "'")
                    let firstIncorrectAnswerOne = firstIncorrectAnswer.replacingOccurrences(of: "&quot;",with: "”")
                    let firstIncorrectAnswerTwo = firstIncorrectAnswerOne.replacingOccurrences(of: "&amp;",with: "&")
                    let specialFirstIncorrectAnswer = firstIncorrectAnswerTwo.folding(options: .diacriticInsensitive, locale: nil)
                    
                    //For Second Incorrect Answers
                    let secondIncorrectAnswer = currentQuestionData.incorrectAnswers![1].replacingOccurrences(of: "&#039;",with: "'")
                    let secondIncorrectAnswerOne = secondIncorrectAnswer.replacingOccurrences(of: "&quot;",with: "”")
                    let secondIncorrectAnswerTwo = secondIncorrectAnswerOne.replacingOccurrences(of: "&amp;",with: "&")
                    let specialSecondIncorrectAnswer = secondIncorrectAnswerTwo.folding(options: .diacriticInsensitive, locale: nil)
                    
                    //For Third Incorrect Answers
                    let thirdIncorrectAnswer = currentQuestionData.incorrectAnswers![2].replacingOccurrences(of: "&#039;",with: "'")
                    let thirdIncorrectAnswerOne = thirdIncorrectAnswer.replacingOccurrences(of: "&quot;",with: "”")
                    let thirdIncorrectAnswerTwo = thirdIncorrectAnswerOne.replacingOccurrences(of: "&amp;",with: "&")
                    let specialThirdIncorrectAnswer = thirdIncorrectAnswerTwo.folding(options: .diacriticInsensitive, locale: nil)
                    
                    //As per the number selection from th random ,the options are showing
                    switch randomNumber {
                    case 1:
                        optionOneText.setTitle("\(correctAnswer)",for: .normal)
                        currentQuestionData.incorrectAnswers!.forEach{_ in
                            
                            optionTwoText.setTitle("\(specialFirstIncorrectAnswer)", for: .normal)
                            optionThreeText.setTitle("\(specialSecondIncorrectAnswer)", for: .normal)
                            optionFourText.setTitle("\(specialThirdIncorrectAnswer)", for: .normal)
                        }
                        
                        
                    case 2:
                        optionTwoText.setTitle("\(correctAnswer)",for: .normal)
                        currentQuestionData.incorrectAnswers!.forEach{_ in
                            
                            
                            optionOneText.setTitle("\(specialFirstIncorrectAnswer)", for: .normal)
                            optionThreeText.setTitle("\(specialSecondIncorrectAnswer)", for: .normal)
                            optionFourText.setTitle("\(specialThirdIncorrectAnswer)", for: .normal)
                        }
                    case 3:
                        optionThreeText.setTitle("\(correctAnswer)",for: .normal)
                        currentQuestionData.incorrectAnswers!.forEach{_ in
                            
                            
                            optionOneText.setTitle("\(specialFirstIncorrectAnswer)", for: .normal)
                            optionTwoText.setTitle("\(specialSecondIncorrectAnswer)", for: .normal)
                            optionFourText.setTitle("\(specialThirdIncorrectAnswer)", for: .normal)
                        }
                    case 4:
                        optionFourText.setTitle("\(correctAnswer)",for: .normal)
                        currentQuestionData.incorrectAnswers!.forEach{_ in
                            
                            optionOneText.setTitle("\(specialFirstIncorrectAnswer)", for: .normal)
                            optionTwoText.setTitle("\(specialSecondIncorrectAnswer)", for: .normal)
                            optionThreeText.setTitle("\(specialThirdIncorrectAnswer)", for: .normal)
                        }
                    default:
                        print("Printing in default")
                    }
                }
                
                
                
            }
        }
       

    }

    
    func answerCheck(answerSelected:String){
        errorMessageText.text = "" 
        
            if correctAnswer == answerSelected{
                errorMessageText.text = "Selected Answer is Correct!! 🎉"
                errorMessageText.textColor = UIColor(named: "LightGreenColor")
                selectedOption = ""
                userScore += 1
            }
            else{
                errorMessageText.text = "Selected Answer is Incorrect!! "
                errorMessageText.textColor = UIColor(named: "RedColor")
                selectedOption = ""
            }
        
        self.questionList()

    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.questionList()
    }

    //MARK: Action
    //------------
    
    @IBAction func optionOneButton(_ sender: Any) {
        selectedOption = "\(optionOneText.currentTitle!)"
        self.answerCheck(answerSelected: optionOneText.currentTitle!)
    }
    
    @IBAction func optionTwoButton(_ sender: Any) {
        selectedOption = "\(optionTwoText.currentTitle!)"
        self.answerCheck(answerSelected: optionTwoText.currentTitle!)

    }
    
    @IBAction func optionThreeButton(_ sender: Any) {
        selectedOption = "\(optionThreeText.currentTitle!)"
        self.answerCheck(answerSelected: optionThreeText.currentTitle!)

    }
    
    @IBAction func optionFourButton(_ sender: Any) {
        selectedOption = "\(optionFourText.currentTitle!)"
        self.answerCheck(answerSelected: optionFourText.currentTitle!)
        

    }
    
    
    
    @IBAction func nextQuestionButton(_ sender: Any) {
        if selectedOption == "" {
            errorMessageText.text = "Please select a answer to continue"
            errorMessageText.textColor = UIColor(named: "WhiteColor")
        }
    }
    
    
    @IBAction func finishButton(_ sender: Any) {
        
        
        let finishAlert = UIAlertController(title: "Do you want to finish the Game ?", message: "We have some interesting question lined up", preferredStyle: UIAlertController.Style.alert)
        
        finishAlert.addAction(UIAlertAction(title: "Finish", style: UIAlertAction.Style.default, handler: {_ in
            guard let toLevelSelectorScreen = self.storyboard?.instantiateViewController(withIdentifier: "LevelSelectorVC") as? LevelSelectorVC else {
                print("Level Selector screen is not found")
                return
    
            }
    
            self.navigationController?.pushViewController(toLevelSelectorScreen, animated: true)
        }))
        finishAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(finishAlert, animated: true, completion: nil)
        

    }
    
}
