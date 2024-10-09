//
//  Model.swift
//  QuizApp
//
//  Created by Станислав Никулин on 09.10.2024.
//

import Foundation
import UIKit

struct Buttons {
    let upperButton: UIButton
    let lowerButton: UIButton
}

struct Story {
    let id: Int
    let title: String
    let choice1: String
    let choice2: String
}

struct Stories {
    static let storiesArray: [Story] = [
        Story(id: 0, title: "You wake up in a dark forest. There’s a path ahead.", choice1: "Take the path", choice2: "Explore the woods"),
        Story(id: 1, title: "The path leads to an old cabin.", choice1: "Enter the cabin", choice2: "Keep walking down the path"),
        Story(id: 2, title: "You hear footsteps behind you.", choice1: "Hide in the bushes", choice2: "Turn around to confront"),
        Story(id: 3, title: "You find a strange key on the ground.", choice1: "Pick up the key", choice2: "Leave it and walk away"),
        Story(id: 4, title: "The key fits into a hidden door in the cabin.", choice1: "Open the door", choice2: "Leave the cabin")
    ]
    
    func getStory(by id: Int) -> Story? {
        Stories.storiesArray.first { $0.id == id }
    }
}
