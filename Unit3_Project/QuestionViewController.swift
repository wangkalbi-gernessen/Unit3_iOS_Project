import UIKit

class QuestionViewController: UIViewController {
    
    var questions: [Question] = [
        Question(
            text: "Which food do you like the most?",
            type: .single,
            answers: [
                Answer(text: "Steak", type: .dog),
                Answer(text: "Fish", type: .dog),
                Answer(text: "Carrots", type: .dog),
                Answer(text: "Corn", type: .dog)
            ]
        ),
        Question(
            text: "Which activity do you enjoy?",
            type: .multiple,
            answers: [
                Answer(text: "Swimming", type: .turtle),
                Answer(text: "Sleeping", type: .cat),
                Answer(text: "Cuddling", type: .rabbit),
                Answer(text: "Eating", type: .dog)
            ]
        ),
        Question(
            text: "How much do you enjoy car rides?",
            type: .ranged,
            answers: [
                Answer(text: "I dislike them", type: .cat),
                Answer(text: "I get a little nervous", type: .rabbit),
                Answer(text: "I barely notice them", type: .turtle),
                Answer(text: "I love them", type: .dog)
            ]
        ),
    ]
    
    var questionIndex = 0
    var answerChosen = [Answer]()
    
    let UIView1: UIView = {
        let view1 = UIView()
        view1.translatesAutoresizingMaskIntoConstraints = false
        view1.backgroundColor = .white
        return view1
    }()
    
    let UIView2: UIView = {
        let view2 = UIView()
        view2.translatesAutoresizingMaskIntoConstraints = false
        view2.backgroundColor = .white
        return view2
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        updateUI()
    }
    
    // create 4 buttons for single question view
    // setting tag number is referred to https://stackoverflow.com/questions/24814646/attach-parameter-to-button-addtarget-action-in-swift
    func setupSingleButtons() -> [UIButton] {
        var buttons:[UIButton] = [UIButton]()
        var tagNumber = 0
        for answer in questions[0].answers {
            let b = UIButton()
            tagNumber += 1
            b.tag = tagNumber
            b.setTitle(answer.text, for: .normal)
            b.translatesAutoresizingMaskIntoConstraints = false
            b.titleLabel?.font = UIFont(name: "font", size: 20)
            b.setTitleColor(.blue, for: .normal)
            b.layer.borderColor = UIColor.red.cgColor
            b.layer.borderWidth = 1
            b.layer.cornerRadius = 3
            b.heightAnchor.constraint(equalToConstant: 50).isActive = true
            b.widthAnchor.constraint(equalToConstant: 100).isActive = true
            b.addTarget(self, action: #selector(pressSingleButtons(_ : )), for: .touchUpInside)
            buttons.append(b)
        }
        return buttons
    }
    
    @objc func pressSingleButtons(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender.tag {
        case 1:
            answerChosen.append(currentAnswers[0])
        case 2:
            answerChosen.append(currentAnswers[1])
        case 3:
            answerChosen.append(currentAnswers[2])
        case 4:
            answerChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    
    // create a stackview for single question's 4 buttons
    func setupSingleViewStack() {
        
        view.addSubview(UIView1)
        
        let stack = UIStackView(arrangedSubviews: setupSingleButtons())
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        UIView1.addSubview(stack)
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    // create 4 UILabels on multiple question view
    func setupMultipleLabel(_ text: String) -> UILabel {
        let label:UILabel = UILabel()
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }
    
    // create 4 UISwitches on multiple question view
    func setupMultipleSwitch() -> UISwitch {
        var tagNumber = 0
        tagNumber += 1
        let multiSwitches = UISwitch()
        multiSwitches.tag = tagNumber
        multiSwitches.translatesAutoresizingMaskIntoConstraints = false
        multiSwitches.addTarget(self, action: #selector(switchOn), for: UIControl.Event.valueChanged)
        multiSwitches.isOn = true
        return multiSwitches
    }
    
    @objc func switchOn(_ sender: UISwitch!) {
        let currentAnswers = questions[questionIndex].answers
        
        if sender.tag == 1 && sender.isOn {
            answerChosen.append(currentAnswers[0])
        }
        if sender.tag == 2 && sender.isOn {
            answerChosen.append(currentAnswers[1])
        }
        if sender.tag == 3 && sender.isOn {
            answerChosen.append(currentAnswers[2])
        }
        if sender.tag == 4 && sender.isOn {
            answerChosen.append(currentAnswers[3])
        }
        nextQuestion()
    }
    
    // create a stackview for multiple question view
    func setupMultipleStackView() -> [UIStackView] {
        var totalStackView = [UIStackView]()
        for answer in questions[1].answers {
            let multiStacks = UIStackView(arrangedSubviews: [setupMultipleLabel(answer.text), setupMultipleSwitch()])
            multiStacks.alignment = .center
            multiStacks.axis = .horizontal
            multiStacks.spacing = 30
            multiStacks.distribution = .fillEqually
            multiStacks.translatesAutoresizingMaskIntoConstraints = false
            totalStackView.append(multiStacks)
        }
        return totalStackView
    }
    
    // create main stackview for 4 stackviews including 4 labels and switches on multiple question view
    func setupMainStackViewOnMultipleView() {
        view.addSubview(UIView2)
        let mainStackView = UIStackView(arrangedSubviews: setupMultipleStackView())
        mainStackView.alignment = .center
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        mainStackView.distribution = .equalCentering
        UIView2.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    } 
    
    // create a slider on ranged question view
    func setupSlider() -> UISlider {
        let slider = UISlider()
        slider.maximumValue = 1
        slider.minimumValue = 0
        slider.tintColor = .green
        slider.isContinuous = true
        return slider
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    // create a stackview for ranged question view
//    func rangedLabels() -> UILabel {
//        var rangedLabels:[UILabel] = [UILabel]()
//        var tagNumber = 0
//        let rangedLabel = UILabel()
//        rangedLabel.text = answer.text
//        rangedLabel.translatesAutoresizingMaskIntoConstraints = false
//        rangedLabel.font = UIFont.systemFont(ofSize: 20)
//        rangedLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        rangedLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        rangedLabels.append(rangedLabel)
//        return rangedLabels
//    }
    
    // create a stackview for ranged question view's labels
    func rangedStackView() {
        let rangedStack = UIStackView(arrangedSubviews: [setupSlider()])
        rangedStack.alignment = .center
        rangedStack.axis = .vertical
        rangedStack.spacing = 10
        rangedStack.distribution = .fillEqually
        view.addSubview(rangedStack)
        rangedStack.translatesAutoresizingMaskIntoConstraints = false
        rangedStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rangedStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func updateUI() {
        navigationItem.title = "Question #\(questionIndex + 1)"
        let currentQuestion = questions[questionIndex]
        
        switch currentQuestion.type {
        case .single:
            setupSingleViewStack()
        case .multiple:
            UIView1.isHidden = true
            setupMainStackViewOnMultipleView()
        case .ranged:
            setupSingleViewStack()
        }
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            let navigationController = UINavigationController(rootViewController: ResultViewController(answerChosen))
            present(navigationController, animated: true, completion: nil)
        }
    }
}
