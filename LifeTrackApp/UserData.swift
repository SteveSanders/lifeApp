//
//  userData.swift
//  LifeTrackApp
//
//  Created by Steve Personal on 23/08/2016.
//  Copyright © 2016 Steve Sandbach. All rights reserved.
//

import Foundation

//var myHabits = Set<habit>()

var usersHabits: [habit]? = nil {
didSet {
    print("habits created")
    usersChapters = createChapters()
}
}

var usersChapters: [chapter]? = nil {
    didSet{
        print("Chapters Set")
        masterLog = master(streak: 0, currentSuccess: true, daysLogged: 0)
    }
}

var masterLog: master? = nil {
    didSet {
        print("Setting life score from Master")
        lifeScore = (masterLog?.currentScores["Default"])!
    }
}
var lifeScore: Int? = nil {
    didSet {
        print("Life Score is now,", lifeScore)
    }
}

var lastLog: NSDate = NSDate()
