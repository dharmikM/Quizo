//
//  DBHelper.swift
//  Quizo
//
//  Created by D M on 2022-10-27.
//

import Foundation
import CoreData
import UIKit


class DBHelper {
    private static var shared : DBHelper?
    private let managedObjContext: NSManagedObjectContext
    
    
    static func getInstance() -> DBHelper{
        
        if shared == nil {
            shared = DBHelper(context:(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        }
        
        
        return shared!
    }
    
    
    private init(context: NSManagedObjectContext){
        self.managedObjContext = context
    }
    
    
    func insertQuestionsData(question:String,correctAnswer:String, incorrectAnswers:[String]){
        do{
            
            let questionsData = NSEntityDescription.insertNewObject(forEntityName: "QuestionList", into: self.managedObjContext) as! QuestionList
            
            questionsData.question = question
            questionsData.correctAnswer = correctAnswer
            questionsData.incorrectAnswers = incorrectAnswers as NSObject
            
            
            if self.managedObjContext.hasChanges{
                try self.managedObjContext.save()
                print("Data stored successfully")
            }
            
        }catch let error as NSError{
            print("Could not save the data, Please try again \(error)")
        }
    }
    
    func getAllQuestionData() -> [QuestionList]?{
        let fetchRequest = NSFetchRequest<QuestionList>(entityName: "QuestionList")
        
        do{
            
            let listOfQuestions = try self.managedObjContext.fetch(fetchRequest)
            print("Fetched Data: \(listOfQuestions as [QuestionList])")
            
        }catch let error as NSError{
            print("Could not fetch the data \(error)")
        }
        
        return nil
    }
    
    func deleteQuestionData(){
    }
}
