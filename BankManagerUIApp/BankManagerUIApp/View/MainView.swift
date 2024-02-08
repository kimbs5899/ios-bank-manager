import UIKit

class MainView: UIView {
    
    lazy var addCustomerButton: UIButton = {
        let button = UIButton()
        let label = UILabel()
        button.setTitle("고객 10명 추가", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("초기화", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.setTitleColor(.red, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    lazy var topStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [addCustomerButton, resetButton])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        return stack
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "업무시간 - 04:33:252"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    lazy var waitListTitleView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.contentMode = .center
        
        let label = UILabel()
        label.text = "대기중"
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        label.frame = view.bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(label)
        return view
    }()
    
    lazy var waitListContentStackView: UIStackView = {
        
        var result: [UILabel] = []
        for _ in 1...3 {
            result.append(addLabel())
        }
        
        var stack = UIStackView(arrangedSubviews: result)
        stack.spacing = 10
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    
    lazy var waitListStackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [waitListTitleView, waitListContentStackView])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        return stack
    }()
    
    lazy var businessTitleView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.contentMode = .center
        
        let label = UILabel()
        label.text = "업무중"
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        label.frame = view.bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(label)
        return view
    }()
    
    lazy var businessContentStackView: UIStackView = {
        
        var result: [UILabel] = []
        for _ in 1...3 {
            result.append(addLabel())
        }
        
        var stack = UIStackView(arrangedSubviews: result)
        stack.spacing = 10
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    
    lazy var businessListStackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [businessTitleView, businessContentStackView])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        return stack
    }()
    
    lazy var secondStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [waitListStackView,businessListStackView])
        stack.axis = .horizontal
        stack.alignment = .top
        stack.distribution = .equalCentering
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        addSubview(topStack)
        addSubview(timeLabel)
        addSubview(secondStackView)
    }
    
    func setupConstraint() {
        waitListTitleView.translatesAutoresizingMaskIntoConstraints = false
        businessTitleView.translatesAutoresizingMaskIntoConstraints = false
        secondStackView.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        addCustomerButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        waitListTitleView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        businessTitleView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        
        waitListTitleView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        businessTitleView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addCustomerButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        addCustomerButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        topStack.translatesAutoresizingMaskIntoConstraints = false
        topStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        topStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        timeLabel.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 20).isActive = true
        timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        
        secondStackView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20).isActive = true
        secondStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        secondStackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    func addLabel() -> UILabel {
        lazy var label = UILabel()
        label.text = "5 - 예금"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        return label
    }
}