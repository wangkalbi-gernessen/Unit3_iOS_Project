//
//  ResultViewController.swift
//  Unit3_Project
//
//  Created by Kazunobu Someya on 2020-12-29.
//

import UIKit

class ResultViewController: UIViewController {
    
    let resultAnswerLabel: UILabel = {
        let resultAnswer = UILabel()
        resultAnswer.backgroundColor = .white
        resultAnswer.font = UIFont(name: "Georgia", size: 20)
        resultAnswer.translatesAutoresizingMaskIntoConstraints = false
        return resultAnswer
    }()
    
    let resultDefinitionLabel: UILabel = {
        let resultDefinition = UILabel()
        resultDefinition.backgroundColor = .white
        resultDefinition.font = UIFont(name: "Georgia", size: 20)
        resultDefinition.translatesAutoresizingMaskIntoConstraints = false
        resultDefinition.numberOfLines = 0
        resultDefinition.lineBreakMode = .byWordWrapping
        return resultDefinition
    }()
    
    lazy var stackview: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [resultAnswerLabel, resultDefinitionLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var responses: [Answer]
    
    init(_ responses: [Answer]) {
        self.responses = responses
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setupStackView()
        view.backgroundColor = .white
        title = "Result"
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(returnToIntroduction(_:)))
        navigationItem.rightBarButtonItem = doneBtn
        calculatePersonalityResult()
        
    }
    
    func setupStackView() {
        view.addSubview(stackview)
        stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackview.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackview.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true 
    }
    
    @objc func returnToIntroduction(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func calculatePersonalityResult() {
        let frequencyOfAnswers = responses.reduce(into: [:]) {
            (counts, answer) in
            counts[answer.type, default: 0] += 1
        }
        let frequentAnswerSorted = frequencyOfAnswers.sorted(by: {(pair1, pair2) in
            return pair1.value > pair2.value
        })
        
        let mostCommonAnswer = frequencyOfAnswers.sorted{$0.1 > $1.1}.first!.key
        
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
    }
}
