//
//  HabitCreater.swift
//  LifeTrackApp
//
//  Created by Steve Personal on 16/08/2016.
//  Copyright © 2016 Steve Sandbach. All rights reserved.
//

import Foundation
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}




class answer: NSObject, NSCoding {
    var score: Int
    
    var wordage: String
    
    let bonusValue: Int
    
    init (scoreForAnswer score: Int , andWording wordage: String) {
        self.score = score
        self.wordage = wordage
        self.bonusValue = 0
    }
    
    struct PropertyKey {
        static let ScoreKey = "score"
        static let WordageKey = "wordage"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let score = aDecoder.decodeObject(forKey: "score") as! Int
        let wordage = aDecoder.decodeObject(forKey: "wordage") as! String
        self.init(
            scoreForAnswer: score,
            andWording: wordage
        )
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(score, forKey: PropertyKey.ScoreKey)
        aCoder.encode(wordage, forKey: PropertyKey.WordageKey)
    }
}

class log: NSObject, NSCoding {
    
    //How important is this task or chapter?
    var importance: Int
    
    //the length of the current streak
    var streak: Int
    
    //whether or not the streak is of success or failures
    var currentSuccess: Bool
    
    //how many days have been logged in the history of this habit
    var daysLogged: Int
    
    //Dictionary of current averages for this object
    var currentScores = [String : Int]()
    
    //is this chapter or task currently in use?
    var active: Bool
        
    //set current success and current streak
    func updateStreak () {
        if self.currentScores["Default"] >= 100 && self.currentSuccess || self.currentScores["Default"] < 100 && self.currentSuccess != true  {
            self.streak += 1
        } else {
            self.streak = 1
            if self.currentScores["Default"] >= 100 {
                self.currentSuccess = true
            } else {
                self.currentSuccess = false
            }
        }
    }
    
    func findAverage (_ lowValues: [Int], midValues: [Int], highValues: [Int]) -> Int {

        //var added: Int = 0
        var totalScore: Int = 0
        let arrays = [lowValues, midValues, highValues]
        if arrays.count > 0  {
//            var valueCount: Int = 0
//            var arrayCount: Int = 0
        
//            while arrayCount < arrays.count {
//                while valueCount < arrays[arrayCount].count {
//                    score += (arrays[arrayCount][valueCount] * (arrayCount + 1))
//                    added += arrayCount + 1
//                    valueCount += 1
//                }
//                valueCount = 0
//                arrayCount += 1
//            }
            var weight = 1
            var count = 0
            for scoreSet in arrays {
                for score in scoreSet {
                    totalScore += score * weight
                    count += weight
                }
                weight += 1
            }
            
            let avgScore: Int = totalScore/count
            return avgScore
        } else {
            return 0
        }
    }
    
    func taskStart (_ currentPerformance: Int) {
        self.currentScores["Default"] = currentPerformance
        self.currentScores["Week"] = currentPerformance
        self.currentScores["Fortnight"] = currentPerformance
        self.currentScores["Month"] = currentPerformance
        if (currentPerformance > 100) {
            self.currentSuccess = true
        } else {
            self.currentSuccess = false
        }
        self.streak = 0
        self.daysLogged = 0
        self.active = true
    }
    
    init ( importance: Int, streak: Int, currentSuccess: Bool,  daysLogged: Int, active: Bool ) {
        self.importance = importance
        self.streak = streak
        self.currentSuccess = currentSuccess
        self.daysLogged = daysLogged
        self.active = active
    }
    
