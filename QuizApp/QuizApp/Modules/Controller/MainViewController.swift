//
//  MainViewController.swift
//  QuizApp
//
//  Created by Станислав Никулин on 19.10.2024.
//

import UIKit

final class MainViewController: GenericViewController<MainView> {
    private var storiesIdCounter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
    }
}

// MARK: - Private Methods
private extension MainViewController {
    func setupDelegates() {
        rootView.delegate = self
    }
}

// MARK: -
extension MainViewController: ButtonTappedDelegate {
    func buttonTapped(_ sender: UIButton) {
        storiesIdCounter += 1
        guard let newStory = Stories().getStory(by: storiesIdCounter) else { return }
        rootView.updateUI(with: newStory)
    }
}
