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
            toolbar.keyboardButton.tintColor = keyboardIsActive ? UIColor.purple : UIColor.lightGray
        }
    }
    var fontChangeIsActive: Bool = false {
        didSet {
            toolbar.fontChangeButton.tintColor = fontChangeIsActive ? UIColor.purple : UIColor.lightGray
        }
    }
    var keyboardFrameHeight: CGFloat = 0
    
    lazy var textFontChangeView = TextFontChangeCollectionView()
    
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
        text.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        text.isScrollEnabled = false
        text.text = "Вставьте сюда текст или начните печатать"
        text.textColor = .lightGray
        text.textContainerInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
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
        bar.fontChangeButton.addTarget(self, action: #selector(fontChangeButtonAction), for: .touchUpInside)
        return bar
    }()
    
    //MARK: -LifyCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupHierarchy()
        setupLayout()
        registerForKeyboardNotifications()
    }
    
    deinit {
        removeKeyboardNotification()
    }
    
    private func setupHierarchy() {
        view.addSubview(saveButton)
        view.addSubview(textView)
        view.addSubview(toolbar)
        view.addSubview(textFontChangeView)
    }
    
    private func setupLayout() {
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:  -40).isActive = true
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        textView.heightAnchor.constraint(equalTo: textView.widthAnchor).isActive = true
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.bounds.width * 0.2).isActive = true
        
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        toolbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        toolbar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        toolbar.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        textFontChangeView.translatesAutoresizingMaskIntoConstraints = false
        textFontChangeView.topAnchor.constraint(equalTo: toolbar.bottomAnchor, constant:  -10).isActive = true
        textFontChangeView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textFontChangeView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        textFontChangeView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
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
    // Keyboard
    func showKeyboard(frame: CGFloat) {
        toolbar.transform = CGAffineTransform(translationX: 0, y: frame)
        textView.transform = CGAffineTransform(translationX: 0, y: -50)
        keyboardIsActive = true
        fontChangeIsActive = false
    }
    
    func hideKeyboard() {
        textView.resignFirstResponder()
        keyboardIsActive = false
    }
    // FontChange Menu
    func showFontChangeMenu() {
        fontChangeIsActive = true
        if keyboardIsActive {
            textView.resignFirstResponder()
            toolbar.transform = CGAffineTransform(translationX: 0, y: -view.bounds.height * 0.4)
            textFontChangeView.transform = CGAffineTransform(translationX: 0, y: -view.bounds.height * 0.4)
            textView.transform = CGAffineTransform(translationX: 0, y: -50)
        } else {
            toolbar.transform = CGAffineTransform(translationX: 0, y: -view.bounds.height * 0.4)
            textFontChangeView.transform = CGAffineTransform(translationX: 0, y: -view.bounds.height * 0.4)
            textView.transform = CGAffineTransform(translationX: 0, y: -50)
        }
    }
    
    func hideFontChangeMenu() {
        toolbar.transform = CGAffineTransform.identity
        textFontChangeView.transform = CGAffineTransform.identity
        textView.transform = CGAffineTransform.identity
        fontChangeIsActive = false
    }
    // Notification
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        let userInfo = notification.userInfo
        if let frame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = -frame.height * 0.98
            keyboardFrameHeight = keyboardHeight
            showKeyboard(frame: keyboardHeight)
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        toolbar.transform = CGAffineTransform.identity
        textView.transform = CGAffineTransform.identity
        keyboardIsActive = false
        if textView.text == " " {
            textView.text = "Вставьте сюда текст или начните печатать"
        } else if textView.text == "" {
            textView.text = "Вставьте сюда текст или начните печатать"
        }
    }

    //MARK: - Actions
    
    @objc func saveButtonAction() {
        output?.saveButtonAction()
    }
    
    @objc func keyboardButtonAction() {
        if keyboardIsActive {
            textView.resignFirstResponder()
        } else {
            textView.becomeFirstResponder()
        }
    }
    
    @objc func fontChangeButtonAction() {
        fontChangeIsActive ? hideFontChangeMenu() : showFontChangeMenu()
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
