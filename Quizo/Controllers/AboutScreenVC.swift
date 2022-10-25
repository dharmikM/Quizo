//
//  AboutScreenVC.swift
//  Quizo
//
//  Created by D M on 2022-10-25.
//

import UIKit

class AboutScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Comfortaa-Bold", size: 20)!]
    }

}
