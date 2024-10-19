//
//  GenericViewController.swift
//  QuizApp
//
//  Created by Станислав Никулин on 19.10.2024.
//

import Foundation
import UIKit

class GenericViewController<T: UIView>: UIViewController {
    // MARK: Public Properties

    var rootView: T {
        guard let rootView = view as? T else {
            fatalError("Failde to cast view as \(T.self)")
        }
        return rootView
    }

    // MARK: - Public Methods

    override func loadView() {
        self.view = T()
    }
}
