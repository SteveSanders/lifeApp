//
//  createTasks.swift
//  LifeTrackApp
//
//  Created by Steve Personal on 05/01/2017.
//  Copyright © 2017 Steve Sandbach. All rights reserved.
//

import Foundation

func createHabits () -> [habit] {
   
    var habits: [habit] = []
    
    var current = 0
    habits.append(habit(id: current, basicTitle: "Diet", question: "How healthily did you eat today?", answers: [], top: 76, average: 45, range: 7, smart: true, currentSuccess: true, streak: 0, daysLogged: 0, chapter: 0, importance: 3, history: [], reasons: ["get slim like your name's 'Shady'!"], active: true))
    //habits.append(habit(id: current, basicTitle: "Diet", question: "How healthily did you eat today?", answers: [], top: 76, smart: true, range: 7, average: 45, chapter: 0, history: []))
    habits[current].answers.append(answer(scoreForAnswer: 0, andWording: "Unhealthy Day"))
    habits[current].answers.append(answer(scoreForAnswer: 50, andWording: "Average Day"))
    habits[current].answers.append(answer(scoreForAnswer: 100, andWording: "Healthy Day"))
    habits[current].setUp(50)
    current+=1
    habits.append(habit(id: current, basicTitle: "Exercise", question: "How much exercise did you do today?", answers: [], top: 75, average: 45, range: 10, smart: true, currentSuccess: true, streak: 0, daysLogged: 0, chapter: 0, importance: 3, history: [], reasons: ["get ripped like the Hulk", "win the world's strongest man competition"], active: true))
    habits[current].answers.append(answer(scoreForAnswer: 100, andWording: "Huge workout"))
    habits[current].answers.append(answer(scoreForAnswer: 80, andWording: "A good ammount"))
    habits[current].answers.append(answer(scoreForAnswer: 50, andWording: "A slight workout"))
    habits[current].answers.append(answer(scoreForAnswer: 0, andWording: "None"))
    habits[current].setUp(50)
    current+=1
    habits.append(habit(id: current, basicTitle: "Steps", question: "How many stepshave you taken today?", answers: [], top: 50, average: 40, range: 7, smart: false, currentSuccess: true, streak: 0, daysLogged: 0, chapter: 0, importance: 1, history: [], reasons: ["burn off some more cheeky calories"], active: true))
        //habits.append(habit(id: current, basicTitle: "Walking", question: "How much did you walk today?", answers: [], top: 50, smart: false, range: 7, average: 40, chapter: 0, history: [])),
    habits[current].answers.append(answer(scoreForAnswer: 100, andWording: "Long walk"))
    habits[current].answers.append(answer(scoreForAnswer: 40, andWording: "Dog Walk"))
    habits[current].answers.append(answer(scoreForAnswer: 0, andWording: "Barely"))
    habits[current].setUp(50)
    current+=1
    habits.append(habit(id: current, basicTitle: "Spending", question: "How much did you spend today?", answers: [], top: 50, average: 35, range: 14, smart: true, currentSuccess: true, streak: 0, daysLogged: 0, chapter: 1, importance: 2, history: [], reasons: ["become a self-made millionare playboy"], active: true))
        //habits.append(habit(id: current, basicTitle: "Spending", question: "How much did you spend today?", answers: [], top: 50, smart: true, range: 31, average: 35, chapter: 1, history: []))
    habits[current].answers.append(answer(scoreForAnswer: 100, andWording: "Free day!"))
    habits[current].answers.append(answer(scoreForAnswer: 80, andWording: "Less than £5"))
    habits[current].answers.append(answer(scoreForAnswer: 50, andWording: "Less than £10"))
    habits[current].answers.append(answer(scoreForAnswer: 15, andWording: "Less than £15"))
    habits[current].answers.append(answer(scoreForAnswer: 15, andWording: "More than £15"))
    habits[current].setUp(50)
    current+=1
    habits.append(habit(id: current, basicTitle: "Budget", question: "Are you within your budget for the month?", answers: [], top: 100, average: 80, range: 31, smart: false, currentSuccess: true, streak: 0, daysLogged: 0, chapter: 1, importance: 2, history: [], reasons: ["own a speed boat", "get a decent holiday this year", "own a home"], active: true))
    habits[current].answers.append(answer(scoreForAnswer: 100, andWording: "Yes"))
    habits[current].answers.append(answer(scoreForAnswer: 0, andWording: "No"))
    habits[current].setUp(50)
    current+=1
    habits.append(habit(id: current, basicTitle: "Police", question: "Did you do any work with the Police today?", answers: [], top: 57, average: 40, range: 14, smart: true, currentSuccess: true, streak: 0, daysLogged: 0, chapter: 2, importance: 2, history: [], reasons: ["become robocop"], active: true))
    habits[current].answers.append(answer(scoreForAnswer: 100, andWording: "Full duty"))
    habits[current].answers.append(answer(scoreForAnswer: 80, andWording: "Meeting at station"))
    habits[current].answers.append(answer(scoreForAnswer: 60, andWording: "Admin"))
    habits[current].answers.append(answer(scoreForAnswer: 20, andWording: "Checked Duty Sheet"))
    habits[current].answers.append(answer(scoreForAnswer: 0, andWording: "Nothing"))
    habits[current].setUp(50)
    current+=1
    habits.append(habit(id: current, basicTitle: "Good Deed", question: "Did you do a good deed today?", answers: [], top: 20, average: 10, range: 14, smart: false, currentSuccess: true, streak: 0, daysLogged: 0, chapter: 2, importance: 1, history: [], reasons: ["to give back"], active: true))
    habits[current].answers.append(answer(scoreForAnswer: 100, andWording: "Yes"))
    habits[current].answers.append(answer(scoreForAnswer: 0, andWording: "No"))
    habits[current].setUp(50)
    current+=1
    habits.append(habit(id: current, basicTitle: "Cooking", question: "Did you cook anything today?", answers: [], top: 35, average: 11, range: 7, smart: false, currentSuccess: true, streak: 0, daysLogged: 0, chapter: 2, importance: 1, history: [], reasons: ["get fat"], active: true))
    habits[current].answers.append(answer(scoreForAnswer: 100, andWording: "Yes - new recipe"))
    habits[current].answers.append(answer(scoreForAnswer: 80, andWording: "Yes"))
    habits[current].answers.append(answer(scoreForAnswer: 0, andWording: "No"))
    habits[current].setUp(50)
    current+=1
    habits.append(habit(id: current, basicTitle: "Reading", question: "Did you read anything today?", answers: [], top: 100, average: 80, range: 14, smart: true, currentSuccess: true, streak: 0, daysLogged: 0, chapter: 3, importance: 2, history: [], reasons: ["to grow your library"], active: true))
    habits[current].answers.append(answer(scoreForAnswer: 100, andWording: "Yes"))
    habits[current].answers.append(answer(scoreForAnswer: 0, andWording: "No"))
    habits[current].setUp(50)
    current+=1
    habits.append(habit(id: current, basicTitle: "Writing", question: "Did you write anything today?", answers: [], top: 10, average: 3, range: 31, smart: true, currentSuccess: true, streak: 0, daysLogged: 0, chapter: 3, importance: 1, history: [], reasons: ["do something you enjoy"], active: true))
    habits[current].answers.append(answer(scoreForAnswer: 100, andWording: "Yes"))
    habits[current].answers.append(answer(scoreForAnswer: 0, andWording: "No"))
    habits[current].setUp(50)
    
//    habits[current].setUp(50)
//    habits[1].setUp(60)
//    habits[2].setUp(50)
    print("Created habits, first one is " + habits[0].title)
    
    return habits
}

