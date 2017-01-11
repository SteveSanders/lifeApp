//
//  LogScreenViewController.swift
//  LifeTrackApp
//
//  Created by Steve Personal on 27/10/2016.
//  Copyright © 2016 Steve Sandbach. All rights reserved.
//

import UIKit

class LogScreenViewController: UIViewController {
    @IBOutlet var LogScreen: UIView!
    
    @IBOutlet weak var finalReviewScreen: UIView!
    @IBOutlet weak var chapterScore: UILabel!
    @IBOutlet weak var habitScreen: UIView!
    @IBOutlet weak var chapterScreen: UIView!
    @IBOutlet weak var chapterTitle: UILabel!
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var taskTitle: UILabel!
    
    @IBOutlet weak var reviewScreen: UIView!

    
    @IBOutlet weak var reviewScoreCard: scoreCard!
    
    @IBOutlet weak var nextChapterButton: UIButton!
    @IBOutlet weak var buttonOne: UIButton!
    
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var buttonFive: UIButton!
    var buttons : [UIButton]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //chapterScreen.
        setHabits()
        
    }
    
    
    var habitsList: [habit]? = nil
    
    var habitsCount: Int = 0
    
    var currentChapter: Int = 0
    
    var currentHabitNumber: Int = 0
    
    var currentHabit: habit? = nil
    
    func setHabits () {
        finalReviewScreen.hidden = true
        //settings butons
        buttons = [buttonOne, buttonTwo, buttonThree, buttonFour, buttonFive]
        print(masterLog?.chapters.count)
        var habits: [habit] = []
        for chapter in (masterLog?.chapters)! {
            print("Looking at ", chapter.title, " which has ", chapter.habits.count, " habits")
            if chapter.active {
                for habit in chapter.habits {
                    if habit.active {
                        habits.append(habit)
                        print("Adding ", habit.title, " to queue.")
                    }
                }
            }
        }

        habitsCount = habits.count
        habitsList = habits
        currentHabit = habitsList![0]
        print("There are ", habitsCount, " to get through")
        loadHabit ()
    }
    
    func loadNext () {
        
        //currentHabit = usersHabits![currentHabitNumber]
        if chapterScreen.hidden {
            currentHabitNumber += 1
            print("Habit number increased - it is now ", currentHabitNumber, " out of ", habitsCount)
            if currentHabitNumber >= habitsCount {
                print("Loading chapter review here - final chapter")
                loadChapterReview()
                nextChapterButton.setTitle("Finish current log", forState: .Normal)
                return
            } else {
                print("loading a new habit")
                currentHabit = habitsList![currentHabitNumber]
                if currentHabit?.chapter != currentChapter {
                    print("habit is next chapter so loading chapter screen")
                    loadChapterReview()
                } else{
                    print("Same chapter, so loading next habit")
                    loadHabit()
                }
            }
        } else {
            print("Chapter screen was laoded")
            if currentHabitNumber == habitsCount {
                print("Loading final review screen.")
                loadReview()
            } else {
                print("first habit of new chapter")
                //currentHabitNumber += 1
                loadHabit()
                currentChapter += 1
                chapterTitle.text = usersChapters![currentChapter].title
                print("loading next chapter and habit. New chapter s ", usersChapters![currentChapter].title)
            }
        }
        
        
        //OLD BELOW
        
        
//        if(currentHabitNumber > habitsCount) {
//            currentHabitNumber = 0
//            loadReview()
//            return
//        } else {
//            //end of chapters
//            if currentHabitNumber == habitsCount {
//                print("Loading chapter review here")
//                loadChapterReview()
//                nextChapterButton.setTitle("Finish current log", forState: .Normal)
//                return
//            }
//        currentHabit = habitsList![currentHabitNumber]
//            if currentHabit?.chapter != currentChapter {
//                print("And here")
//                loadChapterReview()
//            } else {
//                loadHabit()
//            }
//        }
    }
    
    func loadChapterReview() {
        print(currentChapter)
        var chapter = usersChapters![currentChapter]
        chapter.addScore()
        chapterScore.text=chapter.currentScores["Default"]?.description
        //reviewScreen.hidden=false
        chapterScreen.hidden=false
        habitScreen.hidden=true
    }
    
    func loadHabit() {
        var currentButton = 0
        for button in buttons! {
            if currentButton < currentHabit!.answers.count {
                button.hidden = false
                button.setTitle(currentHabit!.answers[currentButton].wordage, forState: .Normal)
            } else {
                button.hidden = true
            }
            currentButton += 1
        }
        //buttonOne.setTitle(currentHabit!.answers[0].wordage, forState: .Normal)
        habitScreen.hidden = false
        
        //reviewScreen.hidden = true
        chapterScreen.hidden=true
        question.text=currentHabit?.question
        taskTitle.text=currentHabit?.title
    }
    
    func loadReview() {

        finalReviewScreen.hidden=false
        masterLog!.addScore()
        saveHabits(usersHabits!)
        reviewScoreCard.setScore((masterLog?.currentScores["Default"])!)
        lifeScore = masterLog?.currentScores["Default"]
    }
    
    func logAnswer (answer: Int) {
        var score = currentHabit?.answers[answer].score
        currentHabit?.addScore(score!)
        loadNext()
    }
    
    @IBAction func buttonOnePressed(sender: AnyObject) {
        logAnswer(0)
    }
    @IBAction func buttonTwoPressed(sender: AnyObject) {
        logAnswer(1)
    }
    @IBAction func buttonThreePressed(sender: AnyObject) {
        logAnswer(2)
    }
    
    @IBAction func buttonFourPressed(sender: AnyObject) {
        logAnswer(3)
    }
    @IBAction func buttonFivePressed(sender: AnyObject) {
        logAnswer(4)
    }
    @IBAction func lastChapterPressed(sender: AnyObject) {
        if(currentHabitNumber == habitsCount) {
            //currentHabitNumber = 0
            loadReview()
        } else {
            loadNext()
        }
    }
    
    func isTrue() -> Bool {
        return true
    }
}
