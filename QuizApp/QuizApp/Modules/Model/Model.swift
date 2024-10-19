//
//  Model.swift
//  QuizApp
//
//  Created by Станислав Никулин on 09.10.2024.
//

import Foundation
import UIKit

/// Структура для хранения кнопок выбора
struct Buttons {
    /// Верхняя кнопка выбора
    let upperButton: UIButton
    
    /// Нижняя кнопка выбора
    let lowerButton: UIButton
}

/// Модель, представляющая шаг в интерактивной истории
struct Story {
    /// Уникальный идентификатор истории.
    let id: Int

    /// Описание или заголовок истории.
    let title: String
    
    /// Первый вариант выбора, который может сделать пользователь.
    let choice1: String
    
    /// Второй вариант выбора, который может сделать пользователь.
    let choice2: String
}

/// Коллекция историй для интерактивного повествования, идет через статический массив
struct Stories {
    /// Статический массив, содержащий все возможные истории.
    /// Каждая история описывается с помощью структуры `Story`.
    static let storiesArray: [Story] = [
        Story(id: 0, title: "You wake up in a dark forest. There’s a path ahead.", choice1: "Take the path", choice2: "Explore the woods"),
        Story(id: 1, title: "The path leads to an old cabin.", choice1: "Enter the cabin", choice2: "Keep walking down the path"),
        Story(id: 2, title: "You hear footsteps behind you.", choice1: "Hide in the bushes", choice2: "Turn around to confront"),
        Story(id: 3, title: "You find a strange key on the ground.", choice1: "Pick up the key", choice2: "Leave it and walk away"),
        Story(id: 4, title: "The key fits into a hidden door in the cabin.", choice1: "Open the door", choice2: "Leave the cabin")
    ]
    
    /// Возвращает историю по её идентификатору.
    func getStory(by id: Int) -> Story? {
        Stories.storiesArray.first { $0.id == id }
    }
}