    struct PropertyKey {
        static let ImportanceKey = "importance"
        static let StreakKey = "streak"
        static let CurrentSuccessKey = "currentSuccess"
        static let DaysLoggedKey = "daysLogged"
        static let CurrentScoresKey = "currentScores"
        static let ActiveKey = "active"
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let importance = aDecoder.decodeObject(forKey: "importance") as! Int
        let streak = aDecoder.decodeObject(forKey: "streak") as! Int
        let currentSuccess = aDecoder.decodeObject(forKey: "currentSuccess") as! Bool
        let daysLogged = aDecoder.decodeObject(forKey: "daysLogged") as! Int
        let currentScores = aDecoder.decodeObject(forKey: "currentScores") as! [String: Int]
        let active = aDecoder.decodeObject(forKey: "active") as! Bool
        self.init(
            importance: importance,
            streak: streak,
            currentSuccess: currentSuccess,
            daysLogged: daysLogged,
            active: active
        )
        self.currentScores = currentScores
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(importance, forKey: PropertyKey.ImportanceKey)
        aCoder.encode(streak, forKey: PropertyKey.StreakKey)
        aCoder.encode(currentSuccess, forKey: PropertyKey.CurrentSuccessKey)
        aCoder.encode(daysLogged, forKey: PropertyKey.DaysLoggedKey)
        aCoder.encode(currentScores, forKey: PropertyKey.CurrentScoresKey)
        aCoder.encode(active, forKey: PropertyKey.ActiveKey)
        //aCoder.encodeObject(importance, forKey: PropertyKey.ImportanceKey)
    }
};

class habit: log {
    
    //id of habit - make this count of myHabits + 1
    var id: Int
    
    //basic title of the habit
    let title: String
    
    //the highest ammount of points scored that is feasibly possible
    let top: Int
    
    //the question to ask the user each day
    let question: String
    
    //the average ammoutn of points that make a success
    let average: Int
    
    //the number of days that the average for this task should be taken from by default
    let range: Int
    
    //Is the default range smart or not?
    let smart: Bool
    
    //the list of answers for this particular question
    var answers: [answer]
    
    //which chapter does this task fall under?
    var chapter: Int
    
//    //the importance of this habit relative to other habits in this chapter
//    var importance: Int
    
    //a log of current scores for this habit
    var history: [Int]
    
    //not vital - a string of reasons why this task should be done
    var reasons: [String]
    
    //set's all averages under currentScore dictionary when called
    func setAverages () {
        self.currentScores["Default"] = self.requestAverage(range, smart: self.smart)
        self.currentScores["Week"] = self.requestAverage(7, smart: false)
        self.currentScores["Fortnight"] = self.requestAverage(14, smart: false)
        self.currentScores["Month"] = self.requestAverage(31, smart: false)
        self.currentScores["SmartWeek"] = self.requestAverage(7, smart: true)
        self.currentScores["SmartFortnight"] = self.requestAverage(14, smart: true)
        self.currentScores["SmartMonth"] = self.requestAverage(31, smart: true)
    }
    
    //handles smart and non-smart average requests when the setAverages function is called
    func requestAverage (_ days : Int , smart: Bool) -> Int {
        if smart {
            let arraySize: Int = days / 3
            var low: [Int] = []
            var mid: [Int] = []
            var high: [Int] = []
            var day = 0
            var count = 0
            while count < arraySize {
                high += [self.history[day]]
                count += 1
                day += 1
            }
            count = 0
            
            while count < arraySize {
                mid += [history[day]]
                count += 1
                day += 1
            }
            count = 0
            
            //as this calls days it may logless or more, depending on how the given 'days' divides by 3
            while day < days {
                low += [history[day]]
                day += 1
            }
            
            let smartAverage = findAverage(low, midValues: mid, highValues: high)
            return smartAverage
        } else {
            var day = 0
            var scores: [Int] = []
            while day < days {
                scores += [history[day]]
                day += 1
            }
            return findAverage(scores, midValues: [], highValues: [])
        }
    }
    
    //adds to history and deltes old entries
    func logScore (_ log: Int) {

        self.history.insert(log, at: 0)
        while (self.history.count > 31) {
            self.history.removeLast()
        }
    }
    
    //function to be calledwhenever user adds a new score
    func addScore (_ value: Int) {

        self.logScore(value)

        self.setAverages()
        
        self.updateStreak()
        self.daysLogged += 1
    }
    
    func setUp (_ currentPerformance: Int) {
        //fill out history
        while self.history.count < 31 {
            self.history.append(currentPerformance)
        }
        self.setAverages()
    }
    
