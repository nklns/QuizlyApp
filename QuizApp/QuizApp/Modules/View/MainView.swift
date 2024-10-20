//
//  MainView.swift
//  QuizApp
//
//  Created by Станислав Никулин on 19.10.2024.
//

import UIKit
import SnapKit

protocol ButtonTappedDelegate: AnyObject {
    func buttonTapped(_ sender: UIButton)
}

final class MainView: UIView {
    // MARK: - Delegates
    /// Делегат нажатия одной из кнопок
    weak var delegate: ButtonTappedDelegate?
    
    // MARK: - UI Elements
    private let textContainer = UIView()
    private let textLabel = UILabel()
    
    private let upperButton = ChoiceButton(choiceButtonType: .upperButton)
    private let lowerButton = ChoiceButton(choiceButtonType: .lowerButton)
    
    private let progressView = UIProgressView()
    
    private let yellowEllipse = UIImageView(image: UIImage.ellipseYellow)
    private let redEllipse = UIImageView(image: UIImage.ellipseRed)
    
    private let buttonsStackView = UIStackView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupAppearance()
        setupLayout()
        setupBehavior()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Public Methods
extension MainView {
    func updateUI(with story: Story) {
        progressView.setProgress(progressView.progress + 0.25, animated: true)
        textLabel.text = story.title
        upperButton.updateTitle(story.choice1)
        lowerButton.updateTitle(story.choice2)
    }
}

// MARK: - Private Methods
private extension MainView {
    func setupViews() {
        addSubviews(redEllipse, yellowEllipse, textContainer, textLabel, buttonsStackView, progressView)
    }
    
    func setupAppearance() {
        backgroundColor = .background
        
        setupButtonsStackView()
        setupTextContainer()
        setupTextLabel()
        setupProgressView()
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
        
        buttonsStackView.snp.makeConstraints {
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
    
    func setupBehavior() {
        upperButton.tag = 0
        lowerButton.tag = 1
        upperButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        lowerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
}

private extension MainView {
    func addShadowToView(view: UIView) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .init(width: 0, height: 4)
        view.layer.shadowRadius = 3
        view.layer.shouldRasterize = true
    }
    
    func setupTextContainer() {
        textContainer.backgroundColor = .black
        textContainer.layer.cornerRadius = 20
        textContainer.clipsToBounds = true
        addShadowToView(view: textContainer)
    }

    func setupButtonsStackView() {
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 15
        buttonsStackView.distribution = .fillEqually
        [upperButton, lowerButton].forEach { buttonsStackView.addArrangedSubview($0) }
    }
    
    func setupProgressView() {
        progressView.progressTintColor = .upperButtonGradientFirst
        progressView.progress = 0.0
        addShadowToView(view: progressView)
    }
    
    func setupTextLabel() {
        textLabel.textColor = .white
        textLabel.text = Stories.storiesArray[0].title
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 0
        textLabel.font = .systemFont(ofSize: 25, weight: .bold)
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = CGAffineTransform.identity
            }
        })
        delegate?.buttonTapped(sender)
    }
}