func createChapters () -> [chapter] {
    var chapters : [ chapter ] = []
    //CREATE FIVE CHAPTERS
    print("About to create Chapters")
    chapters.append(chapter(id: 0, basicTitle: "Health", importance: 3, streak: 0, currentSuccess: true, daysLogged: 0, active: true))
    chapters.append(chapter(id: 1, basicTitle: "Finance", importance: 3, streak: 0, currentSuccess: true, daysLogged: 0, active: true))
    chapters.append(chapter(id: 2, basicTitle: "Mind", importance: 2, streak: 0, currentSuccess: true, daysLogged: 0, active: true))
    chapters.append(chapter(id: 3, basicTitle: "Soul", importance: 1, streak: 0, currentSuccess: true, daysLogged: 0, active: true))
//    chapters.append(chapter(id: 0, basicTitle: "Health", range: 14, currentPerformance: 5, children: [], importance: 3, streak: 0, currentSuccess: true,  daysLogged: 0, active: true)),
//    chapters.append(chapter(id: 1, basicTitle: "Finance", range: 31, currentPerformance: 5, children: [], importance: 3, streak: 0, currentSuccess: true,  daysLogged: 0, active: true)),
//    chapters.append(chapter(id: 2, basicTitle: "Furtherance", range: 31, currentPerformance: 5, children: [], importance: 1, streak: 0, currentSuccess: true,  daysLogged: 0, active: true)),
//    for habitNumber in usersHabits! {
//        var chapterNumber = habitNumber.chapter - 1
//        chapters[chapterNumber].habits.append(habitNumber)
//        
//    }
    
    for chapter in chapters {
        if chapter.habits.count == 0 {
            chapter.active = false
        }
    }
    print("Created chapters. there are ", chapters.count)
    return chapters
}