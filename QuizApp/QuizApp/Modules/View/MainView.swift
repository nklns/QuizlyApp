//
//  MainView.swift
//  QuizApp
//
//  Created by Станислав Никулин on 19.10.2024.
//

import UIKit
import SnapKit

final class MainView: UIView {
    // MARK: - UI Elements
    private let textContainer = UIView()
    private let textLabel = UILabel()
    
    private let upperButton = UIButton()
    private let lowerButton = UIButton()
    
    private let progressView = UIProgressView()
    
    private let yellowEllipse = UIImageView(image: UIImage.ellipseYellow)
    private let redEllipse = UIImageView(image: UIImage.ellipseRed)
    
    private let VStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .fillEqually
        return stack
    }()
    
    // MARK: - Logic Elements
    private var storiesIdCounter: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupAppearance()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Private Methods
private extension MainView {
    func setupViews() {
        addSubviews(redEllipse, yellowEllipse, textContainer, textLabel, VStack, progressView)
        
        VStack.addArrangedSubview(upperButton)
        VStack.addArrangedSubview(lowerButton)
    }
    func setupAppearance() {
        backgroundColor = .background
        
        // MARK: textContainer Appearance
        textContainer.backgroundColor = .black
        textContainer.layer.cornerRadius = 20
        textContainer.clipsToBounds = true
        addShadowToView(view: textContainer)
        
        // MARK: textLabel Appearance
        textLabel.textColor = .white
        textLabel.text = Stories.storiesArray[0].title
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 0
        textLabel.font = .systemFont(ofSize: 25, weight: .bold)
        
        // MARK: make buttons Appearance
        setupButtonsAppearance(button: upperButton, buttonType: .upperButton)
        setupButtonsAppearance(button: lowerButton, buttonType: .lowerButton)
        
        // MARK: ProgressView Appearance
        progressView.progressTintColor = .upperButtonGradientFirst
        progressView.progress = 0.0
        addShadowToView(view: progressView)
    }
    
    func setupLayout() {
        progressView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(10)
        }
        
        textContainer.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(100)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-400)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        textLabel.snp.makeConstraints {
            $0.verticalEdges.equalTo(textContainer.snp.verticalEdges).inset(20)
            $0.horizontalEdges.equalTo(textContainer.snp.horizontalEdges).inset(30)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        VStack.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(textContainer.snp.bottom).offset(180)
            $0.bottom.equalToSuperview().offset(-80)
        }
        
        yellowEllipse.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(30)
            $0.top.equalToSuperview().offset(50)
        }
        
        redEllipse.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(-30)
            $0.bottom.equalToSuperview().offset(-70)
        }
    }
}

private extension MainView {
    func setupButtonsAppearance(button: UIButton, buttonType: ButtonType) {
        let title: String
        
        switch buttonType {
        case .upperButton:
            title = Stories.storiesArray[0].choice1
        case .lowerButton:
            title = Stories.storiesArray[1].choice1
        }
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: .init(25), weight: .bold)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func addShadowToView(view: UIView) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .init(width: 0, height: 4)
        view.layer.shadowRadius = 3
        view.layer.shouldRasterize = true
    }
    
    func addGradientToView(view: UIView, gradientColors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.colors = gradientColors.map { $0.cgColor }
        gradient.startPoint = .init(x: 0, y: 0.5)
        gradient.endPoint = .init(x: 1, y: 0.5)
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = CGAffineTransform.identity
            }
        })

        progressView.setProgress(progressView.progress + 0.25, animated: true)
        storiesIdCounter += 1
        guard let newStory = Stories().getStory(by: storiesIdCounter) else { return }
        textLabel.text = newStory.title
        upperButton.setTitle(newStory.choice1, for: .normal)
        lowerButton.setTitle(newStory.choice2, for: .normal)
        
        // Логика перехода на другие истории
        switch sender.tag {
            case 0:
            fallthrough
            case 1:
            fallthrough
            default :
            break
        }
    }
}
