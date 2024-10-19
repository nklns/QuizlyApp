//
//  ChoiceButton.swift
//  QuizApp
//
//  Created by Станислав Никулин on 19.10.2024.
//

import UIKit
import SnapKit

final class ChoiceButton: UIButton {
    // MARK: - UI Elements
    let buttonTitleLabel = UILabel()
    var gradientColors: [UIColor] = []
    let gradient = CAGradientLayer()
    
    private let choiceButtonType: ChoiceButtonType
    
    init(choiceButtonType: ChoiceButtonType) {
        self.choiceButtonType = choiceButtonType
        super.init(frame: .zero)
        
        setupElementsFromInit()
        setupViews()
        setupAppearance()
        setupLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.frame = bounds
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods
extension ChoiceButton {
    func updateTitle(_ title: String) {
        buttonTitleLabel.text = title
    }
}

// MARK: - Private Methods
private extension ChoiceButton {
    func setupViews() {
        addSubviews(buttonTitleLabel)
    }
    
    func setupAppearance() {
        backgroundColor = .clear
        layer.insertSublayer(gradient, at: 0)
        layer.cornerRadius = 20
        layer.masksToBounds = true
        
        setupTitleLabel()
        setupGradient()
    }
    
    func setupLayout() {
        buttonTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}

private extension ChoiceButton {
    func setupElementsFromInit() {
        switch choiceButtonType {
        case .upperButton:
            buttonTitleLabel.text = Stories.storiesArray[0].choice1
            gradientColors = [UIColor.upperButtonGradientFirst, UIColor.upperButtonGradientSecond]
        case .lowerButton:
            buttonTitleLabel.text = Stories.storiesArray[1].choice1
            gradientColors = [UIColor.downButtonGradientFirst, UIColor.downButtonGradientSecond]
        }
    }
    
    func setupTitleLabel() {
        buttonTitleLabel.font =  .systemFont(ofSize: .init(25), weight: .bold)
        buttonTitleLabel.textColor = .black
    }
    
    func setupGradient() {
        gradient.colors = gradientColors.map { $0.cgColor }
        gradient.startPoint = .init(x: 0, y: 0.5)
        gradient.endPoint = .init(x: 1, y: 0.5)
    }
}

