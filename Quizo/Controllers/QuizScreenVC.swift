//
//  QuizScreenVC.swift
//  Quizo
//
//  Created by D M on 2022-10-25.
//

import UIKit

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
    private var incorrectAnswerArray = [String]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        recievedQuestions.append(contentsOf: databaseHelper.getAllQuestionData()!)
        for question in recievedQuestions {
            print(question.question!)
            incorrectAnswerArray.append(contentsOf: question.incorrectAnswers!)
        }
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
                questionNumberText.text = "Question: \(currentQuestionData.questionID)"
                questionText.text = "\(currentQuestionData.question!)"
                correctAnswer = currentQuestionData.correctAnswer!
                let randomNumber = Int.random(in: 1...4)
                
                switch randomNumber {
                case 1:
                    optionOneText.setTitle("\(currentQuestionData.correctAnswer!)",for: .normal)
                    currentQuestionData.incorrectAnswers!.forEach{_ in
                        optionTwoText.setTitle("\(currentQuestionData.incorrectAnswers![0])", for: .normal)
                        optionThreeText.setTitle("\(currentQuestionData.incorrectAnswers![1])", for: .normal)
                        optionFourText.setTitle("\(currentQuestionData.incorrectAnswers![2])", for: .normal)
                    }
                    
                    
                case 2:
                    optionTwoText.setTitle("\(currentQuestionData.correctAnswer!)",for: .normal)
                    currentQuestionData.incorrectAnswers!.forEach{_ in
                        optionOneText.setTitle("\(currentQuestionData.incorrectAnswers![0])", for: .normal)
                        optionThreeText.setTitle("\(currentQuestionData.incorrectAnswers![1])", for: .normal)
                        optionFourText.setTitle("\(currentQuestionData.incorrectAnswers![2])", for: .normal)
                    }
                case 3:
                    optionThreeText.setTitle("\(currentQuestionData.correctAnswer!)",for: .normal)
                    currentQuestionData.incorrectAnswers!.forEach{_ in
                        optionOneText.setTitle("\(currentQuestionData.incorrectAnswers![0])", for: .normal)
                        optionTwoText.setTitle("\(currentQuestionData.incorrectAnswers![1])", for: .normal)
                        optionFourText.setTitle("\(currentQuestionData.incorrectAnswers![2])", for: .normal)
                    }
                case 4:
                    optionFourText.setTitle("\(currentQuestionData.correctAnswer!)",for: .normal)
                    currentQuestionData.incorrectAnswers!.forEach{_ in
                        optionOneText.setTitle("\(currentQuestionData.incorrectAnswers![0])", for: .normal)
                        optionTwoText.setTitle("\(currentQuestionData.incorrectAnswers![1])", for: .normal)
                        optionThreeText.setTitle("\(currentQuestionData.incorrectAnswers![2])", for: .normal)
                    }
                default:
                    print("Printing in default")
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
        print(optionOneText.currentTitle!)
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
