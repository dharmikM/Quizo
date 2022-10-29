//
//  Questions.swift
//  Quizo
//
//  Created by D M on 2022-10-26.
//

import Foundation

struct ResultsList:Decodable{
    let question:String
    let correct_answer:String
    let incorrect_answers:[String]
    
}

struct Questions:Decodable{
    
    let results:[ResultsList]
    
    enum quizKeys:CodingKey{
        
        enum resultsKeys:String,CodingKey{
            case results

        }
        
    }
    
    
    
    
    init(from decoder: Decoder) throws {
        let resultsContainer = try decoder.container(keyedBy: quizKeys.resultsKeys.self)
        self.results = try resultsContainer.decodeIfPresent([ResultsList].self, forKey: .results)!

    }

    
    func encode(to encoder: Encoder) throws{
        //
    }
}