    init(id: Int, basicTitle title: String, question: String, answers: [answer], top: Int, average: Int, range: Int,  smart: Bool, currentSuccess: Bool, streak: Int, daysLogged: Int, chapter: Int, importance: Int, history: [Int], reasons: [String], active: Bool ) {
        
        self.id = id
        self.title = title
        self.question = question
        self.answers = answers
        self.top = top
        self.chapter = chapter
        self.smart = smart
        self.range = range
        self.average = average
        self.history = history
        self.reasons = reasons
        super.init(importance: importance, streak: streak, currentSuccess: currentSuccess,  daysLogged: daysLogged, active: active )

        //add to habits set
    }
    
    struct PropertyKey {
        static let IdKey = "id"
        static let TitleKey = "title"
        static let QuestionKey = "question"
        static let AnswersKey = "answers"
        static let TopKey = "top"
        static let ChapterKey = "chapter"
        static let SmartKey = "smart"
        static let RangeKey = "range"
        static let AverageKey = "average"
        static let HistoryKey =  "history"
        static let ReasonsKey = "reasons"
        static let DaysLogged = "daysLogged"
        static let Importance = "importance"
        static let Reasons = "reasons"
        static let Active = "active"
        static let Streak = "streak"
        
        
        //log level properties
        //static let StreakKey = "streak"
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        
        //let importance = decoder.decodeObjectForKey("importance") as! Int
        let id = aDecoder.decodeObject(forKey: "id") as! Int
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let question = aDecoder.decodeObject(forKey: "question") as! String
        let answers = aDecoder.decodeObject(forKey: "answers") as! [ answer ]
        let top = aDecoder.decodeObject(forKey: "top") as! Int
        let chapter = aDecoder.decodeObject(forKey: "chapter") as! Int
        let smart = aDecoder.decodeObject(forKey: "smart") as! Bool
        let range = aDecoder.decodeObject(forKey: "range") as! Int
        let average = aDecoder.decodeObject(forKey: "average") as! Int
        let currentSuccess = aDecoder.decodeObject(forKey: "daysLogged") as! Bool
        let streak = aDecoder.decodeObject(forKey: "streak") as! Int
        let history = aDecoder.decodeObject(forKey: "history") as! [ Int ]
        let reasons = aDecoder.decodeObject(forKey: "reasons") as! [ String ]
        let daysLogged = aDecoder.decodeObject(forKey: "daysLogged") as! Int
        let importance = aDecoder.decodeObject(forKey: "importance") as! Int
        let active = aDecoder.decodeObject(forKey: "active") as! Bool
        
        self.init(id: id, basicTitle: title, question: question, answers: answers, top: top, average: average, range: range,  smart: smart, currentSuccess: currentSuccess, streak: streak, daysLogged: daysLogged, chapter: chapter, importance: importance, history: history, reasons: reasons, active: active)
        
        self.setAverages()
        //self.init()
        
        //log level things...
//        let importance = decoder.decodeObjectForKey("importance") as! Int
//        let streak = decoder.decodeObjectForKey("streak") as! Int
//        let currentSuccess = decoder.decodeObjectForKey("currentSuccess") as! Bool
//        let daysLogged = decoder.decodeObjectForKey("daysLogged") as! Int
//        let currentScores = decoder.decodeObjectForKey("currentScores") as! [String: Int]
//        let active = decoder.decodeObjectForKey("active") as! Bool
//        self.init(
//            id: id,
//            title: title,
//            question: question,
//            answers: answers,
//            top: top,
//            chapter: chapter,
//            smart: smart,
//            range: range,
//            average: average,
//            history: history,
//            reasons: reasons,
//            
//            importance: importance,
//            streak: streak,
//            currentSuccess: currentSuccess,
//            daysLogged: daysLogged,
//            currentScores: currentScores,
//            active: active
//        )
            fatalError("init(coder:) has not been implemented")
    }
    
