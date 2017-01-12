//
//  scoreCard.swift
//  LifeTrackApp
//
//  Created by Steve Personal on 08/01/2017.
//  Copyright © 2017 Steve Sandbach. All rights reserved.
//

import UIKit

class scoreCard: UILabel {
    func setScore (_ score: Int) {
        self.text = score.description
        let backColour: (color: UIColor,text: String) = updateCounterColour(score)
        self.backgroundColor = backColour.color
    }
}
