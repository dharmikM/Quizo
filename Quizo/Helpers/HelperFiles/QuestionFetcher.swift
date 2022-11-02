//
//  QuestionFetcher.swift
//  Quizo
//
//  Created by D M on 2022-10-26.
//

import Foundation


class QuestionFetcher: ObservableObject{
    var StandardApiURL = "https://opentdb.com/api.php"
    
    var levelSelectedApiURL = ""
    
    @Published var questionList = [ResultsList]()
    
    private static var shared : QuestionFetcher?
    
    static func getInstance() -> QuestionFetcher{
        if shared == nil{
            shared = QuestionFetcher()
        }
        return shared!
    }
    
    func getQuestionFromAPI(userSelectedLevel:String){
        
        levelSelectedApiURL = "\(StandardApiURL)?amount=10&difficulty=\(userSelectedLevel)&type=multiple"
                
        guard let apiCheck = URL(string: levelSelectedApiURL) else{
            print("Unable to get URL Value in String")
            return
        }
        
        URLSession.shared.dataTask(with: apiCheck){
            (data:Data?,response:URLResponse?,error:Error?) in
            
            if let error = error{
                print("Recived error is \(error)")
            }
            
            else{
                if let httpResponse = response as? HTTPURLResponse{
                    if httpResponse.statusCode == 200 {
                        DispatchQueue.global().async {
                            do{
                                if(data != nil){
                                    if let jsonData = data{
                                        
                                        let decoder = JSONDecoder()
                                        
                                        let decodedQuestionList = try decoder.decode(Questions.self, from: jsonData)
                                        let decodedQuestionListResults = decodedQuestionList.results
                                        
                                            DispatchQueue.main.async {
                                                self.questionList = decodedQuestionListResults
                                            }
                                            
                                    }
                                }
                            }catch let error{
                                print(error)
                            }
                        }
                    }else{
                        print("Unsuccessful request from network call")
                    }
                }
            }
        }.resume()
    }
}