    override func encode(with aCoder: NSCoder) {
        
        super.encode(with: aCoder)
        
        aCoder.encode(id, forKey: PropertyKey.IdKey)
        aCoder.encode(title, forKey: PropertyKey.TitleKey)
        aCoder.encode(question, forKey: PropertyKey.QuestionKey)
        aCoder.encode(answers, forKey: PropertyKey.AnswersKey)
        aCoder.encode(top, forKey: PropertyKey.TopKey)
        aCoder.encode(chapter, forKey: PropertyKey.ChapterKey)
        aCoder.encode(smart, forKey: PropertyKey.SmartKey)
        aCoder.encode(range, forKey: PropertyKey.RangeKey)
        aCoder.encode(average, forKey: PropertyKey.AverageKey)
        aCoder.encode(history, forKey: PropertyKey.HistoryKey)
        aCoder.encode(reasons, forKey: PropertyKey.ReasonsKey)
        aCoder.encode(daysLogged, forKey: PropertyKey.DaysLogged)
        aCoder.encode(importance, forKey: PropertyKey.Importance)
        aCoder.encode(streak, forKey: PropertyKey.Streak)
        aCoder.encode(reasons, forKey: PropertyKey.Reasons)
        aCoder.encode(active, forKey: PropertyKey.Active)
        
        //aCoder.encodeObject(streak, forKey: PropertyKey.StreakKey)
    }
    
    //Create unique name for set
    override var hashValue: Int {
        get {
            return id.hashValue << 15 + title.hashValue
        }
    }
}

func ==(lhs: habit, rhs: habit) -> Bool {
    return lhs.id == rhs.id && lhs.title == rhs.title
}

//BELOW WORKS WEHN UNCOMMENTED BUT WON'T LOG
//class chapter {
//    
//    var active: BooleanType
//    var title: String
//    
//    var habits: [habit]
//    
//    var currentScores = [String: Int]()
//    
//    //var daysLogged: Int
//    
//    func getScores () {
//        print("Getting scores for ", self.habits.count, " habits")
//        self.currentScores["Default"] = self.requestAverage(stringOfRange: "Default", children: habits)
//        self.currentScores["Week"] = self.requestAverage(stringOfRange: "Week", children: habits)
//        self.currentScores["Fortnight"] = self.requestAverage(stringOfRange: "Fortnight", children: habits)
//        self.currentScores["Month"] = self.requestAverage(stringOfRange: "Month", children: habits)
//        self.currentScores["SmartWeek"] = self.requestAverage(stringOfRange: "SmartWeek", children: habits)
//        self.currentScores["SmartFortnight"] = self.requestAverage(stringOfRange: "SmartFortnight", children: habits)
//        self.currentScores["SmartMonth"] = self.requestAverage(stringOfRange: "SmartMonth", children: habits)
//        print("habits set complete, Defaukt is ", self.currentScores["Default"])
//    }
//    func requestAverage (stringOfRange period : String, children: [log]) -> Int {
//
//        var low: [Int] = []
//        var mid: [Int] = []
//        var high: [Int] = []
//        
//        for child in children {
//            if child.importance == 1 {
//                low.append(child.currentScores[period]!)
//            } else if child.importance == 2 {
//                mid.append(child.currentScores[period]!)
//            } else {
//                high.append(child.currentScores[period]!)
//            }
//        }
//        print("About to get average of children")
//        let smartAverage : Int = findAverage(low, midValues: mid, highValues: high)
//        return smartAverage
//    }
//
//    func findAverage (lowValues: [Int], midValues: [Int], highValues: [Int]) -> Int {
//        
//        var added: Int = 0
//        var score: Int = 0
//        var arrays = [lowValues, midValues, highValues]
//        if arrays.count > 0 {
//            var valueCount: Int = 0
//            var arrayCount: Int = 0
//            
//            while arrayCount < arrays.count {
//                while valueCount < arrays[arrayCount].count {
//                    score += (arrays[arrayCount][valueCount] * (arrayCount + 1))
//                    added += arrayCount + 1
//                    valueCount += 1
//                }
//                valueCount = 0
//                arrayCount += 1
//            }
//            
//            let avgScore: Int = score/added
//            print("About to return ", avgScore)
//            return avgScore
//        } else {
//            return 0
//        }
//    }
//    
//    init (title: String) {
//        self.title = title
//        self.habits = []
//        self.currentScores = ["Default": 0]
//        self.active = true
//    }
//}
//
//
//


