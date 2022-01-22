//
//  ViewController.swift
//  TestTask
//
//  Created by Artem Muho on 21.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: -Properties
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.lightGray, for: .disabled)
        button.isEnabled = false
        return button
    }()
    
    //MARK: -LifyCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupHierarchy()
        setupLayout()
        

    }
    
    private func setupHierarchy() {
        view.addSubview(saveButton)
    }
    
    private func setupLayout() {
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:  -40).isActive = true
    }

}
