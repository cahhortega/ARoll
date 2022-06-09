//
//  Dice.swift
//  Roll
//
//  Created by Carolina Ortega on 09/06/22.
//

import Foundation

public class Dice {
    static var shared: Dice = {
        return Dice()
    }()
    var colorDice: String
    
    init() {
        colorDice = ""
    }
    
}
