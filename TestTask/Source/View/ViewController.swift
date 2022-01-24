//
//  ViewController.swift
//  TestTask
//
//  Created by Artem Muho on 21.01.2022.
//

import UIKit

class ViewController: UIViewController, ViewInput {
    
    //MARK: -Properties
    
    var output: ViewOutput?
    var keyboardIsActive: Bool = false {
        didSet {
            
        }
    }
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.lightGray, for: .disabled)
        button.isEnabled = false
        button.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
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
    
    lazy var toolbar: Toolbar = {
        let bar = Toolbar()
        bar.backgroundColor = .white
        bar.layer.masksToBounds = false
        bar.layer.cornerRadius = 20
        bar.layer.shadowColor = UIColor.purple.cgColor
        bar.layer.shadowOffset = CGSize(width: 0, height: 1)
        bar.layer.shadowOpacity = 0.2
        bar.keyboardButton.addTarget(self, action: #selector(keyboardButtonAction), for: .touchUpInside)
        return bar
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
        view.addSubview(toolbar)
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
        
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        toolbar.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        toolbar.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    // MARK: - Functions
    
    func takePicture() {
        UIGraphicsBeginImageContextWithOptions(textView.bounds.size, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        textView.layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    func prepareTextToImage() {
        let text = textView.text
        textView.text = ""
        textView.text = text
    }
    
    func selectDisabled() {
        textView.isSelectable = false
        textView.spellCheckingType = .no
    }
    
    func editEnabled() {
        textView.isEditable = true
        textView.spellCheckingType = .default
    }
    
    func showKeyboard() {
        textView.becomeFirstResponder()
        keyboardIsActive = true

    }
    
    func hideKeyboard() {
        textView.resignFirstResponder()
        keyboardIsActive = false

    }
    //MARK: - Actions
    
    @objc func saveButtonAction() {
        output?.saveButtonAction()
    }
    
    @objc func keyboardButtonAction() {
        keyboardIsActive ? hideKeyboard() : showKeyboard()
    }

}

//MARK: - Extensions

extension ViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if  textView.text == "Вставьте сюда текст или начните печатать" {
            textView.text = " "
            textView.textColor = .darkGray
            keyboardIsActive = true
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text == "" {
            textView.resignFirstResponder()
            keyboardIsActive = false
            textView.text = "Вставьте сюда текст или начните печатать"
            textView.textColor = .lightGray
        }
         return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        saveButton.isEnabled = textView.text.isEmpty ? false : true
    }
}
