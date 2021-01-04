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
    
    // create question labels per a question view
    let questionLabels: UILabel = {
        let question = UILabel()
        question.translatesAutoresizingMaskIntoConstraints = false
        question.font = UIFont(name: "Georgia", size: 20)
        return question
    }()
    
    // create empty UIView for single answer
    let UIView1: UIView = {
        let view1 = UIView()
        view1.translatesAutoresizingMaskIntoConstraints = false
        view1.backgroundColor = .white
        return view1
    }()
    
    // create empty UIView for multiple answer
    let UIView2: UIView = {
        let view2 = UIView()
        view2.translatesAutoresizingMaskIntoConstraints = false
        view2.backgroundColor = .white
        return view2
    }()
    
    // create empty UIView for ranged answer
    let UIView3: UIView = {
        let view3 = UIView()
        view3.translatesAutoresizingMaskIntoConstraints = false
        view3.backgroundColor = .white
        return view3
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        updateUI()
    }
    
    // create question label on the top of each view
    func createQuestionLabel() -> UILabel {
        view.addSubview(questionLabels)
        questionLabels.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        questionLabels.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return questionLabels
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
    
    // implement something when single answer button is clicked
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
        UIView1.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        UIView1.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        UIView1.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        UIView1.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        let questionLabel = createQuestionLabel()
        questionLabel.text = questions[0].text
        
        let stack = UIStackView(arrangedSubviews: setupSingleButtons())
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        UIView1.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: questionLabels.bottomAnchor, constant: 50).isActive = true
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
        multiSwitches.setOn(true, animated: true)
        multiSwitches.addTarget(self, action: #selector(switchOn), for: UIControl.Event.valueChanged)
        return multiSwitches
    }
    
    // implement something when UISwitch is turned on
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
    
    // create submit button on multiple answer view
    func setupMultipleAnswerButton() -> UIButton {
        let multiAnswerBtn = UIButton()
        multiAnswerBtn.setTitle("Submit Answer", for: .normal)
        multiAnswerBtn.translatesAutoresizingMaskIntoConstraints = false
        multiAnswerBtn.titleLabel?.font = UIFont(name: "font", size: 20)
        multiAnswerBtn.setTitleColor(.blue, for: .normal)
        multiAnswerBtn.layer.borderColor = UIColor.red.cgColor
        multiAnswerBtn.layer.borderWidth = 1
        multiAnswerBtn.layer.cornerRadius = 3
        multiAnswerBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        multiAnswerBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        multiAnswerBtn.addTarget(self, action: #selector(pressMultipleAnswerButton(_:)), for: .touchUpInside)
        return multiAnswerBtn
    }
    
    @objc func pressMultipleAnswerButton(_ sender: UIButton) {
        nextQuestion()
    }
    
    // create main stackview for 4 stackviews including 4 labels and switches on multiple question view
    func setupMainStackViewOnMultipleView() {
        view.addSubview(UIView2)
        UIView2.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        UIView2.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        UIView2.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        UIView2.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        let questionLabel = createQuestionLabel()
        questionLabel.text = questions[1].text
        questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let mainStackView = UIStackView(arrangedSubviews: setupMultipleStackView())
        mainStackView.addArrangedSubview(setupMultipleAnswerButton())
        mainStackView.alignment = .center
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        mainStackView.distribution = .equalCentering
        UIView2.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainStackView.topAnchor.constraint(equalTo: questionLabels.bottomAnchor, constant: 50).isActive = true
    }
    
    // create a slider on ranged question view
    func setupSlider() -> UISlider {
        let slider = UISlider()
        slider.maximumValue = 1
        slider.minimumValue = 0
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.widthAnchor.constraint(equalToConstant: 200).isActive = true
        slider.tintColor = .green
        slider.setValue(0.5, animated: false)
        slider.addTarget(self, action: #selector(changeSliderValue(_:)), for: UIControl.Event.valueChanged)
        return slider
    }
    
    @objc func changeSliderValue(_ sender: UISlider) {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(sender.value * Float(currentAnswers.count - 1)))
        answerChosen.append(currentAnswers[index])
    }

    // create a stackview for ranged question view
    func setupRangedLabels() -> [UILabel] {
        let rangedLabel1 = UILabel()
        rangedLabel1.translatesAutoresizingMaskIntoConstraints = false
        rangedLabel1.font = UIFont.systemFont(ofSize: 20)
        rangedLabel1.text = questions[questionIndex].answers.first?.text
        
        let rangedLabel2 = UILabel()
        rangedLabel2.translatesAutoresizingMaskIntoConstraints = false
        rangedLabel2.font = UIFont.systemFont(ofSize: 20)
        rangedLabel2.text = questions[questionIndex].answers.last?.text
        
        let rangedLabels:[UILabel] = [rangedLabel1,rangedLabel2]
        return rangedLabels
    }
    
    // create a stackview for two labels on ranged question view
    func setupStackViewForTwoLabels() -> UIStackView {
        let stackForTwoLabels = UIStackView(arrangedSubviews: setupRangedLabels())
        stackForTwoLabels.axis = .horizontal
        stackForTwoLabels.alignment = .center
        stackForTwoLabels.spacing = 10
        stackForTwoLabels.distribution = .fillEqually
        stackForTwoLabels.translatesAutoresizingMaskIntoConstraints = false
        return stackForTwoLabels
    }
    
    // create a button
    func setupButtonToResult() -> UIButton {
        let rangedAnswerBtn = UIButton()
        rangedAnswerBtn.setTitle("Submit Answer", for: .normal)
        rangedAnswerBtn.translatesAutoresizingMaskIntoConstraints = false
        rangedAnswerBtn.titleLabel?.font = UIFont(name: "Georgia", size: 20)
        rangedAnswerBtn.setTitleColor(.white, for: .normal)
        rangedAnswerBtn.layer.borderColor = UIColor.red.cgColor
        rangedAnswerBtn.backgroundColor = .gray
        rangedAnswerBtn.layer.borderWidth = 1
        rangedAnswerBtn.layer.cornerRadius = 3
        rangedAnswerBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        rangedAnswerBtn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        rangedAnswerBtn.addTarget(self, action: #selector(pressRangedAnswerButton(_:)), for: .touchUpInside)
        return rangedAnswerBtn
    }
    
    // click on submit answer button on ranged answer
    @objc func pressRangedAnswerButton(_ sender: UIButton) {
        nextQuestion()
    }
    
    // create a stackview for all objects on ranged question view
    func setupRangedStackView() {
        view.addSubview(UIView3)
        UIView3.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        UIView3.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        UIView3.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        UIView3.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        let questionLabel = createQuestionLabel()
        questionLabel.text = questions[2].text
        questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let rangedStack = UIStackView(arrangedSubviews: [setupSlider(), setupStackViewForTwoLabels(), setupButtonToResult()])
        rangedStack.alignment = .center
        rangedStack.axis = .vertical
        rangedStack.spacing = 10
        rangedStack.distribution = .fillEqually
        UIView3.addSubview(rangedStack)
        rangedStack.translatesAutoresizingMaskIntoConstraints = false
        rangedStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rangedStack.topAnchor.constraint(equalTo: questionLabels.bottomAnchor, constant: 50).isActive = true
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
            UIView2.isHidden = true
            setupRangedStackView()
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
