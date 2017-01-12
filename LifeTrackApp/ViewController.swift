//
//  ViewController.swift
//  LifeTrackApp
//
//  Created by Steve Personal on 16/08/2016.
//  Copyright © 2016 Steve Sandbach. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Log box
    @IBOutlet weak var logButton: UIButton!
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var logMessage: UILabel!
    @IBOutlet weak var lifeScoreLabel: scoreCard!
    
    @IBOutlet weak var TestButton: UIButton!
    //Life Score box
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // fake last log date on app load- - will be laoded from data
        var c = DateComponents()
        c.year = 2015
        c.month = 8
        c.day = 31
        var date = Calendar(identifier: Calendar.Identifier.gregorian).date(from: c)
        
        //let today = NSCalendar(identifier: NSCalendarIdentifierGregorian)?.isDateInToday(_ date: Date)
        
        //let timeString = "\(dateFormatter.stringFromDate(NSDate()))"
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy" // Set the way the date should be displayed
        dateField.text = "Last log day: " + formatter.string(from: date!)
        
        let isToday = Calendar.current.isDateInToday(date!)
        
        if isToday {
            logMessage.text = "You have already logged for today: well done!"
            logButton.isHidden = true
            //set text to log hasbeen done
        } else {
            logMessage.text = "Log for today..."
        }
        lifeScoreLabel.setScore(lifeScore!)
    }
    
    @IBAction func logMade(_ sender: AnyObject) {
        
        print("running log made")
        //DELETE BELOW - MERELY TEST SCRIPT
        let date = Date()
        
        
        //everythignbelow is done in View Did Load so would notneed to be done in the main app
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy" // Set the way the date should be displayed
        dateField.text = "Last log day: " + formatter.string(from: date)
        
        let isToday = Calendar.current.isDateInToday(date)
        
        if isToday {
            logMessage.text = "You have already logged for today: well done!"
            logButton.isHidden = true
            
            //set text to log hasbeen done
        } else {
            logMessage.text = "Log for today..."
        }

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func isLifeBoxSet () -> Bool {
        return true
    }
}

