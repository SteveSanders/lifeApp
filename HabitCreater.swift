////
////  HabitCreater.swift
////  LifeTrackApp
////
////  Created by Steve Personal on 16/08/2016.
////  Copyright © 2016 Steve Sandbach. All rights reserved.
////
//
//import Foundation
//
//
//class answer {
//    let score: Int
//    
//    let wordage: String
//    
//    init (scoreForAnswer score: Int , andWording wordage: String) {
//        self.score = score
//        self.wordage = wordage
//    }
//}
//
//class habit: Equatable, Hashable {
//    
//    //id of habit - make this count of myHabits + 1
//    var id: Int
//    
//    //basic title of the habit
//    let title: String
//    
//    //the question to ask the user each day
//    let question: String
//    
//    //the list of answers for this particular question
//    let answers: [answer]
//    
//    //the highest ammount of points scored that is feasibly possible
//    let top: Int
//    
//    //the average ammount of points that is considerd a success
//    let average: Int
//    
//    //which chapter does this task fall under?
//    let chapter: Int
//    
//    //not vital - a string of reasons why this task should be done
//    let reasons: [String]
//    
//    //the number of days that the average for this task shoulkd be taken from
//    let range: Int
//    
//    //the length of the current streak
//    var streak: Int
//    
//    //whether or not the streak is of success or failures
//    var currentSuccess: DarwinBoolean
//    
//    //the importance of this task: 1-low 2-average 3-high
//    var importance: Int
//    
//    //the current score for suggested range - for ease of acces
//    //var currentScore: Int
//    
//    //a log of current scores for this habit
//    var history: [Int]
//    
//    //how many days have been logged in the history of this habit
//    var daysLogged: Int
//    
//    //Dictionary of current averages for this object
//    var currentScores = [String : Int]()
//    
//    func logScore (log: Int) {
//        self.history.insert(log, atIndex: 0)
//        while (self.history.count > 31) {
//            self.history.removeLast()
//        }
//        
//        //set all averages
//        self.daysLogged += 1
//        self.currentScores["Default"] = self.findAverage(howManyDays: self.range)
//        let week = self.findAverage(howManyDays: 7)
//        self.currentScores["Week"] = week
//        let fortNight = self.findAverage(howManyDays: 14)
//        self.currentScores["Fortnight"] = fortNight
//        let month = self.findAverage(howManyDays: 31)
//        self.currentScores["Month"] = month
//        
//        //set current success and current streak
//        if self.currentScores["Default"] >= self.average && self.currentSuccess || self.currentScores["Default"] < self.average && self.currentSuccess != true  {
//            self.streak += 1
//        } else {
//            self.streak = 1
//            if self.currentScores["Default"] >= self.average {
//                self.currentSuccess = true
//            } else {
//                self.currentSuccess = false
//            }
//        }
//        
//    }
//    
//    func findAverage (howManyDays days: Int) -> Int {
//        var sumScore: Int = 0
//        
//        var day: Int = 0
//        while (day < days) {
//            sumScore += self.history[day]
//            day += 1
//        }
//        
//        let avgScore = sumScore / days
//        return avgScore
//    }
//    
//    //Create unique name for set
//    var hashValue: Int {
//        get {
//            return id.hashValue << 15 + title.hashValue
//        }
//    }
//    
//    init (id: Int, basicTitle title: String, question: String, arrayOfAnswers answers: [answer],highestPointsPossible top: Int,successPoints average: Int, chapter: Int, rangeToJudgeBy range: Int, howWellDoYouDoCurrently currentPerformance: Int ) {
//        self.id = id
//        self.title = title
//        self.question = question
//        self.answers = answers
//        self.top = top
//        self.average = average
//        self.chapter = chapter
//        self.range = range
//        self.currentScores["Default"] = currentPerformance
//        self.currentScores["Week"] = currentPerformance
//        self.currentScores["Fortnight"] = currentPerformance
//        self.currentScores["Month"] = currentPerformance
//        if (currentPerformance > average) {
//            self.currentSuccess = true
//        } else {
//            self.currentSuccess = false
//        }
//        self.history = [ ]
//        self.reasons = ["To reach you target"]
//        self.streak = 0
//        self.daysLogged = 0
//        
//        
//        //fill out history
//        while self.history.count < 31 {
//            self.history.append(currentPerformance)
//        }
//        
//        //add to habits set
//        myHabits.insert(self)
//    }
//    
//
//};
//
////makes this object equatable for set
//func ==(lhs: habit, rhs: habit) -> Bool {
//    return lhs.id == rhs.id && lhs.title == rhs.title
//}
//
