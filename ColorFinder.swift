//
//  counterColour.swift
//  Life App
//
//  Created by Steven Work on 17/06/2016.
//  Copyright © 2016 Steven Work. All rights reserved.
//

import Foundation
import UIKit


func updateCounterColour (count: Int) -> (color: UIColor,text: String) {
    if count == 150 {
        //Platnium
        return (UIColor(red: 239/255.0, green: 240/255.0, blue: 242/255.0, alpha: 1.0),"Platinum")
    } else if count > 130 {
        //Gold
        return (UIColor(red: 222/255.0, green: 152/255.0, blue: 7/255.0, alpha: 1.0),"Gold")
    } else if count > 120 {
        //Silver
        return (UIColor(red: 200/255.0, green: 201/255.0, blue: 202/255.0, alpha: 1.0),"Silver")
    } else if count > 110 {
        //Bronze
        return (UIColor(red: 180/255.0, green: 76/255.0, blue: 29/255.0, alpha: 1.0),"Bronze")
    } else if count > 80 {
        //Green
        return (UIColor.greenColor(),"")
    } else if count > 50 {
        //Yellow
        return (UIColor.yellowColor(),"")
    } else if count > 20 {
        //Orange
        return (UIColor.orangeColor(),"")
    } else {
        //red
        return (UIColor.redColor(),"")
    }
}