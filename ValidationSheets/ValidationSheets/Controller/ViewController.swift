//
//  ViewController.swift
//  ValidationSheets
//
//  Created by J  on 13/08/23.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private var userTextField: UITextField = {
        let text = UITextField(frame: .zero)
        text.placeholder = "Hear text..."
        text.borderStyle = .roundedRect
        return text
    }()
    
    private var validationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()
    
//    private let label: UILabel = {
//        let label = UILabel(frame: .zero)
//        label.text = "User name set"
//        label.textColor = .red
//        label.font = UIFont.systemFont(ofSize: 16)
//        return label
//    }()
//
//    private var userNameSet: UITextField = {
//        let text = UITextField(frame: .zero)
//        text.placeholder = "Hear text..."
//        text.borderStyle = .roundedRect
//        return text
//    }()
    
//    private var setUsernameBtn: UIButton = {
//        let btn = UIButton(type: .custom)
//        btn.setTitle("save", for: .normal)
//        btn.setTitleColor(.blue, for: .normal)
//        btn.addTarget(self, action: #selector(saveUserName), for: .touchUpInside)
//        return btn
//    }()
    
     private var viewModel = ViewModel()
    
    private var btnSubmited: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Submited", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .blue.withAlphaComponent(0.8)
        btn.addTarget(self, action: #selector(tappedSubmited), for: .touchUpInside)
        return btn
    }()
    
    deinit {
        print("deinit calling")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(userTextField)
        userTextField.edgesToSuperview(excluding: [.bottom], insets: .uniform(24), usingSafeArea: true)
        userTextField.height(50)
        
        view.addSubview(validationStackView)
        validationStackView.edgesToSuperview(excluding: [.bottom,.top], insets: .uniform(24))
        validationStackView.topToBottom(of: userTextField, offset: 24)
        
//        view.addSubview(label)
//        label.edgesToSuperview(excluding: [.top, .bottom], insets: .uniform(24))
//        label.topToBottom(of: validationStackView, offset: 100)
//        label.height(30)
//        
//        view.addSubview(userNameSet)
//        userNameSet.topToBottom(of: label, offset: 10)
//        userNameSet.edgesToSuperview(excluding: [.bottom, .top], insets: .uniform(24))
//        userNameSet.height(50)
//        
//        view.addSubview(setUsernameBtn)
//        setUsernameBtn.edgesToSuperview(excluding: [.top, .bottom], insets: .uniform(24))
//        setUsernameBtn.topToBottom(of: userNameSet, offset: 0)
//        setUsernameBtn.height(50)
//        setUsernameBtn.width(100)
        
        
        view.addSubview(btnSubmited)
        btnSubmited.edgesToSuperview(excluding: [.top], insets: .uniform(24), usingSafeArea: true)
        btnSubmited.height(50)
        
        
        
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: userTextField)
            .map({($0.object as? UITextField)?.text ?? ""})
            .assign(to: \.userNameFiedl, on: viewModel)
            .store(in: &CombineStor.cancelleble)
        
        viewModel.$userValidations.sink { [weak self] validations in
            guard let self = self else { return }
            self.validationStackView.subviews.forEach({$0.removeFromSuperview()})
            validations.forEach { validation in
                self.validationStackView.addArrangedSubview(self.validationBingView(message: validation.type.rawValue, isSelected: validation.isSelected))
            }
        }.store(in: &CombineStor.cancelleble)
        
        viewModel.$userNameFiedl.sink { [weak self] userName in
            guard let self = self else { return }
            viewModel.userNameValidation(userName: userName)
        }.store(in: &CombineStor.cancelleble)
        
        viewModel.isEnable
            .assign(to: \.isEnabled, on: btnSubmited)
            .store(in: &CombineStor.cancelleble)
        viewModel.isEnable.sink { [weak self] action in
            //self?.btnSubmited.isEnabled = action ? true : false
            self?.btnSubmited.alpha = action ? 1 : 0.5
        }.store(in: &CombineStor.cancelleble)
        
    }

    func validationBingView(message: String, isSelected: Bool) -> UIView {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = message
        
        let icon = UIImageView()
        icon.image = isSelected ? UIImage(named: "Click") : UIImage(named: "cancel")
        icon.contentMode = .scaleAspectFill
        icon.height(12)
        icon.width(12)
        
        let stackView = UIStackView(arrangedSubviews: [icon, label])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }
    
    @objc func tappedSubmited(sender: UIButton) {
        let alert = UIAlertController(title: "Success", message: "Validation filed is success.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
        
    }
//    @objc func saveUserName(sender: UIButton) {
//        viewModel.userNameAvailible = userNameSet.text ?? ""
//    }
}

struct CombineStor {
    static var cancelleble = Set<AnyCancellable>()
}
