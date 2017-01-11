//
//  save.swift
//  LifeTrackApp
//
//  Created by Steve Personal on 11/12/2016.
//  Copyright © 2016 Steve Sandbach. All rights reserved.
//

import Foundation

var habitsFilePath: String {
    let manager = NSFileManager.defaultManager()
    let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first! as NSURL
    return url.URLByAppendingPathComponent("habits").path!
}
func saveHabits(habits: [habit]) {
    //print(masterLog.chapters)
    print("Saving. current is ", NSKeyedUnarchiver.unarchiveObjectWithFile(habitsFilePath))
    NSKeyedArchiver.archiveRootObject(habits, toFile: habitsFilePath)
    print("Now saving ", NSKeyedUnarchiver.unarchiveObjectWithFile(habitsFilePath) as? [habit])
    print("Save complete")
}
