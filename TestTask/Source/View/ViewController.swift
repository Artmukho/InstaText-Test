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
    
    lazy var textView: UITextView = {
        let text = UITextView()
        text.delegate = self
        text.backgroundColor = .systemBackground
        text.font = .systemFont(ofSize: 14)
        text.isScrollEnabled = false
        text.text = "Вставьте сюда текст или начните печатать"
        text.textColor = .lightGray
        text.textContainerInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        text.layer.masksToBounds = false
        text.layer.shadowOffset = CGSize(width: 1, height: 1)
        text.layer.shadowRadius = 1
        text.layer.shadowOpacity = 0.4
        return text
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
        view.addSubview(textView)
    }
    
    private func setupLayout() {
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:  -40).isActive = true
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
    }

}

//MARK: - Extensions

extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
            
        }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
         return true
        }
    
    func textViewDidChange(_ textView: UITextView) {

        }
}
