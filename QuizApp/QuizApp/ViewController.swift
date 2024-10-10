//
//  ViewController.swift
//  QuizApp
//
//  Created by Станислав Никулин on 09.10.2024.
//

import UIKit
import SnapKit

/// Основной контроллер представления для приложения QuizApp
final class ViewController: UIViewController {
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
    
    // MARK: - Life Cycle
    /// Настройка пользовательского интерфейса и его элементов
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupAppearance()
        setupLayout()
    }
    
    /// Добавление градиента для кнопок после появления представления
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addGradientToView(view: upperButton, gradientColors: [UIColor.upperButtonGradientFirst, UIColor.upperButtonGradientSecond])
        
        addGradientToView(view: lowerButton, gradientColors: [UIColor.downButtonGradientFirst, UIColor.downButtonGradientSecond])
    }
}


// MARK: - Private Methods
private extension ViewController {
    func setupViews() {
        view.addSubviews(redEllipse, yellowEllipse, textContainer, textLabel, VStack, progressView)
        
        VStack.addArrangedSubview(upperButton)
        VStack.addArrangedSubview(lowerButton)
    }
    func setupAppearance() {
        view.backgroundColor = .background
        
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
        makeButtons(buttons: Buttons(upperButton: upperButton, lowerButton: lowerButton))
        
        // MARK: ProgressView Appearance
        progressView.progressTintColor = .upperButtonGradientFirst
        progressView.progress = 0.0
        addShadowToView(view: progressView)
    }
    
    func setupLayout() {
        progressView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(10)
        }
        
        textContainer.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-400)
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

private extension ViewController {
    func makeButtons(buttons: Buttons) {
        
        buttons.upperButton.setTitle(Stories.storiesArray[0].choice1, for: .normal)
        buttons.upperButton.setTitleColor(.black, for: .normal)
        buttons.upperButton.titleLabel?.font = UIFont.systemFont(ofSize: .init(25), weight: .bold)
        buttons.upperButton.layer.cornerRadius = 20
        buttons.upperButton.layer.masksToBounds = true
        buttons.upperButton.tag = 0
        buttons.upperButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        buttons.lowerButton.setTitle(Stories.storiesArray[1].choice1, for: .normal)
        buttons.lowerButton.setTitleColor(.black, for: .normal)
        buttons.lowerButton.titleLabel?.font = UIFont.systemFont(ofSize: .init(25), weight: .bold)
        buttons.lowerButton.layer.cornerRadius = 20
        buttons.lowerButton.layer.masksToBounds = true
        buttons.lowerButton.tag = 1
        buttons.lowerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

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
