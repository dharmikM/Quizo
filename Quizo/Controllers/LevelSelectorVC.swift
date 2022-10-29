//
//  ViewController.swift
//  Quizo
//
//  Created by D M on 2022-10-25.
//

import UIKit

class LevelSelectorVC: UIViewController {

    //MARK: Label
    //------------
    @IBOutlet weak var quizLevelText: UILabel!
    
    //MARK: Properties
    //------------
    private var levelSelected = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizLevelText.center = view.center
        quizLevelText.font = UIFont(name: "Comfortaa-Bold", size: 42)
        
    
    }

    
    //MARK: Action
    //------------

    @IBAction func easyButton(_ sender: Any) {
        levelSelected = "easy"

        guard let toProgressScreen = storyboard?.instantiateViewController(withIdentifier: "QuizLoadingScreenVC") as? QuizLoadingScreenVC else {
            print("Quiz Loading screen is not found")
            return

        }

        self.navigationController?.pushViewController(toProgressScreen, animated: true)
        toProgressScreen.selectedDifficulty = levelSelected

        
    }
    
    
    @IBAction func mediumButtton(_ sender: Any) {
        levelSelected = "medium"
        
        guard let toProgressScreen = storyboard?.instantiateViewController(withIdentifier: "QuizLoadingScreenVC") as? QuizLoadingScreenVC else {
            print("Quiz Loading screen is not found")
            return

        }

        self.navigationController?.pushViewController(toProgressScreen, animated: true)
        toProgressScreen.selectedDifficulty = levelSelected

    }
    
    
    @IBAction func hardButton(_ sender: Any) {
        levelSelected = "hard"
        
        guard let toProgressScreen = storyboard?.instantiateViewController(withIdentifier: "QuizLoadingScreenVC") as? QuizLoadingScreenVC else {
            print("Quiz Loading screen is not found")
            return

        }

        self.navigationController?.pushViewController(toProgressScreen, animated: true)
        toProgressScreen.selectedDifficulty = levelSelected


    }
    
    
    @IBAction func infoButton(_ sender: Any) {

        guard let toAboutScreen = storyboard?.instantiateViewController(withIdentifier: "aboutScreenVC") else {
            print("About screen is not found")
            return

        }

        self.navigationController?.pushViewController(toAboutScreen, animated: true)
        
    }
    
}

