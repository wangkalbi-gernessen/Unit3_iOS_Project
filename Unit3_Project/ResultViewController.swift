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
        resultAnswer.text = "You are\(mostCommonAnswer.rawValue)!"
        
        
        return resultAnswer
    }()
    
    let resultDefinitionLabel: UILabel = {
        let resultDefinition = UILabel()
        
        
        
        return resultDefinition
    }()
    
    var responses: [Answer]
    
    init?(coder: NSCoder, responses: [Answer]) {
        self.responses = responses
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = .brown
        title = "Result"
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(returnToIntroduction(_:)))
        navigationItem.rightBarButtonItem = doneBtn
        calculatePersonalityResult()
        
    }
    
    @objc func returnToIntroduction(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func calculatePersonalityResult() {
        let frequencyOfAnswers = responses.reduce(into: [AnimalType: Int]()) {
            if existingCount = counts[answer.type] {
                counts[answer.type] = existingCount + 1
            } else {
                counts[answer.type] = 1
            }
            
        }
        
        let mostCommonAnswer = frequencyOfAnswers.sorted{$0.1 > $1.1}.first!.key
    }
}
