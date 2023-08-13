//
//  ViewController.swift
//  ValidationSheets
//
//  Created by J  on 13/08/23.
//

import UIKit

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
    
    private var btnSubmited: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Submited", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .blue.withAlphaComponent(0.8)
        return btn
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(userTextField)
        userTextField.edgesToSuperview(excluding: [.bottom], insets: .uniform(24), usingSafeArea: true)
        userTextField.height(50)
        
        view.addSubview(validationStackView)
        validationStackView.edgesToSuperview(excluding: [.bottom,.top], insets: .uniform(24))
        validationStackView.topToBottom(of: userTextField, offset: 24)
        
        
        
    }

    func validationBingView(message: String, isSelected: Bool) -> UIView {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = message
        
        let icon = UIImageView()
        icon.image = isSelected ? UIImage(named: "Click") : UIImage(named: "cancel")
        icon.contentMode = .scaleAspectFit
        icon.height(12)
        icon.width(12)
        
        let stackView = UIStackView(arrangedSubviews: [icon, label])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }

}

