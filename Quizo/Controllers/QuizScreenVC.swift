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
    
    
    //MARK: Properties
    //------------
    private var recievedQuestions:[ResultsList] = [ResultsList]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        print("\(self.recievedQuestions) new")

    }
    



}
