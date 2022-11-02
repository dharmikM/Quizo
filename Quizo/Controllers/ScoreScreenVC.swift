//
//  ScoreScreenVC.swift
//  Quizo
//
//  Created by D M on 2022-11-02.
//

import UIKit

class ScoreScreenVC: UIViewController {

    
    //MARK: Outlet
    //------------
    @IBOutlet weak var headerMessageText: UILabel!
    @IBOutlet weak var emojiShowText: UILabel!
    @IBOutlet weak var finalScoreShowText: UILabel!
    
    
    //MARK: Properties
    //------------
    var userScore = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        finalScoreShowText.text = "\(userScore)/10"
        if (userScore >= 8){
            emojiShowText.text = "🙌"
            headerMessageText.text = "Wow!!What a score"
        }
        else if (userScore >= 5 && userScore <= 7){
            emojiShowText.text = "🎉"
            headerMessageText.text = "Great!!"
        }
        else{
            emojiShowText.text = "👏"
            headerMessageText.text = "Cool!!"
        }
        
        
    }
    
    

    
    
    //MARK: Action
    //------------
    
    @IBAction func homeButton(_ sender: Any) {
        guard let toLevelSelectorScreen = self.storyboard?.instantiateViewController(withIdentifier: "LevelSelectorVC") as? LevelSelectorVC else {
            print("Level Selector screen is not found")
            return

        }

        self.navigationController?.pushViewController(toLevelSelectorScreen, animated: true)
    }
    
}