//class master {
//    var title: String
//    
//    var chapters: [chapter]
//    
//    var currentScores = [String: Int]()
//    
//    //var daysLogged: Int
//    
//    func getScores () {
//        self.currentScores["Default"] = self.requestAverage(stringOfRange: "Default", children: chapters)
//        self.currentScores["Week"] = self.requestAverage(stringOfRange: "Week", children: chapters)
//        self.currentScores["Fortnight"] = self.requestAverage(stringOfRange: "Fortnight", children: chapters)
//        self.currentScores["Month"] = self.requestAverage(stringOfRange: "Month", children: chapters)
//        self.currentScores["SmartWeek"] = self.requestAverage(stringOfRange: "SmartWeek", children: chapters)
//        self.currentScores["SmartFortnight"] = self.requestAverage(stringOfRange: "SmartFortnight", children: chapters)
//        self.currentScores["SmartMonth"] = self.requestAverage(stringOfRange: "SmartMonth", children: chapters)
//    }
//    func requestAverage (stringOfRange period : String, children: [chapter]) -> Int {
//        
//        var low: [Int] = []
//        var mid: [Int] = []
//        var high: [Int] = []
//        
//        for child in children {
//
//            mid.append(child.currentScores[period]!)
//
//        }
//        
//        let smartAverage : Int = findAverage(low, midValues: mid, highValues: high)
//        return smartAverage
//    }
//    
//    func findAverage (lowValues: [Int], midValues: [Int], highValues: [Int]) -> Int {
//        
//        var added: Int = 0
//        var score: Int = 0
//        var arrays = [lowValues, midValues, highValues]
//        if arrays.count == 0 {
//            var valueCount: Int = 0
//            var arrayCount: Int = 0
//            
//            while arrayCount < arrays.count {
//                while valueCount < arrays[arrayCount].count {
//                    score += (arrays[arrayCount][valueCount] * (arrayCount + 1))
//                    added += arrayCount + 1
//                    valueCount += 1
//                }
//                valueCount = 0
//                arrayCount += 1
//            }
//            
//            let avgScore: Int = score/added
//            return avgScore
//        } else {
//            return 0
//        }
//    }
//    
//    init (title: String) {
//        self.title = title
//        self.chapters = []
//        self.currentScores = ["Default": 111]
//    }
//    
//}

class owner: log {

    var children: [log]

    func requestAverage (stringOfRange period : String, children: [log]) -> Int {

        var low: [Int] = []
        var mid: [Int] = []
        var high: [Int] = []

        for child in children {
            if child.importance == 1 {
                low.append(child.currentScores[period]!)
            } else if child.importance == 2 {
                mid.append(child.currentScores[period]!)
            } else {
                high.append(child.currentScores[period]!)
            }
        }

        let smartAverage = findAverage(low, midValues: mid, highValues: high)
        return smartAverage
    }

//    func addScore () {
//        self.setAverages()
//        self.updateStreak()
//        self.daysLogged += 1
//    }

//    //function to be calledwhenever user adds a new score
//    func addScore (value: Int) {
//        self.logScore(value)
//        self.setAverages()
//        self.updateStreak()
//        self.daysLogged += 1
//    }

    //set's all averages under currentScore dictionary when called


    override init ( importance: Int, streak: Int, currentSuccess: Bool,  daysLogged: Int, active: Bool ) {
        self.children = []

        super.init(importance: importance, streak: streak, currentSuccess: currentSuccess, daysLogged: daysLogged, active: active )
    }

    struct PropertyKey {
        static let ChildrenKey = "children"
    }

    required convenience init(coder decoder: NSCoder) {

        //let children = decoder.decodeObjectForKey("children") as! [log]

        self.init( importance: 8, streak: 9, currentSuccess: true,  daysLogged: 2, active: true)
        fatalError("init(coder:) has not been implemented")
    }

    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)

        aCoder.encode(children, forKey: PropertyKey.ChildrenKey)
    }
}


 //Mark: Chapter
class chapter: owner {
    var habits: [habit]
    
    var id: Int
    
    var title: String
    
    //gets the average for this chater, taking into accont importances. Expects "Week" "Fortnight" "SmartMonth" etc. to be passed.
    
