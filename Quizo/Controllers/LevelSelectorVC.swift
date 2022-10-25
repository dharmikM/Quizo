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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizLevelText.center = view.center
        quizLevelText.font = UIFont(name: "Comfortaa-Bold", size: 42)
        
    
    }

    
    //MARK: Action
    //------------

    @IBAction func easyButton(_ sender: Any) {
        print("easy button")

        
    }
    
    
    @IBAction func mediumButtton(_ sender: Any) {
        print("medium button")

    }
    
    
    @IBAction func hardButton(_ sender: Any) {
        print("hard button")

    }
    
    
    @IBAction func infoButton(_ sender: Any) {
        print("info button")

        
        guard let toAboutScreen = storyboard?.instantiateViewController(withIdentifier: "aboutScreenVC") else {
            print("About screen is not found")
            return

        }

        self.navigationController?.pushViewController(toAboutScreen, animated: true)
        
    }
    
}

