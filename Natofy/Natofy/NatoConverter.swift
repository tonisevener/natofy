//
//  NatoConverter.swift
//  Natofy
//
//  Created by Toni Sevener on 12/13/17.
//  Copyright © 2017 Toni Sevener. All rights reserved.
//

import Foundation

struct Translation {
    let short: String
    let long: String
}

class NatoConverter {
    
    //TODO: use only translation, make it it's own indexable element so indexOfObject works. (sequence protocol?)
    static let alphabetArray: [Translation] = [
        Translation(short: "A", long: "Alpha"),
        Translation(short: "B", long: "Bravo"),
        Translation(short: "C", long: "Charlie"),
        Translation(short: "D", long: "Delta"),
        Translation(short: "E", long: "Echo"),
        Translation(short: "F", long: "Foxtrot"),
        Translation(short: "G", long: "Golf"),
        Translation(short: "H", long: "Hotel"),
        Translation(short: "I", long: "India"),
        Translation(short: "J", long: "Juliett"),
        Translation(short: "K", long: "Kilo"),
        Translation(short: "L", long: "Lima"),
        Translation(short: "M", long: "Mike"),
        Translation(short: "N", long: "November"),
        Translation(short: "O", long: "Oscar"),
        Translation(short: "P", long: "Papa"),
        Translation(short: "Q", long: "Quebec"),
        Translation(short: "R", long: "Romeo"),
        Translation(short: "S", long: "Sierra"),
        Translation(short: "T", long: "Tango"),
        Translation(short: "U", long: "Uniform"),
        Translation(short: "V", long: "Victor"),
        Translation(short: "W", long: "Whiskey"),
        Translation(short: "X", long: "X-ray"),
        Translation(short: "Y", long: "Yankee"),
        Translation(short: "Z", long: "Zulu"),
        Translation(short: "0", long: "Zero"),
        Translation(short: "1", long: "One"),
        Translation(short: "2", long: "Two"),
        Translation(short: "3", long: "Three"),
        Translation(short: "4", long: "Four"),
        Translation(short: "5", long: "Five"),
        Translation(short: "6", long: "Six"),
        Translation(short: "7", long: "Seven"),
        Translation(short: "8", long: "Eight"),
        Translation(short: "9", long: "Nine"),
        Translation(short: "-", long: "Dash")
    ]
    
    static let alphabetDict: [Character: String] = [
        "A": "Alpha",
        "B": "Bravo",
        "C": "Charlie",
        "D": "Delta",
        "E": "Echo",
        "F": "Foxtrot",
        "G": "Golf",
        "H": "Hotel",
        "I": "India",
        "J": "Juliett",
        "K": "Kilo",
        "L": "Lima",
        "M": "Mike",
        "N": "November",
        "O": "Oscar",
        "P": "Papa",
        "Q": "Quebec",
        "R": "Romeo",
        "S": "Sierra",
        "T": "Tango",
        "U": "Uniform",
        "V": "Victor",
        "W": "Whiskey",
        "X": "X-ray",
        "Y": "Yankee",
        "Z": "Zulu",
        "0": "Zero",
        "1": "One",
        "2": "Two",
        "3": "Three",
        "4": "Four",
        "5": "Five",
        "6": "Six",
        "7": "Seven",
        "8": "Eight",
        "9": "Nine",
        "-": "Dash"
    ]
    
    static func convert(text: String) -> [String] {
        return text.uppercased().map { (c) -> String in
            return NatoConverter.alphabetDict[c] ?? c.description
        }
    }
}
