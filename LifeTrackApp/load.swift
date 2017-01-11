//
//  load.swift
//  LifeTrackApp
//
//  Created by Steve Personal on 03/01/2017.
//  Copyright © 2017 Steve Sandbach. All rights reserved.
//

import Foundation

func load () {
    print("Loading")
    if (NSKeyedUnarchiver.unarchiveObjectWithFile(habitsFilePath) as? [habit] == nil ) {
        print("Creating tasks for first time")
        usersHabits = createHabits()
        saveHabits(usersHabits!)
    } else {
        print("loading tasks")
        var habits = NSKeyedUnarchiver.unarchiveObjectWithFile(habitsFilePath)as? [habit]
        print(habits)
        usersHabits = (NSKeyedUnarchiver.unarchiveObjectWithFile(habitsFilePath)as? [habit])!
    }
}