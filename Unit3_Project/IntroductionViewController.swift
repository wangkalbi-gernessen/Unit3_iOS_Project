import UIKit

class IntroductionViewController: UIViewController {
    
    let label: UILabel = {
        let title = UILabel()
        title.text = "Which Animal Are You?"
        title.font = UIFont(name: "Georgia", size: 30)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let button: UIButton = {
        let btn = UIButton()
        btn.setTitle("Begin Personality Quiz", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let dogLabel: UILabel = {
        let dog = UILabel()
        dog.text = "🐶"
        dog.font = UIFont.systemFont(ofSize: 40)
        dog.translatesAutoresizingMaskIntoConstraints = false
        return dog
    }()
    
    let catLabel: UILabel = {
        let cat = UILabel()
        cat.text = "🐱"
        cat.font = UIFont.systemFont(ofSize: 40)
        cat.translatesAutoresizingMaskIntoConstraints = false
        return cat
    }()
    
    let rabbitLabel: UILabel = {
        let rabbit = UILabel()
        rabbit.text = "🐰"
        rabbit.font = UIFont.systemFont(ofSize: 40)
        rabbit.translatesAutoresizingMaskIntoConstraints = false
        return rabbit
    }()
    
    let turtleLabel: UILabel = {
        let turtle = UILabel()
        turtle.text = "🐢"
        turtle.font = UIFont.systemFont(ofSize: 40)
        turtle.translatesAutoresizingMaskIntoConstraints = false
        return turtle
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label,button])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 1
        stack.distribution = .fill
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(dogLabel)
        view.addSubview(catLabel)
        view.addSubview(rabbitLabel)
        view.addSubview(turtleLabel)
        view.addSubview(stackView)
        setupStackView()
        setupEmoji()
        button.addTarget(self, action: #selector(goToQandAScreen(_:)), for: .touchUpInside)
    }
    
    func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
    }
        
    func setupEmoji() {
        dogLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        dogLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        catLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        catLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        rabbitLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        rabbitLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        turtleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        turtleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    @objc func goToQandAScreen(_ sender: UIButton) {
        let nvc = UINavigationController(rootViewController: QuestionViewController())
        present(nvc, animated: true, completion: nil)
    }
}
