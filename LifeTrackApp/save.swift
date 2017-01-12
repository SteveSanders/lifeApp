//
//  save.swift
//  LifeTrackApp
//
//  Created by Steve Personal on 11/12/2016.
//  Copyright © 2016 Steve Sandbach. All rights reserved.
//

import Foundation

var habitsFilePath: String {
    let manager = FileManager.default
    let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
    return url.appendingPathComponent("habits").path
}
func saveHabits(_ habits: [habit]) {
    //print(masterLog.chapters)
    print("Saving. current is ", NSKeyedUnarchiver.unarchiveObject(withFile: habitsFilePath))
    NSKeyedArchiver.archiveRootObject(habits, toFile: habitsFilePath)
    print("Now saving ", NSKeyedUnarchiver.unarchiveObject(withFile: habitsFilePath) as? [habit])
    print("Save complete")
}
