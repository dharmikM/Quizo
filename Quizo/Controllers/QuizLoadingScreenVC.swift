//
//  QuizLoadingScreenVC.swift
//  Quizo
//
//  Created by D M on 2022-10-27.
//

import UIKit
import Combine

class QuizLoadingScreenVC: UIViewController {
    
    //MARK: Outlets
    //------------
    @IBOutlet weak var loadingAnimation: UIActivityIndicatorView!
    @IBOutlet weak var loadingText: UILabel!
    
    //MARK: Properties
    //------------
    private var counter = Timer()
    private var progressCounter:Float = 0.0
    private var recievedQuestions:[ResultsList] = [ResultsList]()
    private let questionFetcher = QuestionFetcher.getInstance()
    var selectedDifficulty = ""
    private var cancellables : Set<AnyCancellable> = []
    private var databaseHelper = DBHelper.getInstance()
    private var questionCount = 0

    
    private func getQuestionsData(){
        self.questionFetcher.$questionList.receive(on: RunLoop.main).sink{(updatedQuestionObjects) in
            self.recievedQuestions.removeAll()
            self.recievedQuestions.append(contentsOf: updatedQuestionObjects)
            self.storeQuestionCoreData()
        }
        .store(in: &cancellables)
    }
    
    
    private func storeQuestionCoreData(){
        for quizData in recievedQuestions {
            questionCount += 1
            let question = quizData.question
            let correctAnswer = quizData.correct_answer
            let incorrectAnswers = quizData.incorrect_answers
            
            databaseHelper.insertQuestionsData(questionID: Int64(questionCount), question: question, correctAnswer: correctAnswer, incorrectAnswers: incorrectAnswers)
        }
        
    }
    
    func loadQuestionAnswerData(){
        self.databaseHelper.deleteQuestionData()
        self.questionFetcher.getQuestionFromAPI(userSelectedLevel: self.selectedDifficulty)
        getQuestionsData()
        
        
        counter = Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true, block: { (counter) in
            self.progressCounter += 0.01
            if self.progressCounter >= 0.5 {
                self.loadingText.text = "Your quiz will be ready in a few seconds ,get ready for the challenge 📚"
            }
            if self.progressCounter >= 1.0 {
                counter.invalidate()

                guard let toQuestionScreen = self.storyboard?.instantiateViewController(withIdentifier: "QuizScreenVC") as? QuizScreenVC else {
                    print("Quiz screen is not found")
                    return

                }

                self.navigationController?.pushViewController(toQuestionScreen, animated: true)
            }
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.loadQuestionAnswerData()
    }

}