    //function to be called whenever user adds a new score

    func getHabits() {
        if usersHabits != nil {
            for habit in usersHabits! {
                if habit.chapter == self.id {
                    self.habits.append(habit)
                    print("Adding ", habit.title, " to chapter ", self.title)
                }
            }
        }
    }
    
    init(id: Int, basicTitle title: String, importance: Int, streak: Int, currentSuccess: Bool,  daysLogged: Int, active: Bool)
    {
        self.habits = []
        self.id = id
        self.title = title
        
        super.init(importance: importance, streak: streak, currentSuccess: currentSuccess,  daysLogged: daysLogged, active: active)

        getHabits()
        self.setAverages()
    }
    
    struct PropertyKey {
        static let IdKey = "id"
        static let TitleKey = "title"
        static let Importance = "importance"
        static let Streak = "streak"
        static let CurrentSuccess = "currentSuccess"
        static let DaysLogged = "daysLogged"
        static let Active = "active"
    }
    
    required convenience init (coder decoder: NSCoder) {
        let id = decoder.decodeObject(forKey: "id") as! Int
        let title = decoder.decodeObject(forKey: "title") as! String
        let importance = decoder.decodeObject(forKey: "importance") as! Int
        let streak = decoder.decodeObject(forKey: "streak") as! Int
        let currentSuccess = decoder.decodeObject(forKey: "currentSuccess") as! Bool
        let daysLogged = decoder.decodeObject(forKey: "daysLogged") as! Int
        let active = decoder.decodeObject(forKey: "active") as! Bool
        
        
        self.init(id: id, basicTitle: title, importance: importance, streak: streak, currentSuccess: currentSuccess, daysLogged: daysLogged, active: active)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(id, forKey: PropertyKey.IdKey)
        aCoder.encode(title, forKey: PropertyKey.TitleKey)
        aCoder.encode(importance, forKey: PropertyKey.Importance)
        aCoder.encode(streak, forKey: PropertyKey.Streak)
        aCoder.encode(currentSuccess, forKey: PropertyKey.CurrentSuccess)
        aCoder.encode(daysLogged, forKey: PropertyKey.DaysLogged)
        aCoder.encode(active, forKey: PropertyKey.Active)
    }
    
    func setAverages () {
        self.currentScores["Default"] = self.requestAverage(stringOfRange: "Default", children: self.habits)
        self.currentScores["Week"] = self.requestAverage(stringOfRange: "Week", children: self.habits)
        self.currentScores["Fortnight"] = self.requestAverage(stringOfRange: "Fortnight", children: self.habits)
        self.currentScores["Month"] = self.requestAverage(stringOfRange: "Month", children: self.habits)
        self.currentScores["SmartWeek"] = self.requestAverage(stringOfRange: "SmartWeek", children: self.habits)
        self.currentScores["SmartFortnight"] = self.requestAverage(stringOfRange: "SmartFortnight", children: self.habits)
        self.currentScores["SmartMonth"] = self.requestAverage(stringOfRange: "SmartMonth", children: self.habits)
    }
    
    func refresh() {
        if self.children.count > 0 {
            self.active = true
            self.setAverages()
            //self.owner.reresh()
        }
    }
    
    func addScore () {
        self.setAverages()
        self.updateStreak()
        self.daysLogged += 1
    }
}

class master: owner {
    var chapters: [chapter]
    
    var lastLogDate: Date?
    
    //gets the average for this chater, taking into accont importances. Expects "Week" "Fortnight" "SmartMonth" etc. to be passed.
    
    //function to be called whenever user adds a new score
    
    func getChapters() {
        if usersChapters != nil {
            for chapter in usersChapters! {
                print("Adding ", chapter.title, " to Master")
                self.chapters.append(chapter)
            }
        }
    }
    
    init(streak: Int, currentSuccess: Bool,  daysLogged: Int)
    {
        self.chapters = []
        
        super.init(importance: 1, streak: streak, currentSuccess: currentSuccess,  daysLogged: daysLogged, active: true)
        
        getChapters()
        self.setAverages()
        
    }
    
