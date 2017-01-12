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
    if (NSKeyedUnarchiver.unarchiveObject(withFile: habitsFilePath) as? [habit] == nil ) {
        print("Creating tasks for first time")
        usersHabits = createHabits()
        //saveHabits(usersHabits!)
    } else {
        print("loading tasks")
        let habits = NSKeyedUnarchiver.unarchiveObject(withFile: habitsFilePath)as? [habit]
        print(habits)
        usersHabits = (NSKeyedUnarchiver.unarchiveObject(withFile: habitsFilePath)as? [habit])!
    }
}
