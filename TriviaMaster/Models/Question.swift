//
//  Question.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 28/12/20.
//

import Foundation

class Questions<T>: Decodable where T: Decodable {
    let data : [Question]

}

class DBResponse: Decodable {
    var response_code: Int?
    var results: [Question]?
    
    enum CodingKeys:String, CodingKey {
        case response_code = "response_code"
        case results = "results"
    }
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        response_code = try? container.decode(Int.self, forKey: .response_code)
        results = try? container.decode(Array<Question>.self, forKey: .results)
    }
}

class Question: Decodable {
    
    var category: String?
    var type: String?
    var difficulty: String?
    var question: String?
    var correct_answer: String?
    var incorrect_answers:Array<String>?
    
    enum CodingKeys: String, CodingKey {
        case category = "category"
        case type = "type"
        case difficulty = "difficulty"
        case question = "question"
        case correct_answer = "correct_answer"
        case incorrect_answers = "incorrect_answers"
    }
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        category = try? container.decode(String.self, forKey: .category)
        type = try? container.decode(String.self, forKey: .type)
        difficulty = try? container.decode(String.self, forKey: .difficulty)
        question = try? container.decode(String.self, forKey: .question)
        correct_answer = try? container.decode(String.self, forKey: .correct_answer)
        incorrect_answers = try? container.decode(Array<String>.self, forKey: .incorrect_answers)
    }
}