    struct PropertyKey {
        static let IdKey = "id"
        static let TitleKey = "title"
        static let Importance = "importance"
        static let Streak = "streak"
        static let CurrentSuccess = "currentSuccess"
        static let DaysLogged = "daysLogged"
        static let Active = "active"
        static let lastLogDate = "lastLogDate"
    }
    
    required convenience init (coder decoder: NSCoder) {
        let streak = decoder.decodeObject(forKey: "streak") as! Int
        let currentSuccess = decoder.decodeObject(forKey: "currentSuccess") as! Bool
        let daysLogged = decoder.decodeObject(forKey: "daysLogged") as! Int
        let lastLogDate = decoder.decodeObject(forKey: "lastLogDate") as! Date
        
        self.init(streak: streak, currentSuccess: currentSuccess, daysLogged: daysLogged)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(streak, forKey: PropertyKey.Streak)
        aCoder.encode(currentSuccess, forKey: PropertyKey.CurrentSuccess)
        aCoder.encode(daysLogged, forKey: PropertyKey.DaysLogged)
    }
    
    func setAverages () {
        self.currentScores["Default"] = self.requestAverage(stringOfRange: "Default", children: self.chapters)
        self.currentScores["Week"] = self.requestAverage(stringOfRange: "Week", children: self.chapters)
        self.currentScores["Fortnight"] = self.requestAverage(stringOfRange: "Fortnight", children: self.chapters)
        self.currentScores["Month"] = self.requestAverage(stringOfRange: "Month", children: self.chapters)
        self.currentScores["SmartWeek"] = self.requestAverage(stringOfRange: "SmartWeek", children: self.chapters)
        self.currentScores["SmartFortnight"] = self.requestAverage(stringOfRange: "SmartFortnight", children: self.chapters)
        self.currentScores["SmartMonth"] = self.requestAverage(stringOfRange: "SmartMonth", children: self.chapters)
        print("Month average is ", self.currentScores["Month"])
    }
    
    func refresh() {
        if self.children.count > 0 {
            self.active = true
            self.setAverages()
            //self.owner.reresh()
        }
    }
    
    func addScore () {
        self.setAverages()
        self.updateStreak()
        self.daysLogged += 1
    }
    
}



//class master: owner{
//    var chapters: [chapter]
//    
//    //var lifeScore: Int
//    
//    init( ){
//        self.chapters = []
//        super.init(importance: 1, streak: 0, currentSuccess: true,  daysLogged: 0, active: true)
//        for chapter in usersChapters! {
//            self.chapters.append(chapter)
//        }
//        self.addScore()
//    }
//    
//    struct PropertyKey {
//        static let ChaptersKey = "chapters"
//    }
//    
//    required convenience init(coder decoder: NSCoder) {
//        
//        let chapters = decoder.decodeObjectForKey("chapters") as! [chapter]
//        print("Master is initilising")
//        self.init()
//        
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func encodeWithCoder(aCoder: NSCoder) {
//        super.encodeWithCoder(aCoder)
//        
//        aCoder.encodeObject(chapters, forKey: PropertyKey.ChaptersKey)
//    }
//    
//    func setAverages () {
//        self.currentScores["Default"] = self.requestAverage(stringOfRange: "Default", children: self.chapters)
//        self.currentScores["Week"] = self.requestAverage(stringOfRange: "Week", children: self.chapters)
//        self.currentScores["Fortnight"] = self.requestAverage(stringOfRange: "Fortnight", children: self.chapters)
//        self.currentScores["Month"] = self.requestAverage(stringOfRange: "Month", children: self.chapters)
//        self.currentScores["SmartWeek"] = self.requestAverage(stringOfRange: "SmartWeek", children: self.chapters)
//        self.currentScores["SmartFortnight"] = self.requestAverage(stringOfRange: "SmartFortnight", children: self.chapters)
//        self.currentScores["SmartMonth"] = self.requestAverage(stringOfRange: "SmartMonth", children: self.chapters)
//    }
//    
//    func addScore () {
//        self.setAverages()
//        self.updateStreak()
//        self.daysLogged += 1
//    }
//}
