//
//  API.swift
//  TriviaMaster
//
//  Created by Mixalis Dobekidis on 21/12/20.
//

import Foundation
import Alamofire
import SwiftUI
import SDWebImage
import SDWebImageSVGCoder
import SDWebImageSwiftUI


class API: APIHandler,ObservableObject {
    static let shared = API()
    
    let baseURL: String = "https://opentdb.com/api.php?amount=10&type=multiple&"
    // category=9 general
    // category=11 film
    // category=12 music
    // category=14 tv
    // category=17 science
    // category=22 geography
    // category=23 history
    // category=26 celebrity
    // category=21 sports
    // category=20 mythology
    
    @Published var Question: Question?
    @Published var isLoading = false
    
    enum QuestionCategories: String {
        case GENERAL="category=9"
        case FILM="category=11"
        case MUSIC="category=12"
        case TV="category=14"
        case SCIENCE="category=17"
        case GEOGRAPHY="category=22"
        case HISTORY="category=23"
        case CELEBRITY="category=26"
        case SPORTS="category=21"
        case MYTHOLOGY="category=20"
        case COMPUTER="category=18"
        
        func printURLPart() -> String {
            return self.rawValue
        }
    }
    
    let dispatchGroup = DispatchGroup()
    
    @Published var generalQuestions:Array<Question> = []
    @Published var filmQuestions:Array<Question> = []
    @Published var musicQuestions:Array<Question> = []
    @Published var tvQuestions:Array<Question> = []
    @Published var scienceQuestions:Array<Question> = []
    @Published var geographyQuestions:Array<Question> = []
    @Published var historyQuestions:Array<Question> = []
    @Published var celebrityQuestions:Array<Question> = []
    @Published var mythologyQuestions:Array<Question> = []
    @Published var computerQuestions:Array<Question> = []
    @Published var sportsQuestions:Array<Question> = []
    @Published var categories:Dictionary<String, Array<Question>> = [:]
    
    func handleDataParsing(data:DBResponse, type:QuestionCategories) {
        
        // adding the correct answer in the incorrect ones, then shuffling it a bit!
        data.results?.forEach() { question in
            if let correct = question.correct_answer {
                question.incorrect_answers?.append(correct)
                question.incorrect_answers?.shuffle()
            }
        }
    
        if type == .GENERAL {
            self.generalQuestions = data.results ?? []
            self.categories["general"] = self.generalQuestions
        }
        else if type == .FILM {
            self.filmQuestions = data.results ?? []
            self.categories["film"] = self.filmQuestions
        }
        else if type == .GEOGRAPHY {
            self.geographyQuestions = data.results ?? []
            self.categories["geography"] = self.geographyQuestions
        }
        else if type == .HISTORY {
            self.historyQuestions = data.results ?? []
            self.categories["history"] = self.historyQuestions
        }
        else if type == .MUSIC {
            self.musicQuestions = data.results ?? []
            self.categories["music"] = self.musicQuestions
        }
        else if type == .MYTHOLOGY {
            self.mythologyQuestions = data.results ?? []
            self.categories["mythology"] = self.mythologyQuestions
        }
        else if type == .COMPUTER {
            self.computerQuestions = data.results ?? []
            self.categories["computer"] = self.computerQuestions
        }
        else if type == .SCIENCE {
            self.scienceQuestions = data.results ?? []
            self.categories["science"] = self.scienceQuestions
        }
        else if type == .SPORTS {
            self.sportsQuestions = data.results ?? []
            self.categories["sports"] = self.sportsQuestions
        }
        else if type == .TV {
            self.tvQuestions = data.results ?? []
            self.categories["tv"] = self.tvQuestions
        }
        else if type == .CELEBRITY {
            self.celebrityQuestions = data.results ?? []
            self.categories["celebrity"] = self.celebrityQuestions
        }
    }
    
    func getQuestions(type:QuestionCategories) {
        //&difficulty=easy
        let url = baseURL+type.rawValue+"&difficulty=\(User.shared.getDifficulty())"
        print(url)
        AF.request(url, method: .get).responseDecodable { [weak self] (response: DataResponse<DBResponse,AFError>) in
            if let _response = response.value {
                if let _questions = _response.results {
                    // debug
//                    for item in _questions {
//                        print(item.type)
//                    }
                }
                else {
                    return
                }
            }
            else {
                return
            }
            guard let questionsArr = self?.handleResponse(response) as? DBResponse else {
                self?.dispatchGroup.leave()
                return
            }
            
            self?.handleDataParsing(data: questionsArr, type: type)
            self?.dispatchGroup.leave()
        }
    }
    
    func getGeneralQuestions() {
        self.getQuestions(type: .GENERAL)
    }
    
    func getFilmQuestions() {
        self.getQuestions(type: .FILM)
    }
    
    func getMusicQuestions() {
        self.getQuestions(type: .MUSIC)
    }
    
    func getTVQuestions() {
        self.getQuestions(type: .TV)
    }
    
    func getScienceQuestions() {
        self.getQuestions(type: .SCIENCE)
    }
    
    func getGeographyQuestions() {
        self.getQuestions(type: .GEOGRAPHY)
    }
    
    func getHistoryQuestions() {
        self.getQuestions(type: .HISTORY)
    }
    
    func getCelebrityQuestions() {
        self.getQuestions(type: .CELEBRITY)
    }
    
    func getSportsQuestions() {
        self.getQuestions(type: .SPORTS)
    }
    
    func getMythologyQuestions() {
        self.getQuestions(type: .MYTHOLOGY)
    }
    
    func getComputerQuestions() {
        self.getQuestions(type: .COMPUTER)
    }
    
    func shuffleQuestions(forCategory:String) {
        self.categories[forCategory]?.shuffle()
    }
    
    func getAll() {
        self.isLoading = true
        
        self.getGeneralQuestions()
        dispatchGroup.enter()
        self.getTVQuestions()
        dispatchGroup.enter()
        self.getMusicQuestions()
        dispatchGroup.enter()
        self.getFilmQuestions()
        dispatchGroup.enter()
        self.getSportsQuestions()
        dispatchGroup.enter()
        self.getGeographyQuestions()
        dispatchGroup.enter()
        self.getScienceQuestions()
        dispatchGroup.enter()
        self.getHistoryQuestions()
        dispatchGroup.enter()
        self.getCelebrityQuestions()
        dispatchGroup.enter()
        self.getComputerQuestions()
        //self.getMythologyQuestions()
        dispatchGroup.enter()
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.isLoading = false
        }
        
        self.categories = [
            "general": generalQuestions,
            "film": filmQuestions,
            "tv": tvQuestions,
            "music": musicQuestions,
            "sports": sportsQuestions,
            "geography": geographyQuestions,
            "science": scienceQuestions,
            "history": historyQuestions,
            "celebrity": celebrityQuestions,
            "computer": computerQuestions
            //"mythology": mythologyQuestions
        ]
    }
    
    // Prevent non singleton access.
    private override init(){
        super.init()
        self.categories = [
            "general": generalQuestions,
            "film": filmQuestions,
            "tv": tvQuestions,
            "music": musicQuestions,
            "sports": sportsQuestions,
            "geography": geographyQuestions,
            "science": scienceQuestions,
            "history": historyQuestions,
            "celebrity": celebrityQuestions,
            "computer": computerQuestions
            //"mythology": mythologyQuestions
        ]
    }
}


struct question: Identifiable {
    
    var id: String
    var category: String
    var type: String
    var difficulty: String
    var question: String
    var correctAnswer: String
    var questions: [String]
}
